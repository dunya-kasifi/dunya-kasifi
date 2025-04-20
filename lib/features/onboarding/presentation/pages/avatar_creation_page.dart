import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class AvatarCreationPage extends StatefulWidget {
  const AvatarCreationPage({super.key});

  @override
  State<AvatarCreationPage> createState() => _AvatarCreationPageState();
}

class _AvatarCreationPageState extends State<AvatarCreationPage> {
  int _selectedAvatarIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Karakterini Seç',
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
          const SizedBox(height: 32),
          // Seçilen avatar
          Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(100),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
              border: Border.all(
                color: const Color(0xFF1A237E),
                width: 3,
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.asset(
                'assets/images/avatars/${_selectedAvatarIndex + 1}.jpeg',
                fit: BoxFit.cover,
              ),
            ),
          ).animate().fadeIn(delay: 200.ms).scale(),
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
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 2,
              ),
            ),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 6,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => setState(() => _selectedAvatarIndex = index),
                  child: Container(
                    width: 80,
                    height: 80,
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(40),
                      border: Border.all(
                        color: _selectedAvatarIndex == index
                            ? const Color(0xFF1A237E)
                            : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: _selectedAvatarIndex == index
                              ? const Color(0xFF1A237E).withOpacity(0.3)
                              : Colors.black.withOpacity(0.2),
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
              },
            ),
          ),
          const SizedBox(height: 24),
          // Karakter adı
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color:
                    const Color.fromARGB(255, 255, 255, 255).withOpacity(0.3),
                width: 2,
              ),
            ),
            child: Text(
              [
                'Cesur Kaşif',
                'Bilge Gezgin',
                'Maceraperest',
                'Doğa Dostu',
                'Gizem Avcısı',
                'Yıldız Gezgini'
              ][_selectedAvatarIndex],
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
          ).animate().fadeIn(delay: 800.ms).scale(),
        ],
      ),
    );
  }
}
