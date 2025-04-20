import 'package:flutter/material.dart';

class ExplorerCertificatePage extends StatefulWidget {
  const ExplorerCertificatePage({super.key});

  @override
  State<ExplorerCertificatePage> createState() =>
      _ExplorerCertificatePageState();
}

class _ExplorerCertificatePageState extends State<ExplorerCertificatePage> {
  List<Offset> _points = [];
  bool _isSignatureComplete = false;
  bool _isDrawing = false;

  void _startDrawing(Offset point) {
    setState(() {
      _isDrawing = true;
      _points = [point];
    });
  }

  void _updateDrawing(Offset point) {
    if (_isDrawing) {
      setState(() {
        _points = List.from(_points)..add(point);
      });
    }
  }

  void _endDrawing() {
    setState(() {
      _isDrawing = false;
      if (_points.isNotEmpty) {
        _isSignatureComplete = true;
      }
    });
  }

  void _clearSignature() {
    setState(() {
      _points = [];
      _isSignatureComplete = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Kaşif Yemini',
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
          Container(
            width: 600,
            padding: const EdgeInsets.all(24),
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
                  'Ben, bir Dünya Kaşifi olarak,',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: const Color(0xFF1A237E),
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 16),
                Text(
                  'dünyayı keşfetmeye,\nyeni şeyler öğrenmeye\nve doğayı korumaya\nsöz veriyorum!',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: const Color(0xFF0D47A1),
                        height: 1.5,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32),
                // İmza alanı
                Container(
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF1A237E),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Stack(
                    children: [
                      // İmza alanı
                      GestureDetector(
                        onPanStart: (details) =>
                            _startDrawing(details.localPosition),
                        onPanUpdate: (details) =>
                            _updateDrawing(details.localPosition),
                        onPanEnd: (details) => _endDrawing(),
                        child: CustomPaint(
                          painter: InteractiveSignaturePainter(_points),
                          size: const Size(200, 100),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // İmza temizleme butonu
                if (_points.isNotEmpty)
                  TextButton.icon(
                    onPressed: _clearSignature,
                    icon: const Icon(Icons.refresh),
                    label: const Text('İmzayı Temizle'),
                    style: TextButton.styleFrom(
                      foregroundColor: const Color(0xFF1A237E),
                    ),
                  ),
                const SizedBox(height: 24),
                // Sertifika butonu
                if (_isSignatureComplete)
                  ElevatedButton(
                    onPressed: () {
                      // TODO: Sertifika oluştur ve göster
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A237E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: const Text('Sertifikanı Al'),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InteractiveSignaturePainter extends CustomPainter {
  final List<Offset> points;

  InteractiveSignaturePainter(this.points);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFF1A237E)
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    for (var i = 0; i < points.length - 1; i++) {
      canvas.drawLine(points[i], points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(InteractiveSignaturePainter oldDelegate) =>
      oldDelegate.points != points;
}
