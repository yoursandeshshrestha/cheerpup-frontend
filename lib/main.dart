import 'package:cheerpup/commons/app_initializer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// This is the main entry point of the CheerPup application.
void main() {
  runApp(const ProviderScope(child: AppInitializer()));
}
