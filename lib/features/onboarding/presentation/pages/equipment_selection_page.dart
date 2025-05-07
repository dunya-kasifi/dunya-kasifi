import 'package:dunya_kasifi/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import '../../../../core/app_colors.dart';

class EquipmentSelectionPage extends StatelessWidget {
  const EquipmentSelectionPage({super.key});

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
                    color: AppColors.backgroundColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.backgroundColor.withOpacity(0.2),
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
              'Keşif Ekipmanlarını Seç',
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
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Sol taraf - Ekipmanlar
                    Container(
                      width: 400,
                      height: 400,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: AppColors.backgroundColor.withOpacity(0.2),
                          width: 2,
                        ),
                      ),
                      child: GridView.count(
                        crossAxisCount: 2,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 16,
                        childAspectRatio: 1.2,
                        children: List.generate(4, (index) {
                          return Obx(() => _EquipmentCard(
                                title: controller.equipmentNames[index],
                                description: [
                                  'Her zaman doğru yönü gösterir!',
                                  'Keşiflerini kaydetmek için!',
                                  'Anılarını ölümsüzleştir!',
                                  'Uzakları yakın et!'
                                ][index],
                                icon: [
                                  Icons.explore,
                                  Icons.book,
                                  Icons.camera_alt,
                                  Icons.remove_red_eye,
                                ][index],
                                isSelected: controller.selectedEquipment[index],
                                color: controller.equipmentColors[index],
                                onSelect: () =>
                                    controller.toggleEquipment(index),
                              )
                                  .animate()
                                  .fadeIn(delay: (200 + index * 100).ms)
                                  .slideX());
                        }),
                      ),
                    ),
                    const SizedBox(width: 32),
                    // Sağ taraf - Seçilen ekipmanların önizlemesi
                    Container(
                      width: 250,
                      height: 400,
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.textColor.withOpacity(0.1),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                        border: Border.all(
                          color: AppColors.backgroundColor.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: AppColors.primaryColor.withOpacity(0.3),
                                width: 2,
                              ),
                            ),
                            child: Text(
                              'Seçilen Ekipmanlar',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    blurRadius: 2.0,
                                    color: AppColors.backgroundColor
                                        .withOpacity(0.5),
                                    offset: const Offset(1.0, 1.0),
                                  ),
                                ],
                              ),
                            ),
                          ).animate().fadeIn().scale(),
                          const SizedBox(height: 16),
                          Expanded(
                            child: Obx(() => SingleChildScrollView(
                                  child: Column(
                                    children: List.generate(4, (index) {
                                      if (controller.selectedEquipment[index]) {
                                        return Padding(
                                          padding:
                                              const EdgeInsets.only(bottom: 8),
                                          child: Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 12, vertical: 8),
                                            decoration: BoxDecoration(
                                              color: controller
                                                  .equipmentColors[index]
                                                  .withOpacity(0.2),
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              border: Border.all(
                                                color: controller
                                                    .equipmentColors[index],
                                                width: 2,
                                              ),
                                            ),
                                            child: Row(
                                              children: [
                                                Container(
                                                  padding:
                                                      const EdgeInsets.all(6),
                                                  decoration: BoxDecoration(
                                                    color: controller
                                                        .equipmentColors[index]
                                                        .withOpacity(0.1),
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Icon(
                                                    [
                                                      Icons.explore,
                                                      Icons.book,
                                                      Icons.camera_alt,
                                                      Icons.remove_red_eye,
                                                    ][index],
                                                    color: controller
                                                        .equipmentColors[index],
                                                    size: 18,
                                                  ),
                                                ),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    controller
                                                        .equipmentNames[index],
                                                    style: TextStyle(
                                                      color: controller
                                                              .equipmentColors[
                                                          index],
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ).animate().fadeIn().scale(),
                                        );
                                      }
                                      return const SizedBox.shrink();
                                    }),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ),
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

class _EquipmentCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final Color color;
  final VoidCallback onSelect;

  const _EquipmentCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.color,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onSelect,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isSelected ? color : AppColors.backgroundColor,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isSelected ? color : AppColors.textColor.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.backgroundColor
                    : color.withOpacity(0.1),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Icon(
                icon,
                size: 36,
                color: isSelected ? color : color.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? AppColors.backgroundColor : color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                shadows: isSelected
                    ? [
                        Shadow(
                          blurRadius: 2.0,
                          color: AppColors.textColor.withOpacity(0.3),
                          offset: const Offset(1.0, 1.0),
                        ),
                      ]
                    : null,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                color: isSelected
                    ? AppColors.backgroundColor.withOpacity(0.9)
                    : color.withOpacity(0.7),
                fontSize: 12,
                shadows: isSelected
                    ? [
                        Shadow(
                          blurRadius: 2.0,
                          color: AppColors.textColor.withOpacity(0.2),
                          offset: const Offset(1.0, 1.0),
                        ),
                      ]
                    : null,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
