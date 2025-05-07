import 'package:dunya_kasifi/features/game/presentation/bindings/game_binding.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/app_colors.dart';
import 'features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'features/onboarding/presentation/screens/onboarding_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Controller'ı başlat
  Get.put(OnboardingController());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dünya Kaşifi',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primaryColor,
          primary: AppColors.primaryColor,
          secondary: AppColors.secondaryColor,
        ),
        useMaterial3: true,
      ),
      initialBinding: GameBinding(),
      home: const OnboardingScreen(),
    );
  }
}
