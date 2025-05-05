import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Gradient Arka Plan
        Container(
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
        ),

        // Harita İçeriği
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 80, // Üst bar için boşluk
              bottom: 112, // Alt bar için boşluk (80 + 32)
              left: 16,
              right: 16,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: const Center(
                child: Text(
                  'Harita İçeriği',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ).animate().fadeIn().slideY(begin: 0.2, end: 0),
      ],
    );
  }
}
