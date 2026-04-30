import 'package:flutter/material.dart';
import '../../models/certificate.dart';
import '../../models/experience.dart';
import '../../models/project.dart';
import '../../models/skill.dart';

const String developerName = 'Raj Dutta';
const String developerTitle = 'Full Stack Developer';
const String tagline = 'Building scalable, modern web applications';

const String aboutText =
    'I am Raj Dutta, a BCA student and developer focused on building polished '
    'full-stack products. I enjoy creating responsive user experiences, robust '
    'backend systems, and integrating AI into practical applications that solve '
    'real-world problems.';

const String resumeUrl = 'https://example.com/raj-dutta-resume.pdf';
const String email = 'rajdutta372@gmail.com';
const String linkedinUrl = 'https://www.linkedin.com/in/raj-dutta-a8875936a?utm_source=share&utm_campaign=share_via&utm_content=profile&utm_medium=ios_app';
const String githubUrl = 'https://github.com/rajdutta234';

const List<String> navItems = <String>[
  'Home',
  'About',
  'Skills',
  'Experience',
  'Projects',
  'Contact',
];

final List<SkillCategory> skills = <SkillCategory>[
  SkillCategory(
    title: 'Frontend',
    skills: const <SkillItem>[
      SkillItem(name: 'HTML', icon: Icons.language, proficiency: 0.9),
      SkillItem(name: 'CSS', icon: Icons.style, proficiency: 0.86),
      SkillItem(name: 'JavaScript', icon: Icons.javascript, proficiency: 0.88),
      SkillItem(name: 'Flutter', icon: Icons.flutter_dash, proficiency: 0.84),
    ],
  ),
  SkillCategory(
    title: 'Backend',
    skills: const <SkillItem>[
      SkillItem(name: 'Python', icon: Icons.code, proficiency: 0.9),
      SkillItem(name: 'Flask', icon: Icons.api, proficiency: 0.8),
      SkillItem(name: 'FastAPI', icon: Icons.flash_on, proficiency: 0.8),
    ],
  ),
  SkillCategory(
    title: 'Database',
    skills: const <SkillItem>[
      SkillItem(name: 'PostgreSQL', icon: Icons.storage, proficiency: 0.82),
      SkillItem(name: 'Firebase', icon: Icons.local_fire_department, proficiency: 0.78),
      SkillItem(name: 'MySQL', icon: Icons.dns, proficiency: 0.84),
    ],
  ),
];

const List<Experience> experiences = <Experience>[
  Experience(
    organization: 'NAIYO24 PRIVATE LIMITED',
    role: 'Full Stack Developer Intern',
    duration: '3 Months',
    description: <String>[
      'Worked on real-world projects with production-focused workflows.',
      'Developed and maintained full-stack web applications.',
      'Collaborated with the team across backend and frontend tasks.',
    ],
  ),
  Experience(
    organization: 'Euphoria GenX / Techno Exponent',
    role: 'Web Development Intern',
    duration: 'Training + Internship',
    description: <String>[
      'Completed training in Python Django with AI integration.',
      'Built a Blood Bank Management Project from concept to implementation.',
    ],
  ),
];

const List<Project> projects = <Project>[
  Project(
    title: 'Blood Bank Management System',
    description:
        'A complete blood inventory and donor management platform with secure '
        'records, request workflows, and role-based dashboard views.',
    stack: <String>['Python', 'Django', 'AI Integration', 'MySQL'],
    githubUrl: 'https://github.com/rajdutta/blood-bank-management',
    demoUrl: 'https://example.com/blood-bank-demo',
  ),
];

const List<Certificate> certificates = <Certificate>[
  Certificate(
    title: 'Full Stack Internship Certificate',
    issuer: 'NAIYO24 PRIVATE LIMITED',
    imageUrl: 'https://images.unsplash.com/photo-1524995997946-a1c2e315a42f?w=1600',
  ),
  Certificate(
    title: 'Python Django with AI Integration Training',
    issuer: 'Euphoria GenX / Techno Exponent',
    imageUrl: 'https://images.unsplash.com/photo-1515879218367-8466d910aaa4?w=1600',
  ),
  Certificate(
    title: 'Web Development Internship',
    issuer: 'Techno Exponent',
    imageUrl: 'https://images.unsplash.com/photo-1519389950473-47ba0277781c?w=1600',
  ),
];
