import 'package:cheerpup/commons/providers/navigation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(navigationProvider);

    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          const Center(child: Text('Home Content')),
          const Center(child: Text('Messages Content')),
          const Center(child: Text('Stats Content')),
          const Center(child: Text('Profile Content')),
        ],
      ),
    );
  }
}
