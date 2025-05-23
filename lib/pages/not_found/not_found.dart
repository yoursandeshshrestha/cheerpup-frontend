import 'package:cheerpup/pages/layout/layout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class NotFound extends ConsumerWidget {
  const NotFound({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('404 - Page not found'),
            GestureDetector(
              onTap: () {
                context.goNamed("home");
                ref.read(navigationIndexProvider.notifier).state = 0;
              },
              child: Text("Go to home", style: TextStyle(color: Colors.blue)),
            ),
          ],
        ),
      ),
    );
  }
}
