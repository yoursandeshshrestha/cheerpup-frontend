import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cheerpup/commons/providers/navigation_provider.dart';

void main() {
  runApp(const ProviderScope(child: CheerPupApp()));
}

class CheerPupApp extends ConsumerWidget {
  const CheerPupApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'CheerPup App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
