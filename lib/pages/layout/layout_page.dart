import 'package:cheerpup/commons/widgets/nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final navigationIndexProvider = StateProvider<int>((ref) => 0);

class LayoutPage extends ConsumerWidget {
  final Widget child;

  const LayoutPage({super.key, required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [Expanded(child: child), const SizedBox(height: 90)],
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: NavBar(
                onItemTapped: (index) {
                  ref.read(navigationIndexProvider.notifier).state = index;
                  switch (index) {
                    case 0:
                      context.go('/');
                      break;
                    case 1:
                      context.go('/messages');
                      break;
                    case 2:
                      context.go('/stats');
                      break;
                    case 3:
                      context.go('/profile');
                      break;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
