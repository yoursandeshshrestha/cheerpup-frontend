// lib/commons/app_initializer.dart

import 'package:cheerpup/commons/app_routes.dart';
import 'package:cheerpup/commons/services/auth_service.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AppInitializer extends ConsumerWidget {
  const AppInitializer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get AuthService reference
    final authService = ref.read(authServiceProvider);

    print("App initializer - ${authService.isInitialized}");
    print("Token - ${authService.token}");
    print("UserId - ${authService.userId}");

    // Initialize auth state if not already initialized
    if (!authService.isInitialized) {
      // Use FutureBuilder to handle the async initialization
      return FutureBuilder(
        future: _initializeAuthAndUser(authService, ref),
        builder: (context, snapshot) {
          // Show a loading indicator while initializing
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false, // turn off the banner
              showPerformanceOverlay: false, // turn off perf overlay
              checkerboardRasterCacheImages: false, // no checkerboarding
              checkerboardOffscreenLayers: false,
              debugShowMaterialGrid: false,
              showSemanticsDebugger: false,
              home: Scaffold(body: Center(child: CircularProgressIndicator())),
            );
          }

          // Return the main app after initialization
          return _buildApp();
        },
      );
    }

    // If already initialized, build the app directly
    return _buildApp();
  }

  Future<void> _initializeAuthAndUser(
    AuthService authService,
    WidgetRef ref,
  ) async {
    await authService.initialize();

    // If user is authenticated, initialize home state with user data
    if (await authService.isAuthenticated() && authService.userData != null) {
      ref
          .read(homePageProvider.notifier)
          .initializeUserData(authService.userData!);
    }
  }

  Widget _buildApp() {
    return MaterialApp.router(
      title: 'CheerPup App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        primaryColor: const Color(0xFF8DAF5D),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: 'Roboto',
      ),
      routerConfig: AppRouter.router,
      debugShowCheckedModeBanner: false,
      showPerformanceOverlay: false,
      checkerboardRasterCacheImages: false,
      checkerboardOffscreenLayers: false,
      debugShowMaterialGrid: false,
      showSemanticsDebugger: false,
    );
  }
}
