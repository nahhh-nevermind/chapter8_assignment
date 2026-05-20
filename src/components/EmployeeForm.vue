<script setup>
import { ref, watch, computed } from 'vue';

const props = defineProps({
    editingEmployee: { type: Object, default: null }
});
const emit = defineEmits(['save', 'cancel']);

const emptyForm = () => ({
    empId: '', name: '', email: '', department: '', position: '', hireDate: '', salary: '', active: true
});

const form = ref(emptyForm());
const errors = ref({});

watch(() => props.editingEmployee, (val) => {
    form.value = val ? { ...val } : emptyForm();
    errors.value = {};
}, { immediate: true });

const isEditing = computed(() => Boolean(props.editingEmployee));

const empIdRegex = /^EMP[0-9]{3,5}$/;
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

function validate() {
    const e = {};
    if (!form.value.empId.trim())
        e.empId = 'Employee ID is required.';
    else if (!empIdRegex.test(form.value.empId.trim().toUpperCase()))
        e.empId = 'Format : EMP001 (First 3 letter must be EMP and 3 digit)';

    if (!form.value.name.trim() || form.value.name.trim().length < 3)
        e.name = 'Name must be at least 3 to 5 characters';

    if (!emailRegex.test(form.value.email.trim()))
        e.email = 'Please enter a valid email address.';

    if (!form.value.department)
        e.department = 'Department is required'

    if (!form.value.position.trim())
        e.position = 'Position is required';

    const datetime = new Date();
    datetime.setHours(0,0,0,0);

    if (!form.value.hireDate)
        e.hireDate = 'Hire date is required';
    else if (new Date(form.value.hireDate) > datetime)
        e.hireDate = 'Hire date cannot be from the future';

    const salary = Number(form.value.salary);
    if (Number.isNaN(salary) || salary < 1500 || salary > 50000)
        e.salary = 'Salary must be between RM1500 and RM50000';

    errors.value = e;
    return Object.keys(e).length === 0;
}

function onSubmit() {
    if (!validate())
        return;
    emit('save', {
        ...form.value,
        empId: form.value.empId.trim().toUpperCase(),
        name: form.value.name.trim(),
        email: form.value.email.trim(),
        department: form.value.department,
        position: form.value.position.trim(),
        hireDate: form.value.hireDate,
        salary: Number(form.value.salary)
    })
    if (!isEditing.value)
        form.value = emptyForm();
}

function onCancel() {
    emit('cancel');
    form.value = emptyForm();
    errors.value = {};
}
</script>

<template>
    <form @submit.prevent="onSubmit" class="employee-form">
        <h3>{{ isEditing ? 'Edit Employee' : 'Add New Employee' }}</h3>


        <label>
            Employee ID
            <input v-model.trim="form.empId" placeholder="EMP001" />
            <span v-if="errors.empId" class="err">{{ errors.empId }}</span>
        </label>

        <label>
            Full Name
            <input v-model.trim="form.name" />
            <span v-if="errors.name" class="err">{{ errors.name }}</span>
        </label>

        <label>
            E-mail
            <input v-model.trim="form.email" type="email" />
            <span v-if="errors.email" class="err">{{ errors.email }}</span>
        </label>

        <label>
            Department
            <select v-model="form.department">
                <option value="">Please Select</option>
                <option>IT</option>
                <option>HR</option>
                <option>Finance</option>
                <option>Marketing</option>
                <option>Operation</option>
            </select>
            <span v-if="errors.department" class="err">{{ errors.department }}</span>
        </label>

        <label>
            Position
            <input v-model.trim="form.position" />
            <span v-if="errors.position" class="err">{{ errors.position }}</span>
        </label>

        <label>
            Hire Date
            <input v-model="form.hireDate" type="date" />
            <span v-if="errors.hireDate" class="err">{{ errors.hireDate }}</span>
        </label>

        <label>
            Salary
            <input v-model.number="form.salary">
            <span v-if="errors.salary" class="err">{{ errors.salary }}</span>
        </label>

        <label class="check">
            <input type="checkbox" v-model="form.active" />Active Employee
        </label>

        <div class="actions">
            <button type="submit">{{ isEditing ? 'Update' : 'Add' }}</button>
            <button v-if="isEditing" type="button" @click="onCancel">Cancel</button>
        </div>
    </form>
</template>
