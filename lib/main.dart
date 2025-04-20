import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  // Controller'ı başlat
  Get.put(OnboardingController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Dünya Kaşifi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF1A237E)),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}
