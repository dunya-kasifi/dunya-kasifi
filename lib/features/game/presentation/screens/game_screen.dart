import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/app_colors.dart';
import '../widgets/ar_view.dart';
import 'map_screen.dart';
import '../controllers/game_controller.dart';

class GameScreen extends GetView<GameController> {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Gradient Arka Plan
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppColors.primaryColor.withAlpha(230),
                  AppColors.secondaryColor.withAlpha(230),
                ],
              ),
            ),
          ),

          // Ana İçerik (Harita veya AR)
          Positioned.fill(
            child: Obx(() =>
                controller.isARMode.value ? const ARView() : const MapScreen()),
          ),

          // Üst Bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.only(
                left: 16,
                right: 16,
                top: 36,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor.withAlpha(25),
                border: Border(
                  bottom: BorderSide(
                    color: AppColors.backgroundColor.withAlpha(51),
                    width: 1,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Kaşif Pasaportu Butonu
                  _TopBarButton(
                    icon: Icons.book,
                    label: 'Pasaport',
                    onTap: () {
                      // TODO: Show explorer passport
                    },
                  ),
                  // AR/Harita Modu Değiştirme Butonu
                  Obx(() => _TopBarButton(
                        icon: controller.isARMode.value
                            ? Icons.map
                            : Icons.view_in_ar,
                        label: controller.isARMode.value ? 'Harita' : 'AR',
                        onTap: () => controller.toggleARMode(),
                      )),
                ],
              ),
            ),
          ).animate().fadeIn().slideY(begin: -0.2, end: 0),

          // Alt Ekipman Çubuğu
          Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: Container(
              height: 90,
              decoration: BoxDecoration(
                color: AppColors.backgroundColor.withAlpha(25),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: AppColors.backgroundColor.withAlpha(51),
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.textColor.withAlpha(51),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _EquipmentItem(
                    icon: Icons.explore,
                    label: 'Pusula',
                    onTap: () {
                      // TODO: Activate compass
                    },
                  ),
                  _EquipmentItem(
                    icon: Icons.camera_alt,
                    label: 'Kamera',
                    onTap: () {
                      // TODO: Open camera
                    },
                  ),
                  _EquipmentItem(
                    icon: Icons.book,
                    label: 'Not',
                    onTap: () {
                      // TODO: Open notebook
                    },
                  ),
                  _EquipmentItem(
                    icon: Icons.flight,
                    label: 'Uçuş',
                    onTap: () {
                      // TODO: Toggle flight mode
                    },
                  ),
                ],
              ),
            ),
          ).animate().fadeIn().slideY(begin: 0.2, end: 0),
        ],
      ),
    );
  }
}

class _TopBarButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _TopBarButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.backgroundColor.withAlpha(25),
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: AppColors.backgroundColor.withAlpha(51),
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: AppColors.backgroundColor,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: AppColors.backgroundColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _EquipmentItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _EquipmentItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.backgroundColor.withAlpha(51),
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.backgroundColor.withAlpha(77),
                  width: 2,
                ),
              ),
              child: Icon(
                icon,
                color: AppColors.backgroundColor,
                size: 24,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: AppColors.backgroundColor,
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ],
        ),
      ),
    );
  }
}
