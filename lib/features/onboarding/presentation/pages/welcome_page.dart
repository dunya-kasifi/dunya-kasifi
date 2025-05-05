import 'package:dunya_kasifi/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';

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
          colors: [
            const Color(0xFF1A237E).withOpacity(0.9),
            const Color(0xFF0D47A1).withOpacity(0.9),
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
                color: Colors.white.withOpacity(0.1),
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
                color: Colors.white.withOpacity(0.1),
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

          // Main content
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo or Icon
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.explore,
                      size: 60,
                      color: Color(0xFF1A237E),
                    ),
                  )
                      .animate()
                      .scale(duration: const Duration(milliseconds: 600))
                      .then()
                      .shake(duration: const Duration(milliseconds: 400)),

                  const SizedBox(height: 40),

                  // Welcome Text
                  Text(
                    'Kaşif Akademisi\'ne\nHoş Geldin!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 200))
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 16),

                  // Subtitle
                  Text(
                    'Dünyayı keşfetmeye hazır mısın?',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(0.9),
                          height: 1.5,
                        ),
                    textAlign: TextAlign.center,
                  )
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 400))
                      .slideY(begin: 0.3, end: 0),

                  const SizedBox(height: 48),

                  // Get Started Button
                  ElevatedButton(
                    onPressed: () {
                      controller.nextPage();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF1A237E),
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
                      .animate()
                      .fadeIn(delay: const Duration(milliseconds: 600))
                      .slideY(begin: 0.3, end: 0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
