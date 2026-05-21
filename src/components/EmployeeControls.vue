<script setup>
import { ref } from 'vue';

const emit = defineEmits(['filter-change']);

const searchQuery = ref('');
const currentSort = ref('name');

function onControlChange(event, type) {
    if(type === 'search'){
        searchQuery.value = event.target.value;
    }
    else if(type === 'sort'){
        currentSort.value = event.target.value;
    }

    emit('filter-change', {
        q: searchQuery.value.trim(),
        sortBy: currentSort.value
    });
}
</script>

<template>
    <div class="controls-wrapper">
        <label>
            Search:
            <input :value="searchQuery" @input="onControlChange($event, 'search')" />
        </label>

        <label>
            Sort By:
            <select :value="currentSort" @change="onControlChange($event, 'sort')">
                <option value="name">Name</option>
                <option value="empId">Employee ID</option>
                <option value="hireDate">Hire Date</option>
                <option value="position">Position</option>
            </select>
        </label>
    </div>
</template>
