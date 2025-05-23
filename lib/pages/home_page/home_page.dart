import 'package:cheerpup/pages/home_page/widgets/home_content.dart';
import 'package:cheerpup/pages/home_page/widgets/home_hero.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        // statusBarColor: Color(0xFF694E3E),
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );

    return Column(
      children: [
        const HomeHero(),
        Expanded(child: SingleChildScrollView(child: HomeContent())),
      ],
    );
  }
}
