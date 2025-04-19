import 'package:cheerpup/commons/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppInitializer extends ConsumerWidget {
  const AppInitializer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'CheerPup App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: const Color(0xFF8DAF5D),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
    );
  }
}
