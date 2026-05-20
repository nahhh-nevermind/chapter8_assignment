<script setup>
defineProps({ employees: { type: Array, required: true } })
const emit = defineEmits(['edit', 'delete'])
</script>

<template>
    <div v-if="!employees.length" class="empty">
        No employees found.
    </div>

    <table v-else class="student-table">
        <thead>
            <tr>
                <th>Employee ID</th>
                <th>Name</th>
                <th>Department</th>
                <th>Position</th>
                <th>Hire Date</th>
                <th>Salary</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <tr v-for="e in employees" :key="e.id">
                <td><code>{{ e.empId }}</code></td>
                <td>
                    <strong>{{ e.name }}</strong>
                    <div class="muted">{{ e.email }}</div>
                </td>
                <td>{{ e.department }}</td>
                <td>{{ e.position }}</td>
                <td>{{ e.hireDate }}</td>
                <td>RM{{ Number(e.salary).toFixed(2) }}</td>
                <td>
                    <span :class="e.active ? 'badge ok' : 'badge no'">
                        {{ e.active ? 'Active' : 'Inactive' }}
                    </span>
                </td>
                <td>
                    <button @click="emit('edit', e)">Edit</button>
                    <button class="danger" @click="emit('delete', e.id)">Delete</button>
                </td>
            </tr>
        </tbody>
    </table>
</template>
