import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../widgets/ar_view.dart';
import 'map_screen.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // AR View
          const Positioned.fill(
            child: ARView(),
          ),

          // Flight Route Map
          Positioned(
            top: 16,
            right: 16,
            child: _MapButton(),
          ),

          // Equipment Bar
          Positioned(
            bottom: 16,
            left: 16,
            right: 16,
            child: _EquipmentBar(),
          ),

          // Explorer Passport
          Positioned(
            top: 16,
            left: 16,
            child: _PassportButton(),
          ),
        ],
      ),
    );
  }
}

class _MapButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'map',
      child: const Icon(Icons.map),
      onPressed: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => const MapScreen(),
          ),
        );
      },
    );
  }
}

class _PassportButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: 'passport',
      child: const Icon(Icons.book),
      onPressed: () {
        // TODO: Show explorer passport
      },
    );
  }
}

class _EquipmentBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
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
            label: 'Not Defteri',
            onTap: () {
              // TODO: Open notebook
            },
          ),
          _EquipmentItem(
            icon: Icons.flight,
            label: 'Uçuş Modu',
            onTap: () {
              // TODO: Toggle flight mode
            },
          ),
        ],
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
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
