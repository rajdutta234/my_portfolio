import 'package:flutter/material.dart';
import '../../models/certificate.dart';
import '../../models/experience.dart';
import '../../models/project.dart';
import '../../models/skill.dart';

const String developerName = 'Raj Dutta';
const String developerTitle = 'Full Stack Developer';
const String tagline = 'Full Stack Developer (Flutter/Dart + Python Django)';

const String aboutText =
    'Full Stack Developer (Flutter/Dart + Python Django) and BCA student with hands-on experience building production-grade admin systems and mobile apps. Strong in scalable UI architecture, state management (Riverpod/GetX), and end-to-end workflows across healthcare, pharmacy, and dealership domains.';

const String resumeUrl = 'https://example.com/raj-dutta-resume.pdf';
const String email = 'rajdutta372@gmail.com';
const String linkedinUrl = 'https://www.facebook.com/share/1BXp5zTrpN/';
const String githubUrl = 'https://github.com/rajdutta234';

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
      SkillItem(name: 'C/C++', icon: Icons.code, proficiency: 0.85),
    ],
  ),
  SkillCategory(
    title: 'Frontend',
    icon: Icons.web,
    skills: const <SkillItem>[
      SkillItem(name: 'Flutter (Web, Desktop, Mobile)', icon: Icons.flutter_dash, proficiency: 0.95),
      SkillItem(name: 'HTML/CSS', icon: Icons.language, proficiency: 0.9),
      SkillItem(name: 'JavaScript', icon: Icons.javascript, proficiency: 0.85),
    ],
  ),
  SkillCategory(
    title: 'Backend & State Mgmt',
    icon: Icons.dns,
    skills: const <SkillItem>[
      SkillItem(name: 'Django', icon: Icons.api, proficiency: 0.85),
      SkillItem(name: 'Riverpod', icon: Icons.layers, proficiency: 0.92),
      SkillItem(name: 'GetX', icon: Icons.layers, proficiency: 0.92),
      SkillItem(name: 'GoRouter', icon: Icons.route, proficiency: 0.88),
    ],
  ),
  SkillCategory(
    title: 'Tools & Core Skills',
    icon: Icons.terminal,
    skills: const <SkillItem>[
      SkillItem(name: 'Git', icon: Icons.terminal, proficiency: 0.9),
      SkillItem(name: 'UI/UX & Responsive Design', icon: Icons.design_services, proficiency: 0.9),
      SkillItem(name: 'RBAC & Modular Architecture', icon: Icons.security, proficiency: 0.88),
      SkillItem(name: 'MS Office', icon: Icons.description, proficiency: 0.9),
    ],
  ),
];


const List<Experience> experiences = <Experience>[
  Experience(
    organization: 'NAIYO24 PRIVATE LIMITED',
    role: 'Full Stack Developer Intern',
    duration: '3 Months',
    description: <String>[
      'Built and maintained full-stack admin systems using Flutter (Web/Desktop).',
      'Designed modular, reusable UI components and scalable architecture.',
      'Implemented role-based access control (RBAC) and workflow-driven modules.',
    ],
  ),
  Experience(
    organization: 'Euphoria GenX / Techno Exponent',
    role: 'Web Development Intern',
    duration: 'Training + Internship',
    description: <String>[
      'Trained in Python Django with AI integration.',
      'Developed Blood Bank Management System.',
    ],
  ),
  Experience(
    organization: 'Sales Assistant',
    role: 'Sales Representative Assistant',
    duration: 'Jan 2021 – Jan 2022',
    description: <String>[
      'Assisted client communication and product demonstrations.',
    ],
  ),
];

const List<Project> projects = <Project>[
  Project(
    title: 'Hospital Management Admin Panel',
    description: 'Developed a production-grade hospital administration system designed to streamline clinical, operational, and administrative workflows across hospitals and clinics. The platform centralizes patient management, emergency handling, billing, lab operations, and reporting into a unified dashboard.',
    stack: <String>['Flutter (Dart)', 'Riverpod', 'Web & Desktop'],
    githubUrl: '',
    demoUrl: '',
    imageUrl: 'assets/images/hospital_pannel_photo.jpeg',
    contributions: [
      'Designed and implemented complete UI/UX architecture for complex hospital workflows',
      'Built scalable state management using Riverpod with clean separation of logic and UI',
      'Developed modular and reusable component system for maintainability',
      'Implemented Role-Based Access Control (RBAC) with permission-level routing and secure access',
      'Created end-to-end workflows: Patient Registration → Emergency Triage → Billing → Reporting',
      'Built advanced rich text template editors for prescriptions and billing with formatting support',
      'Optimized performance for handling large datasets and real-time updates',
      'Structured application with API-first approach for backend integration readiness',
    ],
    impact: [
      'Digitized hospital operations reducing manual workload',
      'Improved data accuracy and accessibility across departments',
      'Enabled secure multi-role system usage for staff and administration',
    ],
  ),
  Project(
    title: 'Pharmacy Admin Management Panel',
    description: 'Developed a comprehensive pharmacy management system to streamline medicine store operations including sales, inventory, procurement, prescriptions, customer credit, and reporting.',
    stack: <String>['Flutter (Dart)', 'GetX', 'Web/Desktop'],
    githubUrl: '',
    demoUrl: '',
    imageUrl: 'assets/images/pharmacy_admin_pannel_photo.jpeg',
    contributions: [
      'Built complete workflow for sales, inventory, suppliers, and prescriptions',
      'Implemented purchase lifecycle: Purchase Order → GRN → Invoice',
      'Designed inventory system with batch tracking, expiry monitoring, and stock alerts',
      'Developed real-time dashboard with KPIs, analytics, and reporting modules',
      'Created customer credit system with outstanding tracking and payment flows',
      'Used GetX for state management, dependency injection, and routing',
      'Structured clean and scalable architecture for maintainability',
    ],
    impact: [
      'Reduced manual tracking through automation of pharmacy workflows',
      'Enabled data-driven decisions with analytics dashboards',
      'Designed scalable system for multi-store operations',
    ],
  ),
  Project(
    title: 'Screen Recorder Doctor',
    description: 'Built a feature-rich mobile application combining screen recording, media management, and real-time collaboration features within a single platform.',
    stack: <String>['Flutter', 'Riverpod', 'GoRouter'],
    githubUrl: '',
    demoUrl: '',
    imageUrl: 'assets/images/screen_recorder_photo.jpeg',
    contributions: [
      'Designed modern UI system with smooth animations and responsive layouts',
      'Developed screen recording workflows including controls, preview, and history tracking',
      'Built real-time chat interface supporting text, media sharing, and group communication',
      'Implemented video call UI with interactive controls and live camera preview',
      'Integrated media handling using camera and gallery access',
      'Implemented scalable architecture using Riverpod and GoRouter',
      'Designed consistent theme system (Light/Dark mode)',
    ],
    impact: [
      'Combined productivity and collaboration features into a single application',
      'Improved user engagement with modern UI/UX and smooth performance',
    ],
  ),
  Project(
    title: 'OEMS Admin Panel',
    description: 'Developed a cross-platform admin dashboard for dealership and showroom management, centralizing inventory, customer relations, bookings, financial tracking, and analytics.',
    stack: <String>['Flutter', 'GetX', 'MVC'],
    githubUrl: '',
    demoUrl: '',
    imageUrl: 'assets/images/oems_admin_pannel_photo.jpeg',
    contributions: [
      'Designed responsive UI for Web, Android, iOS, and Desktop platforms',
      'Implemented scalable architecture using GetX and MVC pattern',
      'Built secure authentication system including PIN login and password recovery',
      'Developed real-time dashboards with KPIs, charts, and activity tracking',
      'Created CRM modules with filtering, sorting, and transaction history',
      'Built vehicle inventory system for sales and rental operations',
      'Implemented enquiry and booking workflows with pipeline tracking',
      'Developed financial modules for transactions, payouts, and reporting',
      'Designed reusable components and centralized routing system',
    ],
    impact: [
      'Improved operational efficiency through centralized management system',
      'Enabled better decision-making with real-time analytics',
      'Delivered scalable and maintainable architecture for future expansion',
    ],
  ),
  Project(
    title: 'INEWS — Intelligent News Reader',
    description: 'Developed a modern, intelligent news application delivering a personalized and accessible reading experience with AI-powered summaries and text-to-speech capabilities.',
    stack: <String>['Flutter', 'GetX', 'GetStorage'],
    githubUrl: 'https://github.com/rajdutta234/inews',
    demoUrl: '',
    imageUrl: 'assets/images/inews_photo.jpeg',
    contributions: [
      'Designed and built a fully responsive Flutter application with dark/light themes',
      'Implemented category-based news feed with advanced filtering and search',
      'Integrated AI-powered summaries and Text-to-Speech (TTS) for accessibility',
      'Built social interactions: likes, comments, bookmarks, and sharing',
      'Implemented local persistence using GetStorage and session handling',
      'Used GetX for state management, routing, and dependency injection',
      'Created reusable UI components and scalable architecture',
    ],
    impact: [
      'Enhanced content consumption with AI and accessibility features',
      'Delivered smooth, engaging UX with high-performance UI rendering',
    ],
  ),
  Project(
    title: 'Premium E-Commerce Mobile App',
    description: 'Built a production-style e-commerce application simulating a complete shopping journey from authentication to checkout with high-performance UI.',
    stack: <String>['Flutter', 'GetX', 'SharedPreferences'],
    githubUrl: 'https://github.com/rajdutta234/ecommerce',
    demoUrl: '',
    imageUrl: 'assets/images/e-commerce_photo.jpeg',
    contributions: [
      'Developed core modules: authentication, product listing, cart, checkout, profile',
      'Implemented real-time cart updates and debounced search functionality',
      'Designed multi-step checkout with multiple payment options (UPI, Card, Wallet, COD)',
      'Built dynamic UI interactions: swipe-to-delete, animations, overlays',
      'Implemented persistent login using SharedPreferences',
      'Structured modular and scalable architecture with reusable widgets',
    ],
    impact: [
      'Demonstrated real-world commerce workflows and UX optimization',
      'Built scalable frontend ready for backend/API integration',
    ],
  ),
  Project(
    title: 'U2Me — Dating App Prototype',
    description: 'Developed a social discovery and dating app prototype featuring swipe-based interactions, onboarding, matching, and chat simulation.',
    stack: <String>['Flutter', 'GetX', 'SharedPreferences'],
    githubUrl: 'https://github.com/rajdutta234/u2me',
    demoUrl: '',
    imageUrl: 'assets/images/u2me_photo.jpeg',
    contributions: [
      'Built authentication and onboarding flows with profile setup',
      'Implemented swipe-based discovery and match simulation system',
      'Developed chat UI with local messaging interactions',
      'Designed profile management with editable user data and preferences',
      'Used GetX with MVC architecture for scalable frontend structure',
      'Implemented local session persistence and reusable UI components',
    ],
    impact: [
      'Showcased modern social app UX patterns and animations',
      'Strengthened scalable architecture and state management practices',
    ],
  ),
  Project(
    title: 'Advanced Calculator App',
    description: 'Created a feature-rich calculator application supporting both standard and scientific operations with real-time evaluation.',
    stack: <String>['Flutter', 'GetX', 'math_expressions'],
    githubUrl: 'https://github.com/rajdutta234/calculator',
    demoUrl: '',
    imageUrl: 'assets/images/calculator_photo.jpeg',
    contributions: [
      'Implemented Standard and Scientific calculation modes',
      'Built real-time expression evaluation system using math_expressions',
      'Developed persistent calculation history with quick recall',
      'Designed modern Material 3 UI with smooth animations and responsive layout',
      'Applied MVVM architecture for clean and maintainable code',
    ],
    impact: [
      'Demonstrated ability to build logic-heavy applications',
      'Showcased performance optimization and clean architecture practices',
    ],
  ),
  Project(
    title: 'Blood Bank Management System',
    description: 'Trained in Python Django with AI integration. Developed Blood Bank Management System.',
    stack: <String>['Python', 'Django', 'MySQL'],
    githubUrl: '',
    demoUrl: 'https://rajdutta.pythonanywhere.com',
    imageUrl: 'assets/images/blood_bank.png',
    contributions: [
      'Trained in Python Django with AI integration',
      'Developed full-stack management system with Django',
      'Implemented secure records and request workflows',
      'Designed role-based dashboard views',
    ],
    impact: [
      'Digitized blood bank operations for better efficiency',
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
    imageUrl: 'assets/images/Exphoria_Industrial_Training_Certificate_photo.jpeg',
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
