# Portfolio Cinematic Backend 🚀

A high-performance, asynchronous **FastAPI** backend powering the cinematic 3D portfolio ecosystem. This system is engineered for speed, scalability, and seamless integration with Flutter-based frontend architectures.

## 🌌 Core Architecture
- **Asynchronous Execution**: Fully non-blocking I/O using `SQLAlchemy 2.0` (Async) and `aiosqlite`.
- **Robust Validation**: Type-safe data modeling with `Pydantic v2`.
- **Cinematic Integration**: Optimized endpoints for contact persistence and real-time project synchronization.

## 🛠 Tech Stack
- **Framework**: [FastAPI](https://fastapi.tiangolo.com/) (Python 3.10+)
- **Database**: SQLite (Dev) / PostgreSQL (Prod)
- **ORM**: [SQLAlchemy 2.0](https://www.sqlalchemy.org/)
- **Migrations**: [Alembic](https://alembic.sqlalchemy.org/)
- **Environment**: Pydantic Settings & Dotenv

## 📁 Project Structure
```text
backend/
├── main.py           # Application entry point & Documentation Config
├── db.py             # Async Database engine & Session management
├── models/           # SQLAlchemy domain models (User, Message, Project)
├── routes/           # API endpoint controllers (Clean Routing)
├── services/         # Business logic layer (Contact Service, etc.)
├── alembic/          # Database schema versioning
├── .env              # Sensitive environment configuration
└── requirements.txt  # Project dependencies
```

## 🚀 Deployment & Quick Start

### 1. Environment Preparation
```powershell
# Navigate to backend
cd backend

# Create Virtual Environment
python -m venv venv

# Activation (PowerShell)
.\venv\Scripts\Activate.ps1

# Install Dependencies
pip install -r requirements.txt
```

### 2. Launching the Engine
```bash
# Start the development server
python main.py
```

### 3. Interactive Documentation
Once the server is running, you can explore the API using the automated documentation interfaces:
*   **Swagger UI**: [http://localhost:8000/docs](http://localhost:8000/docs)
*   **ReDoc**: [http://localhost:8000/redoc](http://localhost:8000/redoc)

> [!CAUTION]
> **Important Note on Windows Access**: The server binds to `0.0.0.0` to listen on all network interfaces. However, browsers on Windows often fail to resolve `0.0.0.0`. If the docs are "not showing" for you, **DO NOT** use `http://0.0.0.0:8000/docs`. Instead, use **`http://localhost:8000/docs`** or **`http://127.0.0.1:8000/docs`**.

## 📡 API Endpoints

### 📧 Contact Module
- **POST** `/api/contact/send`
  - **Payload**: `{ "name": "string", "email": "user@example.com", "message": "string" }`
  - **Description**: Validates and persists a new contact inquiry to the database.

### 💓 System Module
- **GET** `/`
  - **Description**: Returns the operational status of the API.

## 🔄 Schema Management
```bash
# Generate a new migration
alembic revision --autogenerate -m "Initial schema"

# Apply migrations
alembic upgrade head
```

---
*Engineered with precision by **Raj Dutta**.*
