import 'package:cheerpup/commons/app_initializer.dart';
import 'package:cheerpup/commons/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // This needs to be called first
  WidgetsFlutterBinding.ensureInitialized();

  // Then initialize Hive
  await Hive.initFlutter();

  // Then initialize router
  await AppRouter.initialize();

  runApp(const ProviderScope(child: AppInitializer()));
}
