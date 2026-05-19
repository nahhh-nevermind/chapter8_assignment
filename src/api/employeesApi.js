import axios from 'axios'

const apiClient = axios.create({
    baseURL: 'http://localhost:3000',
    timeout: 5000,
    headers:{
        'Content-Type': 'application/json',
        Accept: 'application/json'
    }
})

apiClient.interceptors.request.use(
    (config) => {
        console.log(`[API] ${config.method?.toUpperCase()} ${config.url}`)
        return config
    },
    (error) => Promise.reject(error)
)

apiClient.interceptors.response.use(
    (response) => response,
    (error) => {
        if(error.response){
            console.error(`[API ERROR] ${error.response.status} - ${error.response.statusText}`)
        } else if(error.request){
            console.error('[API ERROR] No response from server (is the API running?)')
        } else {
            console.error('[API ERROR]', error.message)
        }
        return Promise.reject(error)
    }
)

export const getEmployees = (params ={}) => apiClient.get('/employees', {params})
export const getEmployee = (id) => apiClient.get(`/employees/${id}`)
export const createEmployee = (e) => apiClient.post('/employees', e)
export const updateEmployee = (id, e) => apiClient.put(`/employees/${id}`, e)
export const deleteEmployee = (id) => apiClient.delete(`/employees/${id}`)

export default apiClient