import 'dart:math';

import 'package:flutter/material.dart';

class WelcomeScreenTwo extends StatelessWidget {
  const WelcomeScreenTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECEAD5), // Light beige background color
      body: SafeArea(
        child: Column(
          children: [
            // Status bar area and step indicator
            Padding(
              padding: const EdgeInsets.only(top: 20.0, bottom: 10.0),
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 30,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color(0xFF533D2D),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: const Text(
                    'Step One',
                    style: TextStyle(
                      color: Color(0xFF533D2D),
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),

            // Illustration area
            Expanded(
              child: Stack(
                children: [
                  // Background clouds
                  Positioned(top: 20, left: 20, child: _buildCloud(80, 40)),
                  Positioned(top: 10, right: 30, child: _buildCloud(100, 50)),
                  Positioned(top: 150, left: 10, child: _buildCloud(70, 35)),
                  Positioned(top: 180, right: 20, child: _buildCloud(90, 45)),

                  // Character illustration - should be replaced with actual asset
                  Center(
                    child: SizedBox(
                      width: 300,
                      height: 400,
                      child: CustomPaint(painter: CharacterPainter()),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom white container with progress and text
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  // Progress indicator
                  Container(
                    height: 10,
                    width: 250,
                    decoration: BoxDecoration(
                      color: const Color(0xFFECDAD5),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 120,
                          height: 10,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B6F54),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Main heading text
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF533D2D),
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(text: 'Personalize Your Mental\n'),
                        TextSpan(
                          text: 'Health State ',
                          style: TextStyle(
                            color: Color(0xFF8BA872), // Light green color
                          ),
                        ),
                        TextSpan(text: 'With AI'),
                      ],
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Next button
                  InkWell(
                    onTap: () {
                      // Navigation logic to the next screen
                      print('Next button pressed');
                    },
                    child: Container(
                      width: 70,
                      height: 70,
                      decoration: const BoxDecoration(
                        color: Color(0xFF533D2D),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                        size: 30,
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  // Home indicator
                  Container(
                    width: 120,
                    height: 5,
                    decoration: BoxDecoration(
                      color: const Color(0xFF533D2D),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Helper method to create cloud shapes
  Widget _buildCloud(double width, double height) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.7),
        borderRadius: BorderRadius.circular(30),
      ),
    );
  }
}

// Custom painter for the character
class CharacterPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFF8BA872) // Green body color
          ..style = PaintingStyle.fill;

    // Green body/clothing shape (simplified)
    final Path bodyPath =
        Path()
          ..moveTo(size.width * 0.1, size.height * 0.6)
          ..quadraticBezierTo(
            size.width * 0.5,
            size.height * 0.9,
            size.width * 0.9,
            size.height * 0.6,
          )
          ..lineTo(size.width * 0.9, size.height)
          ..lineTo(size.width * 0.1, size.height)
          ..close();

    canvas.drawPath(bodyPath, paint);

    // Hair/head shape
    paint.color = const Color(0xFF533D2D); // Brown hair color
    final Path hairPath =
        Path()..addOval(
          Rect.fromCenter(
            center: Offset(size.width * 0.5, size.height * 0.4),
            width: size.width * 0.7,
            height: size.width * 0.7,
          ),
        );

    // Add curly details to hair
    for (int i = 0; i < 6; i++) {
      double angle = i * (3.14159 / 3);
      double x = size.width * 0.5 + (size.width * 0.4) * cos(angle);
      double y = size.height * 0.4 + (size.width * 0.4) * sin(angle);

      Path curlPath =
          Path()..addOval(Rect.fromCircle(center: Offset(x, y), radius: 15));

      hairPath.addPath(curlPath, Offset.zero);
    }

    canvas.drawPath(hairPath, paint);

    // Face
    paint.color = const Color(0xFFD1D6B8); // Light green face
    canvas.drawOval(
      Rect.fromCenter(
        center: Offset(size.width * 0.45, size.height * 0.4),
        width: size.width * 0.3,
        height: size.height * 0.25,
      ),
      paint,
    );

    // Eyes (closed)
    paint.color = const Color(0xFF533D2D);
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;

    // Left eye
    canvas.drawLine(
      Offset(size.width * 0.35, size.height * 0.35),
      Offset(size.width * 0.4, size.height * 0.35),
      paint,
    );

    // Right eye
    canvas.drawLine(
      Offset(size.width * 0.45, size.height * 0.35),
      Offset(size.width * 0.5, size.height * 0.35),
      paint,
    );

    // Hands/arms
    paint.color = const Color(0xFF533D2D);
    paint.strokeWidth = 2;

    // Multiple lines for the streaming/crying effect
    for (int i = 0; i < 6; i++) {
      double startX = size.width * (0.4 + i * 0.03);
      canvas.drawLine(
        Offset(startX, size.height * 0.45),
        Offset(startX, size.height * 0.6),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
