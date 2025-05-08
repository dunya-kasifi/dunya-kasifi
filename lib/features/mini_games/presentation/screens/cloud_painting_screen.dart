import 'package:flutter/material.dart';

class CloudPaintingScreen extends StatefulWidget {
  const CloudPaintingScreen({super.key});

  @override
  State<CloudPaintingScreen> createState() => _CloudPaintingScreenState();
}

class _CloudPaintingScreenState extends State<CloudPaintingScreen> {
  final List<Cloud> clouds = [];
  Color selectedColor = Colors.blue;
  double brushSize = 20.0;
  bool isErasing = false;

  @override
  void initState() {
    super.initState();
    _initializeClouds();
  }

  void _initializeClouds() {
    // Rastgele bulutlar oluştur
    for (int i = 0; i < 5; i++) {
      clouds.add(
        Cloud(
          position: Offset(
            (i + 1) * 100.0,
            (i % 2 == 0 ? 100.0 : 200.0),
          ),
          size: Size(150.0, 100.0),
          color: Colors.white,
          points: [],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulut Boyama'),
        backgroundColor: Colors.blue[100],
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                clouds.clear();
                _initializeClouds();
              });
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          // Arka plan
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.blue[100]!,
                  Colors.blue[50]!,
                ],
              ),
            ),
          ),
          // Bulutlar
          ...clouds.map((cloud) => _buildCloud(cloud)),
          // Renk seçici
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              color: Colors.white.withOpacity(0.8),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildColorButton(Colors.red),
                    _buildColorButton(Colors.blue),
                    _buildColorButton(Colors.green),
                    _buildColorButton(Colors.yellow),
                    _buildColorButton(Colors.purple),
                    _buildColorButton(Colors.orange),
                    _buildColorButton(Colors.pink),
                    _buildColorButton(Colors.brown),
                    _buildColorButton(Colors.black),
                    _buildColorButton(Colors.white),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCloud(Cloud cloud) {
    return Positioned(
      left: cloud.position.dx,
      top: cloud.position.dy,
      child: GestureDetector(
        onPanStart: (details) {
          final localPosition = details.localPosition;
          cloud.points.add(localPosition);
          setState(() {});
        },
        onPanUpdate: (details) {
          final localPosition = details.localPosition;
          cloud.points.add(localPosition);
          setState(() {});
        },
        child: CustomPaint(
          size: cloud.size,
          painter: CloudPainter(
            cloud: cloud,
            color: selectedColor,
            brushSize: brushSize,
            isErasing: isErasing,
          ),
        ),
      ),
    );
  }

  Widget _buildColorButton(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
          isErasing = color == Colors.white;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: color,
          shape: BoxShape.circle,
          border: Border.all(
            color: selectedColor == color ? Colors.black : Colors.grey,
            width: selectedColor == color ? 3 : 1,
          ),
        ),
      ),
    );
  }
}

class Cloud {
  final Offset position;
  final Size size;
  final Color color;
  final List<Offset> points;

  Cloud({
    required this.position,
    required this.size,
    required this.color,
    required this.points,
  });
}

class CloudPainter extends CustomPainter {
  final Cloud cloud;
  final Color color;
  final double brushSize;
  final bool isErasing;

  CloudPainter({
    required this.cloud,
    required this.color,
    required this.brushSize,
    required this.isErasing,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Bulut şekli
    final cloudPaint = Paint()
      ..color = cloud.color
      ..style = PaintingStyle.fill;

    final cloudPath = Path()
      ..moveTo(0, size.height * 0.4)
      ..cubicTo(
        size.width * 0.2,
        size.height * 0.2,
        size.width * 0.8,
        size.height * 0.2,
        size.width,
        size.height * 0.4,
      )
      ..cubicTo(
        size.width * 1.1,
        size.height * 0.6,
        size.width * 0.9,
        size.height * 0.8,
        size.width,
        size.height,
      )
      ..cubicTo(
        size.width * 0.8,
        size.height * 0.9,
        size.width * 0.2,
        size.height * 0.9,
        0,
        size.height,
      )
      ..cubicTo(
        size.width * -0.1,
        size.height * 0.8,
        size.width * -0.1,
        size.height * 0.6,
        0,
        size.height * 0.4,
      );

    canvas.drawPath(cloudPath, cloudPaint);

    // Çizimler
    final paint = Paint()
      ..color = isErasing ? Colors.white : color
      ..strokeWidth = brushSize
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round
      ..style = PaintingStyle.stroke;

    for (int i = 0; i < cloud.points.length - 1; i++) {
      canvas.drawLine(cloud.points[i], cloud.points[i + 1], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
