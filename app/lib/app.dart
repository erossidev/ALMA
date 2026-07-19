import 'package:flutter/material.dart';
import 'core/theme/alma_theme.dart';
import 'features/home/home_page.dart';

class AlmaApp extends StatelessWidget {
  const AlmaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ALMA',
      debugShowCheckedModeBanner: false,
		theme: AlmaTheme.dark,
		home: const HomePage(),
    );
  }
}