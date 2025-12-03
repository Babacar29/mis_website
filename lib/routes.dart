import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// Imports de toutes tes pages
import 'views/home_page.dart';
import 'views/about_page.dart';
import 'views/programs_page.dart';
import 'views/donate_page.dart';
import 'views/partners_page.dart';
import 'views/contact_page.dart';
import 'views/admin/login_page.dart';
import 'views/admin/admin_dashboard.dart';

// Configuration du Router
final GoRouter appRouter = GoRouter(
  initialLocation: '/', // Page par défaut
  routes: [
    // Page d'accueil (monsite.com/)
    GoRoute(
      path: '/',
      builder: (context, state) => const HomePage(),
    ),
    
    // À Propos (monsite.com/about)
    GoRoute(
      path: '/about',
      builder: (context, state) => const AboutPage(),
    ),

    // Programmes (monsite.com/programs)
    GoRoute(
      path: '/programs',
      builder: (context, state) => const ProgramsPage(),
    ),

    // Partenariats (monsite.com/partners)
    GoRoute(
      path: '/partners',
      builder: (context, state) => const PartnersPage(),
    ),

    // Dons (monsite.com/donate)
    GoRoute(
      path: '/donate',
      builder: (context, state) => const DonatePage(),
    ),

    // Contact (monsite.com/contact)
    GoRoute(
      path: '/contact',
      builder: (context, state) => const ContactPage(),
    ),
    
    // Login Admin (monsite.com/admin)
    GoRoute(
      path: '/admin',
      builder: (context, state) => const LoginPage(),
      routes: [
        GoRoute(
          path: 'dashboard',
          builder: (context, state) => const AdminDashboard(),
        ),
      ],
    ),
  ],
);