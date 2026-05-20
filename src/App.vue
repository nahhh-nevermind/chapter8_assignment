<script setup>
import {ref, onMounted} from 'vue'
import EmployeesForm from './components/EmployeesForm.vue'
import EmployeesForm from './components/EmployeesList.vue'
import{
getEmployees, createEmployees, updateEmployees, deleteEmployees
} from './api/employeeApi.js';

const employees = ref([]);
const editingEmployees = ref(null);
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
        if(editingEmployees.value){
            await updateEmployees(editingEmployees.value.id, payload);
            editingEmployees.value = null;
        } else {
            await createEmployees(payload);
        }
        await load()
    } catch (err) {
        errorMsg.value = 'Save failed. Check the console for details.';
    }
}

function handleEdit(e){
    editingEmployees.value = {...e};
}

function handleCancel(){
    editingEmployees.value = null;
}

async function handleDelete(id){
    if(!confirm('Delete this employee? This cannot be undone'))
    return;
    try{
        await deleteEmployees(id);
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

        <StudentForm
        :editingEmployees="editingEmployees"
        @save="handleSave"
        @cancel="handleCancel"/>

        <StudentList
        :students="students"
        @edit="handleEdit"
        @delete="handleDelete"/>
    </main>
</template>
