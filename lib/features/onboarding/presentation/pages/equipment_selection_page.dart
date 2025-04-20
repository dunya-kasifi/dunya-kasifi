import 'package:flutter/material.dart';

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
    const Color.fromARGB(255, 23, 223, 136), // Açık Yeşil
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
          ),
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
                        ),
                        _EquipmentCard(
                          title: 'Not Defteri',
                          description: 'Keşiflerini kaydetmek için!',
                          icon: Icons.book,
                          isSelected: _selectedEquipment[1],
                          color: _cardColors[1],
                          onSelect: () => setState(() =>
                              _selectedEquipment[1] = !_selectedEquipment[1]),
                        ),
                        _EquipmentCard(
                          title: 'Fotoğraf Makinesi',
                          description: 'Anılarını ölümsüzleştir!',
                          icon: Icons.camera_alt,
                          isSelected: _selectedEquipment[2],
                          color: _cardColors[2],
                          onSelect: () => setState(() =>
                              _selectedEquipment[2] = !_selectedEquipment[2]),
                        ),
                        _EquipmentCard(
                          title: 'Sanal Dürbün',
                          description: 'Uzakları yakın et!',
                          icon: Icons.remove_red_eye,
                          isSelected: _selectedEquipment[3],
                          color: _cardColors[3],
                          onSelect: () => setState(() =>
                              _selectedEquipment[3] = !_selectedEquipment[3]),
                        ),
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
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          const Color(0xFF1A237E).withOpacity(0.8),
                          const Color(0xFF0D47A1).withOpacity(0.8),
                        ],
                      ),
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Seçilen Ekipmanlar',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(4, (index) {
                                if (_selectedEquipment[index]) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 8),
                                      decoration: BoxDecoration(
                                        color:
                                            _cardColors[index].withOpacity(0.2),
                                        borderRadius: BorderRadius.circular(15),
                                        border: Border.all(
                                          color: _cardColors[index],
                                          width: 2,
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            [
                                              Icons.explore,
                                              Icons.book,
                                              Icons.camera_alt,
                                              Icons.remove_red_eye,
                                            ][index],
                                            color: _cardColors[index],
                                            size: 20,
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            [
                                              'Sihirli Pusula',
                                              'Not Defteri',
                                              'Fotoğraf Makinesi',
                                              'Sanal Dürbün',
                                            ][index],
                                            style: TextStyle(
                                              color: _cardColors[index],
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
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
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                size: 32,
                color: isSelected ? color : color.withOpacity(0.8),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : color,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              description,
              style: TextStyle(
                color: isSelected
                    ? Colors.white.withOpacity(0.8)
                    : color.withOpacity(0.6),
                fontSize: 10,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
