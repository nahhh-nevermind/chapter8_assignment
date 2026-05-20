<script setup>
import { ref, watch, computed} from 'vue';

const props = defineProps({
    editingEmployee: {type: Object, default: null}
});
const emit = defineEmits(['save', 'cancel']);

const emptyForm = () => ({
    empId: '', name: '', email: '', department: '',position: '', hireDate: '',salary: '', active: true
});

const form = ref(emptyForm());
const errors = ref({});

watch(() => props.editingEmployee, (val) => {
    form.value = val ? {...val} : emptyForm();
    errors.value = {};
}, {immediate: true});

const isEditing = computed(() => Boolean(props.editingEmployee));

const empIdRegex = /^EMP[0-9]{3,5}$/;
const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

function validate(){
    const e = {};
    if(!form.value.empId.trim())
    e.empId = 'Employee ID is required.';
    else if(!empIdRegex.test(form.value.empId.trim().toUpperCase()))
    e.empId = 'Format : EMP001 (First 3 letter must be EMP and 3 digit)';

    if(!form.value.name.trim() || form.value.name.trim().length < 3)
    e.name = 'Name must be at least 3 characters';

    if(!emailRegex.test(form.value.email.trim()))
    e.email = 'Please enter a valid email address.';

    if(!form.value.position.trim())
    e.position = 'Position is required';

    const datetime = new Date();
    if(!form.value.hireDate)
    e.hireDate = 'Hire date is required';
    else if(new Date(form.value.hireDate) > datetime)
    e.hireDate ='Hire date cannot be from the future';

    const salary = Number(form.value.salary);
    if(Number.isNaN(salary) || salary < 1500 || salary > 50000)
    e.salary = 'Salary must be between RM1500 and RM50000';

    errors.value = e;
    return Object.keys(e).length === 0;
}

function onSubmit(){
    if(!validate())
    return;
    emit('save', {
        ...form.value,
        empId: form.value.empId.trim().toUpperCase(),
        name : form.value.name.trim(),
        email: form.value.email.trim(),
        position: form.value.position.trim(),
        hireDate: form.value.hireDate,
        salary: form.value.salary
    })
    if(!isEditing.value)
    form.value = emptyForm();
}

function onCancel(){
    emit('cancel');
    form.value = emptyForm();
    errors.value = {};
}
</script>
