import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/onboarding_page.dart';
import 'services/mood_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MoodRepository.init();
  runApp(const MoodApp());
}

const kPrimary = Color(0xFF4F39BA);
const kBackground = Color(0xFFF7F7FB);
const kBorder = Color(0xFFE6E6EE);

class MoodApp extends StatelessWidget {
  const MoodApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mood Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: kPrimary, primary: kPrimary),
        scaffoldBackgroundColor: kBackground,
        appBarTheme: const AppBarTheme(
          backgroundColor: kBackground,
          surfaceTintColor: Colors.transparent,
          centerTitle: true,
          elevation: 0,
        ),
        cardTheme: CardThemeData(
          color: Colors.white,
          elevation: 1.5,
          shadowColor: Colors.black26,
          surfaceTintColor: Colors.transparent,
          margin: EdgeInsets.zero,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        ),
        filledButtonTheme: FilledButtonThemeData(
          style: FilledButton.styleFrom(
            backgroundColor: kPrimary,
            foregroundColor: Colors.white,
            minimumSize: const Size.fromHeight(52),
            shape: const StadiumBorder(),
          ),
        ),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: kPrimary,
          foregroundColor: Colors.white,
          shape: CircleBorder(),
        ),
      ),
      darkTheme: ThemeData(
        colorSchemeSeed: kPrimary,
        brightness: Brightness.dark,
        useMaterial3: true,
      ),
      // Default light biar sesuai desain Figma.
      // Mau dark mode otomatis ikut perangkat? Ganti jadi ThemeMode.system.
      themeMode: ThemeMode.light,
      // Di Chrome/desktop, tampilan dibatasi selebar HP supaya tidak melebar.
      builder: (context, child) => Container(
        color: const Color(0xFFE9E9F0),
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 430),
          child: child,
        ),
      ),
      home: MoodRepository.onboardingSeen ? const HomePage() : const OnboardingPage(),
    );
  }
}