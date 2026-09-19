# TaskSync Backend API (`tasksync-api`)

REST API built with **Go**, **PostgreSQL**, **GORM**, and **Docker**.

---

## 💡 Database Choice & Justification

### PostgreSQL
- **Why PostgreSQL**: Selected for robust ACID compliance, reliable relational schema enforcement (Users & Tasks), and seamless containerized execution with Docker.

---

## 🚀 Setup Steps

### 1. Run Database Migrations
```bash
docker compose --profile migration run --rm migrate
```

### 2. Start API Service
```bash
docker compose up -d
```
> **Server Base URL**: `http://localhost:3000`

---

## 📡 API Endpoints

### 🟢 System Health
| Method | Endpoint | Description | Request Body |
| :--- | :--- | :--- | :--- |
| `GET` | `/health` | Check API status | - |
| `GET` | `/ready` | Check DB status | - |

### 🔐 Authentication
| Method | Endpoint | Description | Request Body |
| :--- | :--- | :--- | :--- |
| `POST` | `/api/v1/auth/register` | Register user | `{ "fullname": "John Doe", "email": "john@example.com", "password": "password123" }` |
| `POST` | `/api/v1/auth/login` | Login user (returns JWT token) | `{ "email": "john@example.com", "password": "password123" }` |
| `GET` | `/api/v1/auth/me` | Get profile (`Bearer <token>`) | - |

### 📝 Tasks (`Authorization: Bearer <token>`)
| Method | Endpoint | Description | Request Body |
| :--- | :--- | :--- | :--- |
| `GET` | `/api/v1/tasks` | Get all user tasks | - |
| `POST` | `/api/v1/tasks` | Create a task | `{ "title": "Buy groceries", "description": "Milk, Eggs", "dueDate": "2026-12-31T23:59:59Z", "isComplete": false }` |
| `GET` | `/api/v1/tasks/{id}` | Get a single task | - |
| `PATCH` | `/api/v1/tasks/{id}` | Update a task | `{ "title": "Updated Title", "isComplete": true }` |
| `DELETE` | `/api/v1/tasks/{id}` | Delete a task | - |
