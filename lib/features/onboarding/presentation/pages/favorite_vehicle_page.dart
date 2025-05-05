import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';

class FavoriteVehiclePage extends StatelessWidget {
  const FavoriteVehiclePage({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.find<OnboardingController>();

    return SafeArea(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Seçilen avatar
            Obx(() => Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 2,
                    ),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(100),
                    child: Image.asset(
                      'assets/images/avatars/${controller.selectedAvatarIndex.value + 1}.jpeg',
                      fit: BoxFit.cover,
                    ),
                  ),
                ).animate().fadeIn().scale()),
            Text(
              'Favori Keşif Aracını Seç',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black.withOpacity(0.5),
                    offset: const Offset(2.0, 2.0),
                  ),
                ],
              ),
            ).animate().fadeIn().scale(),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Seçilen araç önizlemesi
                    Obx(() {
                      final selectedIndex =
                          controller.selectedVehicleIndex.value;
                      return Container(
                        width: 200,
                        height: 200,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.2),
                            width: 2,
                          ),
                        ),
                        child: Image.asset(
                          controller.vehicleImages[selectedIndex],
                          fit: BoxFit.contain,
                        ),
                      ).animate().fadeIn().scale();
                    }),
                    const SizedBox(height: 32),
                    // Araç seçim listesi
                    Center(
                      child: SizedBox(
                        width: 390,
                        height: 100,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.vehicleImages.length,
                          itemBuilder: (context, index) {
                            return Obx(() {
                              final isSelected =
                                  controller.selectedVehicleIndex.value ==
                                      index;
                              return GestureDetector(
                                onTap: () => controller.selectVehicle(index),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  margin:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.9),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: isSelected
                                          ? const Color.fromARGB(
                                              255, 126, 74, 229)
                                          : Colors.transparent,
                                      width: 3,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 5,
                                        offset: const Offset(0, 3),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.asset(
                                      controller.vehicleImages[index],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              );
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Seçilen araç ismi
                    Obx(() => Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 255, 255)
                                .withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color.fromARGB(255, 255, 255, 255)
                                  .withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Text(
                            controller.vehicleNames[
                                controller.selectedVehicleIndex.value],
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              shadows: [
                                Shadow(
                                  blurRadius: 2.0,
                                  color: Colors.white.withOpacity(0.5),
                                  offset: const Offset(1.0, 1.0),
                                ),
                              ],
                            ),
                          ),
                        )
                            .animate()
                            .fadeIn(delay: const Duration(milliseconds: 800))
                            .scale()),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
