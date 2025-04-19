// Route names as constants for the application
class AppRoutes {
  static const home = '/';
  static const messages = '/messages';
  static const add = '/add';
  static const stats = '/stats';
  static const profile = '/profile';

  // Prevent instantiation
  AppRoutes._();
}


// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// // import your screens/pages here
// // import 'package:your_app/pages/home_page.dart';
// // import 'package:your_app/pages/details_page.dart';

// final GoRouter appRouter = GoRouter(
//   initialLocation: '/',
//   routes: [
//     GoRoute(
//       path: '/',
//       name: 'home',
//       builder: (context, state) => const HomePage(),
//     ),
//     GoRoute(
//         path: '/task',
//         name: 'task',
//         builder: (context, state) => const TaskPage(),
//     ),
//     GoRoute(
//       path: '/onboarding',
//       name: 'onboarding',
//       builder: (context, state) => const OnboardingPage(),
//     ),
//     GoRoute(
//       path: '/profile',
//       name: 'profile',
//       builder: (context, state) => const ProfilePage(),
//     ),
//     GoRoute(
//       path: '/login',
//       name: 'login',
//       builder: (context, state) => const LoginPage(),
//     ),  
//     GoRoute(
//       path: '/signup',
//       name: 'signup',
//       builder: (context, state) => const SignupPage(),
//     ),
    
//     // Add more routes here as your app grows
//   ],
//   errorBuilder: (context, state) => const Scaffold(
//     body: Center(
//       child: Text('404 - Page not found'),
//     ),
//   ),
// );
