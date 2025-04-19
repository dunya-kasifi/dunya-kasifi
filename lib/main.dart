import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: DunyaKasifiApp(),
    ),
  );
}

class DunyaKasifiApp extends StatelessWidget {
  const DunyaKasifiApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dünya Kaşifi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4CAF50),
          primary: const Color(0xFF4CAF50),
          secondary: const Color(0xFFFF9800),
          tertiary: const Color(0xFF2196F3),
          background: const Color(0xFFF5F5F5),
        ),
        textTheme: GoogleFonts.quicksandTextTheme(),
        useMaterial3: true,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const OnboardingScreen(),
    );
  }
}
