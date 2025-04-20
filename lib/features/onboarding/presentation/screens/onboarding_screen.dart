import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';
import '../../../game/presentation/screens/game_screen.dart';
import '../controllers/onboarding_controller.dart';
import '../pages/welcome_page.dart';
import '../pages/avatar_creation_page.dart';
import '../pages/equipment_selection_page.dart';
import '../pages/favorite_vehicle_page.dart';
import '../pages/explorer_certificate_page.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OnboardingController controller = Get.put(OnboardingController());

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Arka plan animasyonu sadece WelcomePage için
          Obx(() => controller.currentPage.value == 0
              ? Positioned.fill(
                  child: FutureBuilder<LottieComposition>(
                    future:
                        AssetLottie('assets/animations/onboarding.json').load(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                          child: Text(
                            'Animasyon yüklenemedi: ${snapshot.error}',
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      }
                      if (!snapshot.hasData) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        );
                      }
                      return LayoutBuilder(
                        builder: (context, constraints) {
                          return Lottie(
                            composition: snapshot.data,
                            fit: BoxFit.fill,
                            width: constraints.maxWidth,
                            height: constraints.maxHeight,
                            repeat: true,
                            options: LottieOptions(
                              enableMergePaths: true,
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              : Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF1A237E).withOpacity(0.8),
                          const Color(0xFF0D47A1).withOpacity(0.8),
                          const Color(0xFF1565C0).withOpacity(0.8),
                        ],
                        stops: const [0.0, 0.5, 1.0],
                      ),
                    ),
                  ),
                )),
          // İçerik
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: controller.pageController,
                    onPageChanged: controller.updatePage,
                    children: const [
                      WelcomePage(),
                      AvatarCreationPage(),
                      EquipmentSelectionPage(),
                      FavoriteVehiclePage(),
                      ExplorerCertificatePage(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(() => Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          if (controller.currentPage.value > 0)
                            ElevatedButton.icon(
                              onPressed: controller.previousPage,
                              icon: const Icon(Icons.arrow_back_ios, size: 16),
                              label: const Text('Geri'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.white.withOpacity(0.9),
                                foregroundColor: const Color(0xFF1A237E),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 12,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            )
                          else
                            const SizedBox.shrink(),
                          Obx(() {
                            final isLastPage =
                                controller.currentPage.value == 4;
                            final isCertificateComplete =
                                controller.isSignatureComplete.value;
                            final canProceed = !isLastPage ||
                                (isLastPage && isCertificateComplete);

                            return controller.currentPage < 4
                                ? ElevatedButton.icon(
                                    onPressed: canProceed
                                        ? () {
                                            if (controller.currentPage.value <
                                                4) {
                                              controller.nextPage();
                                            } else {
                                              Navigator.of(context)
                                                  .pushReplacement(
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      const GameScreen(),
                                                ),
                                              );
                                            }
                                          }
                                        : null,
                                    icon: controller.currentPage.value < 4
                                        ? const Icon(Icons.arrow_forward_ios,
                                            size: 16)
                                        : const Icon(Icons.play_arrow,
                                            size: 20),
                                    label: Text(controller.currentPage.value < 4
                                        ? 'İleri'
                                        : 'Maceraya Başla'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: canProceed
                                          ? Colors.white.withOpacity(0.9)
                                          : Colors.white.withOpacity(0.3),
                                      foregroundColor: const Color(0xFF1A237E),
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical: 12,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                  )
                                : SizedBox();
                          }),
                        ],
                      )),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
