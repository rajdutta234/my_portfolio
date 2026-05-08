# 🚀 Raj Dutta | High-Fidelity Cyber-Glassmorphic Portfolio

[![Flutter](https://img.shields.io/badge/Flutter-v3.11.5+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![Python](https://img.shields.io/badge/Python-3776AB?logo=python&logoColor=white)](https://www.python.org/)
[![FastAPI](https://img.shields.io/badge/FastAPI-005571?logo=fastapi&logoColor=white)](https://fastapi.tiangolo.com/)
[![Flask](https://img.shields.io/badge/Flask-000000?logo=flask&logoColor=white)](https://flask.palletsprojects.com/)

## 🌌 Overview: The Digital Frontier

Welcome to a high-fidelity digital experience designed to push the boundaries of modern web engineering. This portfolio is more than just a resume—it is a showcase of a **"Cyber-Glassmorphic"** design system, built entirely from scratch using the Flutter framework. By blending advanced UI/UX principles with complex mathematical transformations, this project creates an immersive environment that mirrors the precision and innovation of a modern software ecosystem.

Every pixel, animation, and interaction has been choreographed to deliver a premium feel, reflecting my journey as a Full Stack Engineer specialized in high-performance mobile and web solutions.

---

## 🛠️ Technical Architectural Mastery

### 🎨 The "Cyber-Glassmorphic" UI System
At the heart of this portfolio lies a custom-engineered UI system. Utilizing a combination of `BackdropFilter` and complex `BoxDecoration` gradients, the interface achieves a "frosted glass" effect that maintains extreme legibility while allowing the dynamic, particle-driven background to remain visible. The system leverages `flutter_animate` for staggered entrance sequences, ensuring that the interface "unfolds" before the user in a cinematic manner rather than simply appearing.

### ⚙️ Scalable State Management
To handle the complexity of a modern web application, I implemented a robust dual-layer state management system. By utilizing **Provider** for global application states (such as navigation and cursor effects) and **PortfolioProvider** for domain-specific logic (such as dynamic project filtering and tech-stack categorization), the codebase maintains a strict separation of concerns. This ensures that the application remains responsive and maintainable even as more features are added.

### 🐍 Backend & API Expertise
While the frontend is a visual marvel, my engineering core is rooted in powerful backend architectures. I specialize in building high-performance APIs using **Python Flask** and **FastAPI**. My approach focuses on creating scalable, secure, and well-documented server-side ecosystems that integrate seamlessly with frontend clients. Whether it's complex data processing or real-time communication, I prioritize speed, security, and developer-friendly API design.

---

## 🧠 Backend Engine & API Ecosystem

The portfolio is powered by a high-performance **FastAPI** backend that manages data persistence and asynchronous workflows.

### 🛠 API Capabilities
*   **Asynchronous Processing**: Built on `SQLAlchemy 2.0` with `aiosqlite` for non-blocking database operations.
*   **Data Integrity**: Strict validation using **Pydantic v2** models and `EmailStr`.
*   **Automated Documentation**: Interactive Swagger/OpenAPI documentation available for rapid integration testing.
*   **CORS Management**: Securely handles cross-origin requests from the Flutter Web client.

### 🚀 Running the API Locally

1.  **Initialize Environment**:
    ```bash
    cd backend
    python -m venv venv
    source venv/bin/activate  # Or .\venv\Scripts\Activate.ps1 on Windows
    pip install -r requirements.txt
    ```
2.  **Launch Server**:
    ```bash
    python main.py
    ```
3.  **Explore Documentation**:
    *   **Swagger UI**: [http://localhost:8000/docs](http://localhost:8000/docs)
    *   **ReDoc**: [http://localhost:8000/redoc](http://localhost:8000/redoc)

> [!TIP]
> **Accessing the Docs**: If `http://0.0.0.0:8000/docs` does not load in your browser, it is because `0.0.0.0` is the binding address for the server. You should always use **`http://localhost:8000/docs`** or **`http://127.0.0.1:8000/docs`** to access the interactive API documentation on Windows.

### 📡 API Reference

#### 📧 Contact Module
*   **Endpoint**: `POST /api/contact/send`
*   **Summary**: Submit a contact message.
*   **Description**: Receives a contact inquiry (Name, Email, Message), validates the data, and persists it to the database.
*   **Request Body**:
    ```json
    {
      "name": "Your Name",
      "email": "your.email@example.com",
      "message": "Your message here..."
    }
    ```

#### 💓 System Module
*   **Endpoint**: `GET /`
*   **Summary**: Health Check.
*   **Description**: Returns the operational status and connectivity state of the API engine.

---

## 🏗️ Immersive Portfolio Walkthrough

### 1. ⚡ The Hero Sphere (Home)
The entry point of the experience features a custom 3D parallax system. The main profile card employs a `PerspectiveCard` component that calculates real-time 3D tilt based on mouse position using 4x4 matrix transformations. A dynamic `DeveloperTerminal` provides a narrative introduction to my stack, while a holographic 3D astronaut orbits the workspace, symbolizing the exploratory and innovative nature of my work.

### 2. 👨‍💻 Professional Profile (About)
The About section is a data-driven dashboard that quantifies my professional journey. With over **1+ years of experience** and **12+ major projects**, this section highlights key metrics and milestones. It also features a "Beyond Code" card that showcases my personal interests, humanizing the technical expertise and providing a glimpse into the person behind the pixels.

### 3. 🛠️ Portfolio Showcase (Work)
The Showcase is a sophisticated "Three-Tab" interface that centralizes my professional output.
*   **Projects Tab**: A curated gallery of enterprise-grade solutions, including administrative ecosystems and mobile applications. It features a **Dynamic Filtering System** where users can instantly sort projects by technology (e.g., Flutter, Python, Flask).
*   **Certificates Tab**: An interactive wall showcasing industrial training and academic achievements, each presented with a glassmorphic depth effect.
*   **Skills Tab**: A granular breakdown of technical proficiency, categorized by Languages, Frontend, Backend, and professional Tooling.

### 4. 📈 Industrial Journey (Experience)
A structured timeline documenting my time at organizations like **NAIYO24 Private Limited** and **Euphoria GenX**. This section detail's my transition from an intern to a Full Stack Engineer, focusing on the impact I've made—from digitizing automotive showrooms to optimizing clinical workflows in healthcare systems.

---

## 🏢 Featured Enterprise Solutions

### 🏎️ OEMS Admin Panel (Automotive)
A comprehensive management ecosystem for dealerships. This platform centralizes vehicle inventory, multi-tenant customer management, and financial pipelines. Built with **Flutter** and **GetX**, it demonstrates my ability to handle complex, high-scale data operations across Web and Mobile.

### 🏥 Healthcare Management Suite
A suite of administrative tools for hospitals and pharmacies. The **Hospital Panel** manages patient journeys and triage, while the **Pharmacy Panel** automates procurement and batch tracking. This project showcases my mastery of **Riverpod** for secure, scalable healthcare data management.

### 🎥 Screen Recorder Doctor
A specialized mobile app bridging high-fidelity media capture with real-time collaboration. It integrates instant previewing, secure chat, and video calling, using advanced **Camera and Media APIs** for high performance on Android and iOS.

---

## 🚀 Installation & Deployment

To experience the portfolio locally, ensure you have the Flutter SDK installed and follow these steps:

1.  **Clone & Navigate**:
    ```bash
    git clone https://github.com/rajdutta234/my_portfolio.git
    cd my_portfolio
    ```
2.  **Dependency Synchronization**:
    ```bash
    flutter pub get
    ```
3.  **Execute in High-Performance Mode**:
    ```bash
    # For the best experience, use the CanvasKit renderer
    flutter run -d chrome --web-renderer canvaskit
    ```

---

## 📩 Connect & Collaborate

I am always open to discussing innovative projects, technical challenges, or the future of full-stack engineering.

*   **Email**: [rajdutta372@gmail.com](mailto:rajdutta372@gmail.com)
*   **LinkedIn**: [Connect with me](https://www.facebook.com/share/1BXp5zTrpN/)
*   **GitHub**: [@rajdutta234](https://github.com/rajdutta234)
*   **Instagram**: [@_raj_dutta_](https://www.instagram.com/_raj_dutta_)

---

> [!TIP]
> This portfolio is optimized for desktop browsers. For the full experience of parallax layers and 3D interactions, viewing on a high-resolution display is highly recommended.

Developed with 💎 by **Raj Dutta**
