import 'package:cheerpup/pages/home_page/home_page.dart';
import 'package:cheerpup/pages/login/login_page.dart';
import 'package:cheerpup/pages/login/widgets/login_screen_one_widget.dart';
import 'package:cheerpup/pages/onboarding_page/onboarding_page.dart';
import 'package:cheerpup/pages/profile_page/profile_page.dart';
import 'package:cheerpup/pages/signup/signup_page.dart';
import 'package:cheerpup/pages/welcome_page/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/welcome',
      name: 'welcome',
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: '/onboarding',
      name: 'onboarding',
      builder: (context, state) => const OnboardingPage(),
    ),
    GoRoute(
      path: '/profile',
      name: 'profile',
      builder: (context, state) => const ProfilePage(),
    ),
    GoRoute(
      path: '/login',
      name: 'login',
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/signup',
      name: 'signup',
      builder: (context, state) => const SignupPage(),
    ),
  ],
  errorBuilder:
      (context, state) =>
          const Scaffold(body: Center(child: Text('404 - Page not found'))),
);
