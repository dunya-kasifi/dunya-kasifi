import 'package:flutter/material.dart';

class ARView extends StatelessWidget {
  const ARView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          color: Colors.black.withOpacity(0.5),
        ),
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
                  'AR View',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
