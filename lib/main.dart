import 'package:flutter/material.dart';
import 'pages/onboarding_page.dart';

void main() => runApp(const MoodApp());

const _seed = Color(0xFF5038BC);

class MoodApp extends StatelessWidget {
  const MoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(colorSchemeSeed: _seed, useMaterial3: true),
      darkTheme: ThemeData(
        colorSchemeSeed: _seed,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      themeMode: ThemeMode.system, // dark mode ikut pengaturan perangkat
      home: const OnboardingPage(),
    );
  }
}