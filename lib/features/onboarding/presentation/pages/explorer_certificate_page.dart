import 'dart:math' show pi;
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:confetti/confetti.dart';
import '../../../game/presentation/screens/game_screen.dart';
import '../controllers/onboarding_controller.dart';

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
  late ConfettiController _confettiController;
  bool _showCertificate = false;
  final GlobalKey _signatureKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _confettiController =
        ConfettiController(duration: const Duration(seconds: 3));
  }

  @override
  void dispose() {
    _confettiController.dispose();
    super.dispose();
  }

  void _startDrawing(Offset point) {
    final RenderBox? box =
        _signatureKey.currentContext?.findRenderObject() as RenderBox?;
    if (box != null) {
      final localPosition = box.globalToLocal(point);
      setState(() {
        _isDrawing = true;
        _points = [localPosition];
      });
    }
  }

  void _updateDrawing(Offset point) {
    if (_isDrawing) {
      final RenderBox? box =
          _signatureKey.currentContext?.findRenderObject() as RenderBox?;
      if (box != null) {
        final localPosition = box.globalToLocal(point);
        setState(() {
          _points = List.from(_points)..add(localPosition);
        });
      }
    }
  }

  void _endDrawing() {
    setState(() {
      _isDrawing = false;
      if (_points.isNotEmpty) {
        _isSignatureComplete = true;
        Get.find<OnboardingController>().updateSignatureStatus(true);
      }
    });
  }

  void _clearSignature() {
    setState(() {
      _points = [];
      _isSignatureComplete = false;
      Get.find<OnboardingController>().updateSignatureStatus(false);
    });
  }

  void _showCertificateAnimation() {
    setState(() {
      _showCertificate = true;
    });
    _confettiController.play();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Ana içerik
        if (!_showCertificate)
          Center(
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
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: const Color(0xFF0D47A1),
                                  height: 1.5,
                                ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 32),
                      // İmza alanı
                      Container(
                        key: _signatureKey,
                        height: 100,
                        width: 200,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color(0xFF1A237E),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: GestureDetector(
                          onPanStart: (details) =>
                              _startDrawing(details.globalPosition),
                          onPanUpdate: (details) =>
                              _updateDrawing(details.globalPosition),
                          onPanEnd: (details) => _endDrawing(),
                          child: CustomPaint(
                            painter: InteractiveSignaturePainter(_points),
                            size: const Size(200, 100),
                          ),
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
                          onPressed: _showCertificateAnimation,
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
          ),
        // Arka plan bulanıklığı
        if (_showCertificate)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
        // Konfeti efekti
        if (_showCertificate)
          Positioned.fill(
            child: ConfettiWidget(
              confettiController: _confettiController,
              blastDirection: pi / 2,
              maxBlastForce: 5,
              minBlastForce: 2,
              emissionFrequency: 0.05,
              numberOfParticles: 50,
              gravity: 0.1,
              shouldLoop: false,
              colors: const [
                Colors.green,
                Colors.blue,
                Colors.pink,
                Colors.orange,
                Colors.purple
              ],
            ),
          ),
        // Sertifika animasyonu
        if (_showCertificate)
          Center(
            child: Transform.rotate(
              angle: -0.05, // Daha az dönük
              child: Container(
                width: 400,
                height: 300,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Dünya Kaşifi Sertifikası',
                      style:
                          Theme.of(context).textTheme.headlineSmall?.copyWith(
                                color: const Color(0xFF1A237E),
                                fontWeight: FontWeight.bold,
                              ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Tebrikler! Artık bir Dünya Kaşifisin!',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            color: const Color(0xFF0D47A1),
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Container(
                      height: 2,
                      color: const Color(0xFF1A237E),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Bu sertifika, dünyayı keşfetme ve doğayı koruma sözünü verdiğini onaylar.',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: Colors.black87,
                          ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const GameScreen(),
                          ),
                        );
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
                      child: const Text('Maceraya Başla'),
                    ),
                  ],
                ),
              ),
            )
                .animate()
                .fadeIn(duration: 500.ms)
                .scale(delay: 200.ms, duration: 500.ms)
                .rotate(
                    delay: 200.ms, duration: 500.ms, begin: -0.1, end: -0.05),
          ),
      ],
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
