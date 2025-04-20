import 'package:cheerpup/pages/layout/layout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// This file contains the NotFound widget, which is displayed when a route is not found.
// It provides a message indicating that the page was not found and a button to navigate to the home page.
class ProfileHeader extends ConsumerWidget {
  final String title;
  final VoidCallback? onBackPressed;

  const ProfileHeader({super.key, required this.title, this.onBackPressed});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Row(
        children: [
          InkWell(
            onTap:
                onBackPressed ??
                () {
                  context.goNamed('home');
                  ref.read(navigationIndexProvider.notifier).state = 0;
                },
            child: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
              size: 18,
            ),
          ),
          const SizedBox(width: 16),
          Text(
            title,
            style: const TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
