import 'package:flutter/material.dart';
import '../../models/certificate.dart';
import '../../models/experience.dart';
import '../../models/project.dart';
import '../../models/skill.dart';

const String developerName = 'Raj Dutta';
const String developerTitle = 'Systems Engineer & Full Stack Specialist';
const String tagline =
    'Architecting Scalable Ecosystems with Flutter, FastAPI & AI Integration';

const String aboutText =
    'I am a results-driven Systems Engineer and Full Stack Developer dedicated to architecting production-grade solutions across the entire digital spectrum. With a foundation in Computer Applications (BCA) and a specialization in Flutter and Python ecosystems (FastAPI/Flask), I build scalable, high-performance applications anchored in clean architecture and intuitive UX design. My engineering philosophy revolves around translating complex business logic into maintainable, robust, and elegant digital products. Beyond development, I am deeply invested in the intersection of Artificial Intelligence and Software Engineering, constantly exploring emerging technologies to solve real-world problems and deliver high-impact value through code.';

const String resumeUrl = 'https://example.com/raj-dutta-resume.pdf';
const String resumeAsset = 'assets/resume.pdf';
const String email = 'rajdutta372@gmail.com';
const String linkedinUrl = 'https://www.facebook.com/share/1BXp5zTrpN/';
const String githubUrl = 'https://github.com/rajdutta234';
const String facebookUrl =
    'https://www.facebook.com/share/1L4awnkpvY/?mibextid=wwXIfr';
const String instagramUrl =
    'https://www.instagram.com/_raj_dutta_?igsh=MTN1NGR6MDYweTZvcA%3D%3D&utm_source=qr';

const List<String> navItems = <String>[
  'Home',
  'About',
  'Experience',
  'Work',
  'Contact',
];

final List<SkillCategory> skills = <SkillCategory>[
  SkillCategory(
    title: 'Languages',
    icon: Icons.code,
    skills: const <SkillItem>[
      SkillItem(name: 'Dart', icon: Icons.code, proficiency: 0.95),
      SkillItem(name: 'Python', icon: Icons.code, proficiency: 0.9),
      SkillItem(name: 'Java', icon: Icons.code, proficiency: 0.8),
      SkillItem(name: 'Flutter', icon: Icons.flutter_dash, proficiency: 0.95),
    ],
  ),
  SkillCategory(
    title: 'Frontend',
    icon: Icons.web,
    skills: const <SkillItem>[
      SkillItem(
        name: 'Flutter (Web, Desktop, Mobile)',
        icon: Icons.flutter_dash,
        proficiency: 0.95,
      ),
      SkillItem(name: 'HTML/CSS', icon: Icons.language, proficiency: 0.9),
      SkillItem(name: 'JavaScript', icon: Icons.javascript, proficiency: 0.85),
    ],
  ),
  SkillCategory(
    title: 'Backend & State Mgmt',
    icon: Icons.dns,
    skills: const <SkillItem>[
      SkillItem(name: 'Flask', icon: Icons.api, proficiency: 0.9),
      SkillItem(name: 'FastAPI', icon: Icons.bolt, proficiency: 0.88),
      SkillItem(name: 'Riverpod', icon: Icons.layers, proficiency: 0.92),
      SkillItem(name: 'GetX', icon: Icons.layers, proficiency: 0.92),
      SkillItem(name: 'GoRouter', icon: Icons.route, proficiency: 0.88),
    ],
  ),
  SkillCategory(
    title: 'Databases',
    icon: Icons.storage,
    skills: const <SkillItem>[
      SkillItem(name: 'PostgreSQL', icon: Icons.storage, proficiency: 0.85),
      SkillItem(name: 'MySQL', icon: Icons.storage, proficiency: 0.9),
      SkillItem(name: 'SQLAlchemy', icon: Icons.storage, proficiency: 0.88),
    ],
  ),
  SkillCategory(
    title: 'Tools & Core Skills',
    icon: Icons.terminal,
    skills: const <SkillItem>[
      SkillItem(name: 'Git & GitHub', icon: Icons.terminal, proficiency: 0.9),
      SkillItem(
        name: 'Google Play Console',
        icon: Icons.settings_applications,
        proficiency: 0.85,
      ),
      SkillItem(
        name: 'UI/UX & Responsive Design',
        icon: Icons.design_services,
        proficiency: 0.9,
      ),
      SkillItem(
        name: 'RBAC & Modular Architecture',
        icon: Icons.security,
        proficiency: 0.88,
      ),
      SkillItem(name: 'MS Office', icon: Icons.description, proficiency: 0.9),
    ],
  ),
];

const List<Experience> experiences = <Experience>[
  Experience(
    organization: 'NAIYO24 PRIVATE LIMITED',
    role: 'Full Stack Developer Intern',
    duration: '3 Months (Apr 2026 – Present)',
    description: <String>[
      'Architected and maintained full-stack administrative ecosystems using Flutter for Web and Desktop platforms.',
      'Designed highly modular, reusable UI component libraries following a strict design system for high-scale enterprise apps.',
      'Implemented robust Role-Based Access Control (RBAC) and complex workflow-driven business modules.',
      'Spearheaded the development of the Hospital Management and Pharmacy Admin systems with end-to-end operational logic.',
    ],
  ),
  Experience(
    organization: 'Euphoria GenX / Techno Exponent',
    role: 'Web Development Intern',
    duration: 'Training + Internship (Dec 2024 – Sept 2025)',
    description: <String>[
      'Underwent intensive industrial training in Python Django with a focus on AI integration and backend scalability.',
      'Developed and deployed the Blood Bank Management System, handling full-stack request and donor lifecycles.',
      'Mastered relational database management and server-side logic in a production-simulated environment.',
    ],
  ),
  Experience(
    organization: 'Sales Assistant',
    role: 'Sales Representative Assistant',
    duration: 'Jan 2021 – Jan 2022',
    description: <String>[
      'Managed client communications and led high-impact product demonstrations to potential customers.',
      'Assisted in sales pipeline management and customer relationship maintenance.',
    ],
  ),
];

const List<Project> projects = <Project>[
  // NAIYO24 Projects
  Project(
    title: 'OEMS Admin Panel',
    description:
        'A modern Flutter-based dealership and showroom management dashboard built for cross-platform environments. The system centralizes vehicle inventory, customer management, enquiries, bookings, analytics, and financial operations into a scalable solution. The platform was designed to streamline the entire dealership ecosystem, covering everything from secure authentication and role-based access to real-time KPI tracking and multi-platform delivery pipeline monitoring across Web, Android, iOS, and Desktop.',
    stack: <String>['Flutter', 'GetX', 'MVC', 'Material 3'],
    githubUrl: '',
    demoUrl: '',
    imageUrl: 'assets/images/oems_admin_pannel_photo.jpeg',
    contributions: [
      'Designed and developed responsive UI for Web, Android, iOS, Windows, macOS, and Linux platforms using Flutter.',
      'Implemented scalable frontend architecture using GetX state management and MVC pattern for multi-tenant dealership handling.',
      'Built secure authentication flows including PIN-based login, password recovery, and role-based access control (RBAC).',
      'Developed real-time dashboard analytics with KPI cards, activity tracking, charts, and operational insights.',
      'Created CRM modules with filtering, sorting, status tracking, and transaction history for customer engagement.',
      'Built vehicle inventory management system for both sales and rental operations with availability tracking.',
      'Implemented enquiry and booking workflows with delivery pipeline tracking (Enquiry → Booking → Delivery).',
      'Developed financial management interfaces for transactions, payouts, revenue analytics, and reports.',
      'Designed showroom profile management with document verification and certification tracking.',
      'Integrated responsive layouts and reusable widgets to ensure maintainability and high-performance rendering.',
    ],
    impact: [
      'Improved operational efficiency by centralizing showroom and customer management into a single dashboard.',
      'Streamlined business workflows through automation of sales and rental pipelines.',
      'Delivered a scalable and maintainable frontend architecture capable of multi-tenant dealership expansion.',
    ],
  ),
  Project(
    title: 'Pharmacy Admin Management Panel',
    description:
        'The Pharmacy Admin Management Panel is a comprehensive web-based system designed to digitize and streamline medical store operations. Built using Flutter and GetX, the application provides a complete workflow covering sales, inventory management, supplier procurement, prescription handling, customer credit tracking, and reporting. The platform features a modular architecture where each business module—from sales and stock alerts to the end-to-end purchase cycle (PO → GRN → Invoice)—is separated for maintainability and seamless backend integration.',
    stack: <String>['Flutter (Dart)', 'GetX', 'Web/Desktop'],
    githubUrl: '',
    demoUrl: '',
    imageUrl: 'assets/images/pharmacy_admin_pannel_photo.jpeg',
    contributions: [
      'Developed a full-scale pharmacy management system covering sales, inventory, suppliers, prescriptions, and reporting.',
      'Built modular architecture using GetX for efficient state management, dependency injection, and clean routing.',
      'Implemented end-to-end procurement workflows: Purchase Order (PO) → Goods Receipt Note (GRN) → Invoice.',
      'Designed a comprehensive inventory system with medicine cataloging, batch tracking, expiry monitoring, and stock alerts.',
      'Created a digital prescription workflow including upload, clinical verification, and controlled sales processing.',
      'Developed a customer credit management system for tracking outstanding balances and payment history.',
      'Designed a responsive admin dashboard UI with real-time KPIs, revenue charts, and operational analytics.',
      'Structured application with controller-based architecture ensuring high maintainability and backend integration readiness.',
    ],
    impact: [
      'Digitized entire pharmacy operations, significantly reducing manual tracking and paperwork.',
      'Enabled data-driven decisions through real-time analytics and inventory insights.',
      'Designed a scalable system ready for multi-store or chain-level operations.',
    ],
  ),
  Project(
    title: 'Hospital Management Admin Panel',
    description:
        'A production-grade hospital administration panel designed to streamline clinical, operational, and administrative workflows across hospitals and clinics. The system centralizes patient management, emergency handling, billing, lab operations, and reporting into a high-performance unified dashboard. Built with a focus on performance and modularity, it handles the entire patient journey from registration and emergency triage to doctor allocation and lab reporting, all while maintaining strict Role-Based Access Control (RBAC) to ensure data security and departmental coordination.',
    stack: <String>['Flutter (Dart)', 'Riverpod', 'Web & Desktop'],
    githubUrl: '',
    demoUrl: '',
    imageUrl: 'assets/images/hospital_pannel_photo.jpeg',
    contributions: [
      'Designed and implemented complete UI/UX architecture for complex hospital workflows (OPD, IPD, and Emergency).',
      'Built scalable state management using Riverpod, ensuring clean separation of business logic and UI components.',
      'Implemented an advanced Emergency Triage System with real-time vitals tracking and bed allocation logic.',
      'Developed Role-Based Access Control (RBAC) with permission-level routing and live access preview for staff roles.',
      'Created end-to-end workflows: Patient Registration → Doctor Allocation → Prescription → Lab → Billing.',
      'Built advanced rich text template editors for medical prescriptions and billing with formatting and media support.',
      'Optimized dashboard performance for handling large-scale patient datasets and real-time operational updates.',
      'Architected the application with an API-first approach, ensuring seamless integration with backend healthcare services.',
    ],
    impact: [
      'Digitized hospital operations, reducing manual workload and improving cross-departmental communication.',
      'Improved data accuracy and accessibility for critical patient records and clinical workflows.',
      'Engineered a secure multi-role environment that ensures data privacy and controlled visibility across the facility.',
    ],
  ),
  Project(
    title: 'Screen Recorder Doctor',
    description:
        'A feature-rich mobile application focused on high-fidelity screen recording, media management, and real-time team collaboration. The app combines productivity and communication by enabling users to capture screen activity, manage recording history, and collaborate through chat and video call interfaces within a unified, modern environment. Built using Riverpod and GoRouter, the application delivers a seamless experience with smooth animations, dark/light mode support, and interactive media controls designed for high-performance mobile multitasking.',
    stack: <String>['Flutter', 'Riverpod', 'GoRouter', 'Camera API'],
    githubUrl: '',
    demoUrl: '',
    imageUrl: 'assets/images/screen_recorder_photo.jpeg',
    contributions: [
      'Designed and developed a full Flutter-based UI system with modern, responsive layouts and fluid animations.',
      'Implemented screen recording workflows including capture controls, instant preview, and history management.',
      'Built a real-time chat interface with support for text messaging, media sharing, and group-based collaboration.',
      'Integrated video call UI flows with interactive controls and live camera preview using advanced media plugins.',
      'Developed media handling features including video playback, gallery integration, and trimming interfaces.',
      'Created a scalable project structure using Riverpod for state management and GoRouter for deep-link navigation.',
      'Designed a consistent theme system (Light/Dark mode) that maintains visual integrity across all features.',
    ],
    impact: [
      'Combined productivity (recording) and collaboration (chat/calls) into a single, high-performance mobile application.',
      'Enhanced user engagement with a modern UI/UX designed for seamless multitasking.',
    ],
  ),

  // Self-Made Projects
  Project(
    title: 'Advanced Calculator App',
    description:
        'A modern, high-performance calculator application designed to deliver both everyday usability and advanced mathematical functionality through a clean, responsive Material 3 interface. Built entirely with Flutter and GetX, the app demonstrates strong fundamentals in state management, real-time expression parsing, and application architecture. It supports dual modes (Standard and Scientific), persistent calculation history with instant recall, and smooth UI animations, showcasing a mastery of complex logic-driven mobile applications.',
    stack: <String>['Flutter', 'GetX', 'math_expressions', 'Material 3'],
    githubUrl: 'https://github.com/rajdutta234/calculator',
    demoUrl: '',
    imageUrl: 'assets/images/calculator_photo.jpeg',
    contributions: [
      'Developed a feature-rich calculator using Flutter with GetX for reactive UI updates and efficient state management.',
      'Implemented Standard, Scientific, and History modes supporting complex operations (Trigonometry, Logarithms, Factorials, Powers).',
      'Built a real-time expression evaluation system using math_expressions for accurate and instant calculations.',
      'Designed a modern Material 3 UI with smooth animations, glassmorphism elements, and responsive layouts.',
      'Engineered a persistent calculation history system with instant recall and state synchronization across sessions.',
      'Applied MVVM architecture to ensure a clean, scalable, and maintainable code structure.',
    ],
    impact: [
      'Demonstrated the ability to build logic-heavy applications with complex mathematical processing.',
      'Showcased expertise in modern UI design patterns (Material 3) and reactive state management.',
    ],
  ),
  Project(
    title: 'U2Me — Dating App Prototype',
    description:
        'U2Me is a modern dating and social discovery mobile application prototype designed to simulate real-world social networking workflows. The application features email/password authentication, a detailed user onboarding process, and a swipe-based discovery system with match simulation logic. Built using GetX architecture and responsive design principles, the project demonstrates scalable frontend development and engaging user experience design, including local messaging interactions and profile management with persistent session handling.',
    stack: <String>['Flutter', 'GetX', 'SharedPreferences', 'MVC'],
    githubUrl: 'https://github.com/rajdutta234/u2me',
    demoUrl: '',
    imageUrl: 'assets/images/u2me_photo.jpeg',
    contributions: [
      'Designed and developed the complete frontend architecture using Flutter and Dart for a mobile-first experience.',
      'Built comprehensive authentication flows including Login, Signup, Demo Account access, and session handling.',
      'Implemented a detailed onboarding workflow for collecting user profile data, interests, and preferences.',
      'Developed a swipe-based profile discovery system with reactive match simulation logic.',
      'Created profile management modules allowing users to edit bios, interests, photos, and personal info.',
      'Built local match and messaging interfaces with a modern chat UI for simulated user interactions.',
      'Implemented persistent local session management using SharedPreferences for a seamless user experience.',
      'Structured the application using modular MVC architecture with GetX dependency injection.',
    ],
    impact: [
      'Showcased modern social networking UX patterns, including complex gesture-based (swipe) interactions.',
      'Strengthened expertise in building scalable, modular frontend structures for large-scale mobile apps.',
    ],
  ),
  Project(
    title: 'INEWS — Intelligent News Reader',
    description:
        'INEWS is a sleek, intelligent news reading application delivering a personalized and accessible experience. Built with Flutter and GetX, the app combines clean UI/UX design with interactive social features like article reactions and bookmarking. Key highlights include AI-powered article summaries for quick consumption and Text-to-Speech (TTS) integration for enhanced accessibility. The application is fully responsive across mobile, web, and desktop, using GetStorage for local persistence and a reactive state management system to ensure smooth navigation.',
    stack: <String>['Flutter', 'GetX', 'GetStorage', 'TTS'],
    githubUrl: 'https://github.com/rajdutta234/inews',
    demoUrl: '',
    imageUrl: 'assets/images/inews_photo.jpeg',
    contributions: [
      'Developed a fully responsive cross-platform news application (Mobile, Web, Desktop) using Flutter.',
      'Designed a sleek, modern UI with dark/light mode support and high-performance rendering.',
      'Integrated AI-powered summaries and Text-to-Speech (TTS) news reading for improved accessibility.',
      'Built interactive social features including likes, comments, bookmarks, and category-based article filtering.',
      'Implemented local data persistence using GetStorage for saved articles and user preferences.',
      'Used GetX for reactive state management, centralized routing, and dependency injection.',
      'Created a component-based UI architecture to ensure cross-platform consistency and maintainability.',
    ],
    impact: [
      'Enhanced news consumption through AI-driven content summaries and accessible reading features (TTS).',
      'Delivered an engaging, high-performance user experience with smooth navigation and real-time state updates.',
    ],
  ),
  Project(
    title: 'Premium E-Commerce Mobile App',
    description:
        'A production-style e-commerce application simulating a complete shopping journey with a focus on performance, scalability, and premium user experience. This app covers the entire user flow—from authentication and product discovery to a dynamic cart system and multi-step checkout with various payment methods. Built using GetX for state management and routing, it features high-performance UI components like search debouncing, wishlist synchronization, and persistent local storage, showcasing a scalable frontend architecture ready for production-level API integration.',
    stack: <String>['Flutter', 'GetX', 'SharedPreferences'],
    githubUrl: 'https://github.com/rajdutta234/ecommerce',
    demoUrl: '',
    imageUrl: 'assets/images/e-commerce_photo.jpeg',
    contributions: [
      'Built a full-featured e-commerce app with 8+ core modules including Auth, Discovery, Cart, Checkout, and Profile.',
      'Implemented real-time reactive UI elements: cart updates, debounced search, and wishlist synchronization.',
      'Designed a multi-step checkout system supporting various payment methods (Card, UPI, Wallet, COD).',
      'Developed advanced UI/UX patterns including animated transitions, swipe-to-delete, and dynamic search overlays.',
      'Integrated persistent login and local storage using SharedPreferences for data continuity.',
      'Architected a modular and scalable codebase with a clean separation of concerns and reusable widget system.',
    ],
    impact: [
      'Demonstrated mastery of real-world commerce workflows and user experience optimization.',
      'Developed a production-ready frontend architecture ready for large-scale API integration.',
    ],
  ),

  // Internship Project
  Project(
    title: 'Blood Bank Management System',
    description:
        'A full-stack administrative management system developed during training to digitize blood donation operations. Built with Python Django and MySQL, the platform manages the entire request lifecycle, donor record-keeping, and facility coordination. The system features a secure role-based dashboard for both administrators and donors, ensuring efficient matching and tracking of blood requests. It showcases the integration of complex backend logic with real-world administrative needs, providing a scalable solution for healthcare record management.',
    stack: <String>['Python', 'Django', 'MySQL', 'Bootstrap'],
    githubUrl: '',
    demoUrl: 'https://rajdutta.pythonanywhere.com',
    imageUrl: 'assets/images/blood_bank.png',
    contributions: [
      'Trained in Python Django with AI integration, applying these skills to build a functional management system.',
      'Developed a full-stack blood bank management platform with record keeping and request lifecycle tracking.',
      'Implemented secure authentication and role-based dashboard views for donors and administrators.',
      'Designed and managed relational database schemas using MySQL for efficient data storage.',
      'Built a responsive web frontend using Django templates and Bootstrap for a clean administrative interface.',
    ],
    impact: [
      'Digitized blood bank operations, enabling faster matching and better record-keeping for donation events.',
      'Showcased the ability to bridge backend logic (Django) with real-world administrative needs.',
    ],
  ),
];

const List<Certificate> certificates = <Certificate>[
  Certificate(
    title: 'Full Stack Development Internship',
    issuer: 'NAIYO24 PRIVATE LIMITED',
    imageUrl: 'assets/images/Naiyo24_Internship_Training_Certificate_photo.PNG',
  ),
  Certificate(
    title: 'Web Development & Industrial Training',
    issuer: 'Euphoria GenX / Techno Exponent',
    imageUrl:
        'assets/images/Exphoria_Industrial_Training_Certificate_photo.jpeg',
  ),
  Certificate(
    title: 'Web Development Internship',
    issuer: 'Euphoria GenX / Techno Exponent',
    imageUrl: 'assets/images/Exphoria_Internship_Certificate_photo.jpeg',
  ),
  Certificate(
    title: 'Smart India Hackathon 2025',
    issuer: 'MoE, Govt. of India',
    imageUrl: 'assets/images/Hackathon_College_Certificate_photo.PNG',
  ),
  Certificate(
    title: 'SAMARPAN’25 Participation',
    issuer: 'FIEM, Dept. of Computer Applications',
    imageUrl: 'assets/images/Samarpan_College_Certificate_photo.PNG',
  ),
];
