import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

class EquipmentSelectionPage extends StatefulWidget {
  const EquipmentSelectionPage({super.key});

  @override
  State<EquipmentSelectionPage> createState() => _EquipmentSelectionPageState();
}

class _EquipmentSelectionPageState extends State<EquipmentSelectionPage> {
  final List<bool> _selectedEquipment = List.generate(4, (index) => false);
  final List<Color> _cardColors = [
    const Color(0xFFFF6B6B), // Kırmızı
    const Color(0xFF4ECDC4), // Turkuaz
    const Color(0xFFFFD166), // Sarı
    const Color(0xFF7E4AE5), // Mor
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Keşif Ekipmanlarını Seç',
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
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: Colors.white.withOpacity(0.2),
                        width: 2,
                      ),
                    ),
                    child: GridView.count(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.2,
                      children: [
                        _EquipmentCard(
                          title: 'Sihirli Pusula',
                          description: 'Her zaman doğru yönü gösterir!',
                          icon: Icons.explore,
                          isSelected: _selectedEquipment[0],
                          color: _cardColors[0],
                          onSelect: () => setState(() =>
                              _selectedEquipment[0] = !_selectedEquipment[0]),
                        ).animate().fadeIn(delay: 200.ms).slideX(),
                        _EquipmentCard(
                          title: 'Not Defteri',
                          description: 'Keşiflerini kaydetmek için!',
                          icon: Icons.book,
                          isSelected: _selectedEquipment[1],
                          color: _cardColors[1],
                          onSelect: () => setState(() =>
                              _selectedEquipment[1] = !_selectedEquipment[1]),
                        ).animate().fadeIn(delay: 400.ms).slideX(),
                        _EquipmentCard(
                          title: 'Fotoğraf Makinesi',
                          description: 'Anılarını ölümsüzleştir!',
                          icon: Icons.camera_alt,
                          isSelected: _selectedEquipment[2],
                          color: _cardColors[2],
                          onSelect: () => setState(() =>
                              _selectedEquipment[2] = !_selectedEquipment[2]),
                        ).animate().fadeIn(delay: 600.ms).slideX(),
                        _EquipmentCard(
                          title: 'Sanal Dürbün',
                          description: 'Uzakları yakın et!',
                          icon: Icons.remove_red_eye,
                          isSelected: _selectedEquipment[3],
                          color: _cardColors[3],
                          onSelect: () => setState(() =>
                              _selectedEquipment[3] = !_selectedEquipment[3]),
                        ).animate().fadeIn(delay: 800.ms).slideX(),
                      ],
                    ),
                  ),
                  const SizedBox(width: 32),
                  // Sağ taraf - Seçilen ekipmanların önizlemesi
                  Container(
                    width: 250,
                    height: 400,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      /* gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF91EDFF).withOpacity(0.9),
                          const Color(0xFFB8F0FF).withOpacity(0.9),
                        ],
                      ), */
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                      border: Border.all(
                        color: Colors.white.withOpacity(0.5),
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
                            color: const Color(0xFF1A237E).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFF1A237E).withOpacity(0.3),
                              width: 2,
                            ),
                          ),
                          child: Text(
                            'Seçilen Ekipmanlar',
                            style: TextStyle(
                              color: const Color(0xFF1A237E),
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              shadows: [
                                Shadow(
                                  blurRadius: 2.0,
                                  color: Colors.white.withOpacity(0.5),
                                  offset: const Offset(1.0, 1.0),
                                ),
                              ],
                            ),
                          ),
                        ).animate().fadeIn().scale(),
                        const SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(4, (index) {
                                if (_selectedEquipment[index]) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 16, vertical: 12),
                                      decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          begin: Alignment.topLeft,
                                          end: Alignment.bottomRight,
                                          colors: [
                                            _cardColors[index].withOpacity(0.2),
                                            _cardColors[index].withOpacity(0.1),
                                          ],
                                        ),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: _cardColors[index],
                                          width: 2,
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: _cardColors[index]
                                                .withOpacity(0.2),
                                            blurRadius: 5,
                                            offset: const Offset(0, 2),
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.all(6),
                                            decoration: BoxDecoration(
                                              color: _cardColors[index]
                                                  .withOpacity(0.1),
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: _cardColors[index],
                                                width: 2,
                                              ),
                                            ),
                                            child: Icon(
                                              [
                                                Icons.explore,
                                                Icons.book,
                                                Icons.camera_alt,
                                                Icons.remove_red_eye,
                                              ][index],
                                              color: _cardColors[index],
                                              size: 18,
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Expanded(
                                            child: Text(
                                              [
                                                'Sihirli Pusula',
                                                'Not Defteri',
                                                'Fotoğraf Makinesi',
                                                'Sanal Dürbün',
                                              ][index],
                                              style: TextStyle(
                                                color: _cardColors[index],
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                shadows: [
                                                  Shadow(
                                                    blurRadius: 2.0,
                                                    color: Colors.white
                                                        .withOpacity(0.5),
                                                    offset:
                                                        const Offset(1.0, 1.0),
                                                  ),
                                                ],
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
                          ),
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
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isSelected
                ? [color, color.withOpacity(0.8)]
                : [Colors.white, Colors.white.withOpacity(0.9)],
          ),
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(
            color: isSelected ? color : Colors.grey.withOpacity(0.3),
            width: 2,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : color.withOpacity(0.1),
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
                color: isSelected ? Colors.white : color,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                shadows: isSelected
                    ? [
                        Shadow(
                          blurRadius: 2.0,
                          color: Colors.black.withOpacity(0.3),
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
                    ? Colors.white.withOpacity(0.9)
                    : color.withOpacity(0.7),
                fontSize: 12,
                shadows: isSelected
                    ? [
                        Shadow(
                          blurRadius: 2.0,
                          color: Colors.black.withOpacity(0.2),
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
