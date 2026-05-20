<script setup>
import {ref, onMounted} from 'vue'
import EmployeeForm from './components/EmployeeForm.vue'
import EmployeeList from './components/EmployeeList.vue'
import{
getEmployees, createEmployee, updateEmployee, deleteEmployee
} from './api/employeesApi.js';

const employees = ref([]);
const editingEmployee = ref(null);
const loading = ref(false);
const errorMsg = ref('');

async function load(){
    loading.value = true;
    errorMsg.value = '';

    try{
        const{data} = await getEmployees();
        employees.value = data;
    } catch (err) {
        errorMsg.value = 'Failed to load employees. Is the API running on :3000?';
    } finally {
        loading.value = false;
    }
}

async function handleSave(payload){
    try{
        if(editingEmployee.value){
            await updateEmployee(editingEmployee.value.id, payload);
            editingEmployee.value = null;
        } else {
            await createEmployee(payload);
        }
        await load()
    } catch (err) {
        console.error(err)
        errorMsg.value = 'Save failed. Check the console for details.';
    }
}

function handleEdit(e){
    editingEmployee.value = {...e, hireDate: e.hireDate ? e.hireDate.substring(0, 10):''};
}

function handleCancel(){
    editingEmployee.value = null;
}

async function handleDelete(id){
    if(!confirm('Delete this employee? This cannot be undone'))
        return;
    try{
        await deleteEmployee(id);
        await load();
    } catch {
        errorMsg.value = 'Delete failed.'
    }
}

onMounted(load)
</script>

<template>
    <header>
        <h1>Employees Directory</h1>
    <p class="subtitle">Employees data management system</p>
    </header>

    <main>
        <p v-if="loading" class="loading">Loading...</p>
        <p v-if="errorMsg" class="error">{{ errorMsg }}</p>

        <EmployeeForm
        :editingEmployee="editingEmployee"
        @save="handleSave"
        @cancel="handleCancel"/>

        <EmployeeList
        :employees="employees"
        @edit="handleEdit"
        @delete="handleDelete"/>
    </main>
</template>
