import 'package:cheerpup/commons/widgets/nav_bar.dart';
import 'package:cheerpup/pages/home_page/home.dart';
import 'package:cheerpup/pages/messages_page/messages_page.dart';
import 'package:cheerpup/pages/profile_page/profile_page.dart';
import 'package:cheerpup/pages/stats_page/stats_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// Navigation state notifier to manage navigation state
class NavigationNotifier extends StateNotifier<int> {
  NavigationNotifier() : super(0);

  void setIndex(int index) {
    state = index;
  }
}

// Provider for the navigation state
final navigationProvider = StateNotifierProvider<NavigationNotifier, int>((
  ref,
) {
  return NavigationNotifier();
});

// Router configuration provider
final routerProvider = Provider<GoRouter>((ref) {
  final notifier = ref.watch(navigationProvider.notifier);

  return GoRouter(
    initialLocation: '/',
    routes: [
      // Shell route to handle bottom navigation
      ShellRoute(
        builder: (context, state, child) {
          return ScaffoldWithNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/',
            pageBuilder:
                (context, state) => NoTransitionPage(child: const Home()),
          ),
          GoRoute(
            path: '/messages',
            pageBuilder:
                (context, state) =>
                    NoTransitionPage(child: const MessagesPage()),
          ),
          GoRoute(
            path: '/stats',
            pageBuilder:
                (context, state) => NoTransitionPage(child: const StatsPage()),
          ),
          GoRoute(
            path: '/profile',
            pageBuilder:
                (context, state) =>
                    NoTransitionPage(child: const ProfilePage()),
          ),
        ],
      ),
    ],
    redirect: (context, state) {
      // Map path to index for navbar
      final index = switch (state.uri.path) {
        '/' => 0,
        '/messages' => 1,
        '/stats' => 2,
        '/profile' => 3,
        _ => null,
      };

      // If we're navigating to a page that has an index, update the navigation state
      if (index != null) {
        notifier.setIndex(index);
      }

      return null;
    },
  );
});

// Scaffold with navigation bar
class ScaffoldWithNavBar extends ConsumerWidget {
  final Widget child;

  const ScaffoldWithNavBar({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationProvider);

    return Scaffold(
      body: child,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF8DAF5D),
        child: const Icon(Icons.add, color: Colors.white),
        onPressed: () => context.go('/add'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavBar(
        selectedIndex: selectedIndex,
        onItemTapped: (index) {
          final path = switch (index) {
            0 => '/',
            1 => '/messages',
            2 => '/stats',
            3 => '/profile',
            _ => '/',
          };
          context.go(path);
        },
      ),
    );
  }
}
