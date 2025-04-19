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
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Arka plan animasyonu
          Positioned.fill(
            child: FutureBuilder<LottieComposition>(
              future: AssetLottie('assets/animations/onboarding.json').load(),
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
          ),
          // İçerik
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: _pageController,
                    onPageChanged: (index) =>
                        setState(() => _currentPage = index),
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
                        ElevatedButton.icon(
                          onPressed: () => _pageController.previousPage(
                            duration: 300.ms,
                            curve: Curves.easeInOut,
                          ),
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
                      ElevatedButton.icon(
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
                        icon: _currentPage < 3
                            ? const Icon(Icons.arrow_forward_ios, size: 16)
                            : const Icon(Icons.play_arrow, size: 20),
                        label:
                            Text(_currentPage < 3 ? 'İleri' : 'Maceraya Başla'),
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
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  const _WelcomePage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
              vertical: 16.0,
            ),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Kaşif Akademisi\'ne\nHoş Geldin!',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        color: const Color(0xFF1A237E),
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn().scale(),
                const SizedBox(height: 16),
                Text(
                  'Dünyayı keşfetmeye hazır mısın?',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: const Color(0xFF0D47A1),
                      ),
                  textAlign: TextAlign.center,
                ).animate().fadeIn(delay: 300.ms),
              ],
            ),
          ),
        ],
      ),
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
