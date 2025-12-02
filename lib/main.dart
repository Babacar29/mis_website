import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'views/home_page.dart';

void main() {
  runApp(const MisWebsiteApp());
}

class MisWebsiteApp extends StatelessWidget {
  const MisWebsiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mission Inter-Sénégal',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme, // Utilisation du thème Option A
      home: const HomePage(),
    );
  }
}