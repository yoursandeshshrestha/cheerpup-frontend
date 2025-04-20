import 'package:cheerpup/commons/app_initializer.dart';
import 'package:cheerpup/commons/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await AppRouter.initialize();

  runApp(const ProviderScope(child: AppInitializer()));
}
