import { useEffect, useState } from 'react';
import axios from 'axios';
// import './UserList.css'; // Add a CSS file for styling

const baseURL = import.meta.env.VITE_API_BASE_URL || '';

const UserList = () => {
    const [users, setUsers] = useState([]);
    const [form, setForm] = useState({ name: '', email: '' });

    useEffect(() => {
        fetchUsers();
    }, []);

    const fetchUsers = async () => {
        try {
            const response = await axios.get(`${baseURL}/users`);
            setUsers(response.data);
        } catch (error) {
            console.error('Error fetching users:', error);
        }
    };

    const createUser = async () => {
        if (!form.name || !form.email) return;
        try {
            await axios.post(`${baseURL}/users`, form);
            setForm({ name: '', email: '' });
            fetchUsers();
        } catch (error) {
            console.error('Error creating user:', error);
        }
    };

    const deleteUser = async (id) => {
        try {
            await axios.delete(`${baseURL}/users/${id}`);
            fetchUsers();
        } catch (error) {
            console.error('Error deleting user:', error);
        }
    };

    return (
        <div className="user-list-container">
            <h1>User Management</h1>
            <div className="form-container">
                <input
                    type="text"
                    placeholder="Name"
                    value={form.name}
                    onChange={(e) => setForm({ ...form, name: e.target.value })}
                />
                <input
                    type="email"
                    placeholder="Email"
                    value={form.email}
                    onChange={(e) => setForm({ ...form, email: e.target.value })}
                />
                <button onClick={createUser}>Add User</button>
            </div>
            <div className="user-list">
                {users.map((user) => (
                    <div key={user.id} className="user-item">
                        <span>
                            <strong>{user.name}</strong> - {user.email}
                        </span>
                        <button className="delete-btn" onClick={() => deleteUser(user.id)}>
                            Delete
                        </button>
                    </div>
                ))}
            </div>
        </div>
    );
};

export default UserList;