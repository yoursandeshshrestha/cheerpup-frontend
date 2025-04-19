import 'package:cheerpup/pages/activities/activities_page.dart';
import 'package:cheerpup/pages/chat_history/chat_history.dart';
import 'package:cheerpup/pages/home_page/home_page.dart';
import 'package:cheerpup/pages/layout/layout_page.dart';
import 'package:cheerpup/pages/login/login_page.dart';
import 'package:cheerpup/pages/not_found/not_found.dart';
import 'package:cheerpup/pages/onboarding_page/onboarding_page.dart';
import 'package:cheerpup/pages/profile_page/profile_page.dart';
import 'package:cheerpup/pages/signup/signup_page.dart';
import 'package:cheerpup/pages/welcome_page/welcome_page.dart';
import 'package:go_router/go_router.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/login',
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return LayoutPage(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/chat-history',
          name: 'chat-history',
          builder: (context, state) => const ChatHistory(),
        ),
        GoRoute(
          path: '/activities',
          name: 'activities',
          builder: (context, state) => const ActivitiesPage(),
        ),
        GoRoute(
          path: '/profile',
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ],
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
  errorBuilder: (context, state) => NotFound(),
);
