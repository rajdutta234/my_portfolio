# 🚀 Raj Dutta | Premium Flutter Portfolio

[![Flutter](https://img.shields.io/badge/Flutter-v3.11.5+-02569B?logo=flutter&logoColor=white)](https://flutter.dev)
[![Dart](https://img.shields.io/badge/Dart-0175C2?logo=dart&logoColor=white)](https://dart.dev)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An immersive, motion-driven, and high-fidelity professional portfolio built with **Flutter for Web & Desktop**. This project showcases a blend of advanced UI/UX principles, 3D parallax effects, and complex state management, reflecting my journey as a Full Stack Developer.

---

## ✨ Core Experience Overview

This portfolio is not just a resume; it's a living demonstration of modern web engineering. It features:

*   **Immersive Design System**: A custom-built glassmorphism UI with dynamic mesh backgrounds and magnetic interactions.
*   **Performance Optimized**: Smooth 60FPS animations using `flutter_animate` and custom parallax layers.
*   **Cross-Platform Architecture**: Responsive layouts that adapt seamlessly from mobile to wide-screen desktop monitors.
*   **Premium Interactive Components**: 
    *   `PerspectiveCard`: Real-time 3D tilt interaction based on mouse hover.
    *   `Magnetic`: Elements that subtly attract and follow the cursor for a tactile feel.
    *   `ParallaxLayer`: Depth-based scrolling and mouse-reactive background elements.
    *   `GlassContainer`: Custom glassmorphism implementation with BackdropFilter and gradient borders.
*   **State Management Mastery**: Demonstrates both `Riverpod` and `GetX` implementations across different modules.


---

## 🏗️ Portfolio Sections

### 1. 🌌 The Hero Sphere
The gateway to the portfolio. It features:
*   **3D Parallax Layers**: Multiple background and particle layers that react to mouse movement.
*   **Perspective Transformation**: The main profile card tilts in real-time, creating a sense of depth.
*   **Animated Typing**: A dynamic tagline system that highlights core competencies.

### 2. 👨‍💻 About & Stats
A deep dive into my professional identity.
*   **Career Timeline**: Highlights over 1 year of professional experience and 9+ major projects.
*   **Quick Stats**: Instant visibility into project counts, years of expertise, and awards.

### 3. 🛠️ Expertise & Work (The Dashboard)
A specialized "Three-Tab" interface that centralizes my technical profile:
*   **Projects Tab**: A curated gallery of enterprise-grade admin systems and mobile applications.
*   **Certificates Tab**: An interactive showcase of industrial training and hackathon achievements.
*   **Skills Tab**: Detailed proficiency bars categorized by Languages, Frontend, Backend, and Tools.

### 4. 📈 Professional Experience
A structured timeline of my industrial journey, including:
*   **NAIYO24 Private Limited**: Full Stack Developer Intern (Administrative Ecosystems).
*   **Euphoria GenX / Techno Exponent**: Web Development Intern (Django & AI).

---

## 📂 Featured Projects Showcase

### 🏢 OEMS Admin Panel
*   **Detailed Description**: A comprehensive, production-grade dealership and showroom management ecosystem built to streamline complex automotive business workflows. This platform centralizes vehicle inventory, multi-tenant customer management, real-time enquiries, and financial bookings into a high-performance unified dashboard. It was specifically architected to handle high-scale data operations across Web, Android, iOS, and Desktop environments, ensuring a consistent operational pipeline from initial lead to final delivery.
*   **Tech Stack**: Built with **Flutter** and **GetX** using a modular **MVC** pattern. It leverages **Material 3** principles for a modern, accessible interface while maintaining strict security through PIN-based authentication and Role-Based Access Control (RBAC).
*   **Impact**: Significantly improved showroom operational efficiency by digitizing manual tracking and providing real-time KPI analytics for business owners.

### 🏥 Hospital & Pharmacy Panels
*   **Detailed Description**: A suite of administrative tools designed for the healthcare industry to digitize clinical and operational workflows. The **Hospital Panel** manages the entire patient journey—from emergency triage and doctor allocation to lab reporting and billing—while ensuring strict data privacy. The **Pharmacy Panel** automates the end-to-end procurement cycle, including Purchase Orders (PO), Goods Receipt Notes (GRN), and medicine batch tracking with real-time stock alerts.
*   **Tech Stack**: Implemented with **Riverpod** for the hospital system to ensure scalable state management and **GetX** for the pharmacy system for rapid, reactive UI updates. Both systems feature API-first architectures for seamless backend integration.
*   **Impact**: Transformed healthcare facilities into data-driven environments, reducing paperwork and improving cross-departmental coordination in critical care settings.

### 🎥 Screen Recorder Doctor
*   **Detailed Description**: A specialized mobile application that bridges the gap between high-fidelity media capture and real-time team collaboration. Beyond standard screen recording, the app integrates instant previewing, history management, and a full-scale communication suite including secure chat and video calling interfaces. It is designed for professional environments where capturing and discussing visual feedback needs to be instantaneous and integrated.
*   **Tech Stack**: Powered by **Riverpod** for state persistence and **GoRouter** for deep-link navigation. It uses advanced **Camera and Media APIs** for high-performance recording on Android and iOS.
*   **Impact**: Combined productivity and communication into a single unified mobile experience, reducing the need for multiple disparate apps.

### 📰 iNews & E-Commerce
*   **Detailed Description**: Two distinct consumer-facing applications showcasing mastery in modern mobile features. **iNews** is an intelligent news reader featuring AI-powered article summaries and Text-to-Speech (TTS) for enhanced accessibility. The **E-Commerce** app provides a premium shopping journey with real-time cart synchronization, debounced search overlays, and a secure multi-step checkout pipeline supporting diverse payment methods.
*   **Tech Stack**: Both apps utilize **GetX** for reactive UI and **SharedPreferences** for local persistence. **iNews** specifically integrates advanced TTS and AI-driven summary engines.
*   **Impact**: Delivered high-performance, user-centric mobile experiences that prioritize accessibility and smooth transactional workflows.

---

## 📦 Dependencies & Packages

The project leverages a curated selection of high-performance Flutter packages to deliver a professional-grade user experience:

*   **`flutter_animate` (v4.5.0)**: Used extensively for orchestrating staggered entrance animations, scroll-based reveals, and continuous looping effects. It powers the smooth fading and sliding motions seen in every section, ensuring the UI feels alive and responsive.
*   **`google_fonts` (v6.3.2)**: Integrates premium typography across the portfolio, ensuring high legibility and a modern aesthetic. It allows for dynamic font loading without bloating the asset size.
*   **`provider` (v6.1.5)**: The primary state management solution for the portfolio's global state, handling theme switching, navigation, and application-wide notifications with high efficiency.
*   **`font_awesome_flutter` (v11.0.0)**: Provides access to official brand icons (Instagram, LinkedIn, etc.) for a professional and consistent social media presence.
*   **`url_launcher` (v6.3.1)**: Enables seamless external navigation to resumes, project source codes, and social profiles.
*   **`vector_math` (v2.2.0)**: Essential for the 3D parallax and perspective calculations in the Hero section, providing the mathematical foundation for real-time mouse-reactive transformations.

---

## 🎬 Animation System & UI Dynamics

The portfolio implements a multi-layered animation strategy to achieve a high-end, immersive feel:

### 1. Entrance & Scroll Reveals
Utilizing `flutter_animate`, components are choreographed to enter the viewport with staggered delays. This reduces visual cognitive load while creating a professional "unfolding" effect as the user scrolls.

### 2. 3D Perspective & Mouse Tracking
The `PerspectiveCard` and `ParallaxLayer` components use custom `PointerEvent` listeners to track the cursor's position. This data is normalized and passed into `Transform` widgets using 4x4 matrices (`Matrix4`), creating real-time 3D tilt and depth-based movement.

### 3. Magnetic & Tactile Feedback
The `Magnetic` wrapper uses a spring-physics-based animation to attract elements towards the cursor. This provides subtle tactile feedback, making interactive elements like buttons and icons feel physically "clickable."

### 4. Glassmorphism & Visual Depth
A custom `GlassContainer` component uses `BackdropFilter` for real-time background blurring, combined with semi-transparent gradients and thin borders. This creates a "frosted glass" effect that maintains visual hierarchy while highlighting the dynamic background layers.

---

## 🛠️ Technical Stack & Architecture

| Category | Technologies | Description |
| :--- | :--- | :--- |
| **Frontend** | Flutter (Web/Mobile/Desktop) | The core framework used to build the responsive, high-performance UI across all platforms. |
| **Backend** | Python Django, MySQL | Used in professional projects for robust data handling, authentication, and server-side logic. |
| **State Management**| Riverpod, GetX, Provider | Demonstrates versatility in different state management paradigms for large-scale app scalability. |
| **Architecture** | MVC, MVVM, RBAC | Implemented to ensure clean separation of concerns and secure, role-based user experiences. |
| **Tools** | Git, GoRouter, Flutter Animate | Modern development tools used for version control, deep-link navigation, and UI polish. |


---

## 🚀 Getting Started

### Prerequisites
*   Flutter SDK (^3.11.5)
*   Dart SDK
*   A modern web browser (Chrome recommended)

### Installation
1.  **Clone the repository**:
    ```bash
    git clone https://github.com/rajdutta234/my_portfolio.git
    ```
2.  **Navigate to directory**:
    ```bash
    cd my_portfolio
    ```
3.  **Install dependencies**:
    ```bash
    flutter pub get
    ```
4.  **Run the project**:
    ```bash
    flutter run -d chrome --web-renderer canvaskit
    ```

---

## 📩 Contact & Connect

*   **Email**: rajdutta372@gmail.com
*   **GitHub**: [@rajdutta234](https://github.com/rajdutta234)
*   **LinkedIn**: [Connect with me](https://www.facebook.com/share/1BXp5zTrpN/)
*   **Instagram**: [@_raj_dutta_](https://www.instagram.com/_raj_dutta_)

---

> [!TIP]
> This portfolio is best viewed on Desktop with a high-resolution display to experience the full parallax and glassmorphism effects.

Developed with ❤️ by **Raj Dutta**
