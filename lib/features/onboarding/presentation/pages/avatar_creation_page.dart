import 'package:dunya_kasifi/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../../core/app_colors.dart';

class AvatarCreationPage extends StatelessWidget {
  const AvatarCreationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.find<OnboardingController>();

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Karakterini Seç',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: AppColors.backgroundColor,
              shadows: [
                Shadow(
                  blurRadius: 10.0,
                  color: AppColors.textColor.withOpacity(0.5),
                  offset: const Offset(2.0, 2.0),
                ),
              ],
            ),
          ).animate().fadeIn().scale(),
          const SizedBox(height: 32),
          // Seçilen avatar
          Obx(() => Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(100),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.textColor.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                  border: Border.all(
                    color: AppColors.primaryColor,
                    width: 3,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Image.asset(
                    'assets/images/avatars/${controller.selectedAvatarIndex.value + 1}.jpeg',
                    fit: BoxFit.cover,
                  ),
                ),
              ).animate().fadeIn(delay: 200.ms).scale()),
          const SizedBox(height: 32),
          // Avatar seçim listesi
          Container(
            width: 615,
            height: 110,
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: AppColors.backgroundColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: AppColors.backgroundColor.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return Obx(() {
                  final isSelected =
                      controller.selectedAvatarIndex.value == index;
                  return GestureDetector(
                    onTap: () => controller.updateAvatarSelection(index),
                    child: Container(
                      width: 80,
                      height: 80,
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(40),
                        border: Border.all(
                          color: isSelected
                              ? AppColors.primaryColor
                              : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: isSelected
                                ? AppColors.primaryColor.withOpacity(0.3)
                                : AppColors.textColor.withOpacity(0.2),
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(40),
                        child: Image.asset(
                          'assets/images/avatars/${index + 1}.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ).animate().fadeIn(delay: (300 + index * 100).ms).scale(),
                  );
                });
              },
            ),
          ),
          const SizedBox(height: 24),
          // Karakter adı
          Obx(() => Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.backgroundColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(
                    color: AppColors.backgroundColor.withOpacity(0.3),
                    width: 2,
                  ),
                ),
                child: Text(
                  controller.avatarNames[controller.selectedAvatarIndex.value],
                  style: TextStyle(
                    color: AppColors.backgroundColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(
                        blurRadius: 2.0,
                        color: AppColors.backgroundColor.withOpacity(0.5),
                        offset: const Offset(1.0, 1.0),
                      ),
                    ],
                  ),
                ),
              ).animate().fadeIn(delay: 800.ms).scale()),
        ],
      ),
    );
  }
}
