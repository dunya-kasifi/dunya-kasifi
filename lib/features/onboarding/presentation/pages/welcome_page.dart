import 'package:dunya_kasifi/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../../core/app_colors.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({super.key});

  OnboardingController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          stops: const [0.2, 1],
          colors: [
            AppColors.primaryColor.withOpacity(0.9),
            AppColors.quinaryColor.withOpacity(0.9),
          ],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.backgroundColor.withOpacity(0.1),
              ),
            ),
          )
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .fadeIn(duration: const Duration(milliseconds: 800))
              .then()
              .moveY(
                begin: 0,
                end: 20,
                duration: const Duration(seconds: 3),
                curve: Curves.easeInOut,
              )
              .then()
              .moveY(
                begin: 20,
                end: 0,
                duration: const Duration(seconds: 3),
                curve: Curves.easeInOut,
              ),
          Positioned(
            bottom: -50,
            left: -50,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.backgroundColor.withOpacity(0.1),
              ),
            ),
          )
              .animate(
                onPlay: (controller) => controller.repeat(),
              )
              .fadeIn(duration: const Duration(milliseconds: 800))
              .then()
              .moveY(
                begin: 0,
                end: -20,
                duration: const Duration(seconds: 4),
                curve: Curves.easeInOut,
              )
              .then()
              .moveY(
                begin: -20,
                end: 0,
                duration: const Duration(seconds: 4),
                curve: Curves.easeInOut,
              ),

          Positioned(
            top: 50,
            left: 50,
            child: Lottie.asset(
              'assets/animations/rocket.json',
              width: 300,
              height: 300,
              fit: BoxFit.contain,
            ),
          ),

          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo or Icon
                  ClipRRect(
                    borderRadius: BorderRadius.all(
                      Radius.circular(50),
                    ),
                    child: Image.asset(
                      "assets/icons/app_icon.png",
                      height: 200,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  )
                      .animate()
                      .fadeIn(duration: const Duration(milliseconds: 600)),
                  // Container(
                  //   padding: const EdgeInsets.all(20),
                  //   decoration: BoxDecoration(
                  //     color: AppColors.backgroundColor,
                  //     shape: BoxShape.circle,
                  //     boxShadow: [
                  //       BoxShadow(
                  //         color: AppColors.textColor.withOpacity(0.2),
                  //         blurRadius: 20,
                  //         offset: const Offset(0, 10),
                  //       ),
                  //     ],
                  //   ),
                  //   child: Icon(
                  //     Icons.explore,
                  //     size: 60,
                  //     color: AppColors.primaryColor,
                  //   ),
                  // )
                  //     .animate()
                  //     .fadeIn(duration: const Duration(milliseconds: 600)),

                  const SizedBox(height: 40),

                  // Welcome Text
                  Text(
                    'Kaşif Akademisi\'ne\nHoş Geldin!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: AppColors.backgroundColor,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(duration: const Duration(milliseconds: 600)),

                  const SizedBox(height: 16),

                  // Subtitle
                  Text(
                    'Dünyayı keşfetmeye hazır mısın?',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: AppColors.backgroundColor.withOpacity(0.9),
                          height: 1.5,
                        ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(duration: const Duration(milliseconds: 600)),

                  const SizedBox(height: 48),

                  // Get Started Button
                  ElevatedButton(
                    onPressed: () {
                      controller.nextPage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.backgroundColor,
                      foregroundColor: AppColors.primaryColor,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      elevation: 5,
                    ),
                    child: const Text(
                      'Keşfetmeye Başla',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .scale(
                        begin: const Offset(1, 1),
                        end: const Offset(1.1, 1.1),
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut,
                      )
                      .then()
                      .scale(
                        begin: const Offset(1.1, 1.1),
                        end: const Offset(1, 1),
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut,
                      ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
