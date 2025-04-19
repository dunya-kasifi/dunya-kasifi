import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import '../../../game/presentation/screens/game_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentPage = index),
                children: const [
                  _WelcomePage(),
                  _AvatarCreationPage(),
                  _EquipmentSelectionPage(),
                  _ExplorerCertificatePage(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    TextButton(
                      onPressed: () => _pageController.previousPage(
                        duration: 300.ms,
                        curve: Curves.easeInOut,
                      ),
                      child: const Text('Geri'),
                    )
                  else
                    const SizedBox.shrink(),
                  TextButton(
                    onPressed: () {
                      if (_currentPage < 3) {
                        _pageController.nextPage(
                          duration: 300.ms,
                          curve: Curves.easeInOut,
                        );
                      } else {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const GameScreen(),
                          ),
                        );
                      }
                    },
                    child: Text(_currentPage < 3 ? 'İleri' : 'Maceraya Başla'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Arka plan animasyonu
        Positioned.fill(
          child: Lottie.asset(
            'assets/animations/lotties/onboarding.lottie',
            fit: BoxFit.cover,
          ),
        ),
        // İçerik
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 32),
              Text(
                'Kaşif Akademisi\'ne\nHoş Geldin!',
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
                textAlign: TextAlign.center,
              ).animate().fadeIn().scale(),
              const SizedBox(height: 16),
              Text(
                'Dünyayı keşfetmeye hazır mısın?',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(2.0, 2.0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ).animate().fadeIn(delay: 300.ms),
            ],
          ),
        ),
      ],
    );
  }
}

class _AvatarCreationPage extends StatelessWidget {
  const _AvatarCreationPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Karakterini Oluştur',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              children: [
                _CustomizationCard(
                  title: 'Saç Stili',
                  icon: Icons.face,
                  onTap: () {
                    // TODO: Implement hair style selection
                  },
                ),
                _CustomizationCard(
                  title: 'Göz Rengi',
                  icon: Icons.remove_red_eye,
                  onTap: () {
                    // TODO: Implement eye color selection
                  },
                ),
                _CustomizationCard(
                  title: 'Kıyafetler',
                  icon: Icons.checkroom,
                  onTap: () {
                    // TODO: Implement clothing selection
                  },
                ),
                _CustomizationCard(
                  title: 'Aksesuarlar',
                  icon: Icons.star,
                  onTap: () {
                    // TODO: Implement accessories selection
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _EquipmentSelectionPage extends StatelessWidget {
  const _EquipmentSelectionPage();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Keşif Ekipmanlarını Seç',
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: 24),
          Expanded(
            child: ListView(
              children: [
                _EquipmentCard(
                  title: 'Sihirli Pusula',
                  description: 'Her zaman doğru yönü gösterir!',
                  icon: Icons.explore,
                  onSelect: () {
                    // TODO: Implement equipment selection
                  },
                ),
                _EquipmentCard(
                  title: 'Not Defteri',
                  description: 'Keşiflerini kaydetmek için!',
                  icon: Icons.book,
                  onSelect: () {
                    // TODO: Implement equipment selection
                  },
                ),
                _EquipmentCard(
                  title: 'Fotoğraf Makinesi',
                  description: 'Anılarını ölümsüzleştir!',
                  icon: Icons.camera_alt,
                  onSelect: () {
                    // TODO: Implement equipment selection
                  },
                ),
                _EquipmentCard(
                  title: 'Sihirli Halı',
                  description: 'Uçarak dünyayı keşfet!',
                  icon: Icons.flight,
                  onSelect: () {
                    // TODO: Implement equipment selection
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ExplorerCertificatePage extends StatelessWidget {
  const _ExplorerCertificatePage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '🎉',
            style: TextStyle(fontSize: 64),
          ),
          const SizedBox(height: 24),
          Text(
            'Kaşif Yemini',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              'Ben, bir Dünya Kaşifi olarak, dünyayı keşfetmeye, yeni şeyler öğrenmeye ve doğayı korumaya söz veriyorum!',
              style: Theme.of(context).textTheme.bodyLarge,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () {
              // TODO: Generate and show certificate
            },
            child: const Text('Sertifikanı Al'),
          ),
        ],
      ),
    );
  }
}

class _CustomizationCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  const _CustomizationCard({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 48),
              const SizedBox(height: 8),
              Text(title),
            ],
          ),
        ),
      ),
    );
  }
}

class _EquipmentCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final VoidCallback onSelect;

  const _EquipmentCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, size: 32),
        title: Text(title),
        subtitle: Text(description),
        trailing: IconButton(
          icon: const Icon(Icons.add_circle_outline),
          onPressed: onSelect,
        ),
      ),
    );
  }
}
