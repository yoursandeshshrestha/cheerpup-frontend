import 'dart:math';

import 'package:flutter/material.dart';

class WelcomeScreenSix extends StatelessWidget {
  const WelcomeScreenSix({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFD9D2F0), // Light purple background
      body: SafeArea(
        child: Column(
          children: [
            // Step indicator
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
                    'Step Five',
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
                fit: StackFit.expand,
                children: [
                  // Background waves
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CustomPaint(
                      size: const Size(double.infinity, 200),
                      painter: PurpleWavePainter(),
                    ),
                  ),

                  // Heart and hands illustration
                  Positioned(
                    top: 80,
                    left: 0,
                    right: 0,
                    child: CustomPaint(
                      size: const Size(double.infinity, 400),
                      painter: HandsHeartPainter(),
                    ),
                  ),

                  // White bottom curve
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Bottom white container with progress and text
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              color: Colors.white,
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
                    child: Stack(
                      children: [
                        Container(
                          width: 180,
                          height: 10,
                          decoration: BoxDecoration(
                            color: const Color(0xFF8B6F54),
                            borderRadius: BorderRadius.circular(5),
                          ),
                        ),
                        // Purple highlight on progress bar
                        Container(
                          margin: const EdgeInsets.all(1),
                          width: 178,
                          height: 8,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            border: Border.all(
                              color: const Color(0xFFB5B3E6),
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(4),
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
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(
                          text: 'Loving & Supportive\n',
                          style: TextStyle(
                            color: Color(0xFF533D2D), // Dark brown
                          ),
                        ),
                        TextSpan(
                          text: 'Community',
                          style: TextStyle(
                            color: Color(0xFFB5B3E6), // Light purple
                          ),
                        ),
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
}

// Painter for purple wave background
class PurpleWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFC3BBE3).withOpacity(0.7) // Lighter purple
          ..style = PaintingStyle.fill;

    final path =
        Path()
          ..moveTo(0, 0)
          ..lineTo(size.width, 0)
          ..lineTo(size.width, size.height * 0.7)
          ..quadraticBezierTo(
            size.width * 0.7,
            size.height * 0.9,
            size.width * 0.5,
            size.height * 0.6,
          )
          ..quadraticBezierTo(
            size.width * 0.3,
            size.height * 0.3,
            0,
            size.height * 0.5,
          )
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Painter for hands and heart
class HandsHeartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Paint for heart
    final heartPaint =
        Paint()
          ..color = const Color(0xFFB5B3E6) // Light purple for heart
          ..style = PaintingStyle.fill;

    // Draw heart
    final heartPath = Path();
    // Left side of heart
    heartPath.moveTo(size.width * 0.5, size.height * 0.25);
    heartPath.cubicTo(
      size.width * 0.4,
      size.height * 0.1,
      size.width * 0.2,
      size.height * 0.15,
      size.width * 0.25,
      size.height * 0.3,
    );
    heartPath.cubicTo(
      size.width * 0.3,
      size.height * 0.4,
      size.width * 0.4,
      size.height * 0.45,
      size.width * 0.5,
      size.height * 0.5,
    );

    // Right side of heart
    heartPath.cubicTo(
      size.width * 0.6,
      size.height * 0.45,
      size.width * 0.7,
      size.height * 0.4,
      size.width * 0.75,
      size.height * 0.3,
    );
    heartPath.cubicTo(
      size.width * 0.8,
      size.height * 0.15,
      size.width * 0.6,
      size.height * 0.1,
      size.width * 0.5,
      size.height * 0.25,
    );

    canvas.drawPath(heartPath, heartPaint);

    // Heart highlights
    final highlightPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    final highlight1 =
        Path()
          ..moveTo(size.width * 0.3, size.height * 0.2)
          ..quadraticBezierTo(
            size.width * 0.35,
            size.height * 0.15,
            size.width * 0.4,
            size.height * 0.2,
          );

    final highlight2 =
        Path()
          ..moveTo(size.width * 0.65, size.height * 0.2)
          ..quadraticBezierTo(
            size.width * 0.7,
            size.height * 0.15,
            size.width * 0.75,
            size.height * 0.2,
          );

    canvas.drawPath(highlight1, highlightPaint);
    canvas.drawPath(highlight2, highlightPaint);

    // Left light-skinned hand
    final lightHandPaint =
        Paint()
          ..color = const Color(0xFFBEA89B) // Light skin tone
          ..style = PaintingStyle.fill;

    final leftHandPath = Path();
    leftHandPath.moveTo(size.width * 0.15, size.height * 0.6);
    leftHandPath.lineTo(size.width * 0.25, size.height * 0.45);
    leftHandPath.lineTo(size.width * 0.35, size.height * 0.5);
    leftHandPath.lineTo(size.width * 0.25, size.height * 0.65);
    leftHandPath.close();

    canvas.drawPath(leftHandPath, lightHandPaint);

    // Right dark-skinned hand
    final darkHandPaint =
        Paint()
          ..color = const Color(0xFF533D2D) // Dark skin tone
          ..style = PaintingStyle.fill;

    final rightHandPath = Path();
    rightHandPath.moveTo(size.width * 0.85, size.height * 0.6);
    rightHandPath.lineTo(size.width * 0.75, size.height * 0.45);
    rightHandPath.lineTo(size.width * 0.65, size.height * 0.5);
    rightHandPath.lineTo(size.width * 0.75, size.height * 0.65);
    rightHandPath.close();

    canvas.drawPath(rightHandPath, darkHandPaint);

    // Middle orange/tan hand
    final orangeHandPaint =
        Paint()
          ..color = const Color(0xFFE8A87C) // Orange/tan skin tone
          ..style = PaintingStyle.fill;

    final middleHandPath = Path();
    middleHandPath.moveTo(size.width * 0.45, size.height * 0.75);
    middleHandPath.lineTo(size.width * 0.55, size.height * 0.75);
    middleHandPath.lineTo(size.width * 0.6, size.height * 0.6);
    middleHandPath.lineTo(size.width * 0.4, size.height * 0.6);
    middleHandPath.close();

    canvas.drawPath(middleHandPath, orangeHandPaint);

    // Hand details (strokes)
    final detailPaint =
        Paint()
          ..color = Colors.white.withOpacity(0.7)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    // Fingers on left hand
    for (int i = 0; i < 3; i++) {
      canvas.drawLine(
        Offset(size.width * (0.18 + 0.04 * i), size.height * (0.55 - 0.03 * i)),
        Offset(size.width * (0.22 + 0.04 * i), size.height * (0.48 - 0.03 * i)),
        detailPaint,
      );
    }

    // Fingers on right hand
    for (int i = 0; i < 3; i++) {
      canvas.drawLine(
        Offset(size.width * (0.82 - 0.04 * i), size.height * (0.55 - 0.03 * i)),
        Offset(size.width * (0.78 - 0.04 * i), size.height * (0.48 - 0.03 * i)),
        detailPaint,
      );
    }

    // Bracelet on dark hand
    final braceletPaint =
        Paint()
          ..color = const Color(0xFFE8945B) // Orange
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    canvas.drawCircle(
      Offset(size.width * 0.75, size.height * 0.58),
      size.width * 0.05,
      braceletPaint,
    );

    // Pearls/beads on dark hand
    final beadPaint =
        Paint()
          ..color = Colors.white
          ..style = PaintingStyle.fill;

    for (int i = 0; i < 5; i++) {
      double angle = i * (3.14159 / 2.5) + 3.14159 / 2;
      canvas.drawCircle(
        Offset(
          size.width * 0.75 + size.width * 0.05 * cos(angle),
          size.height * 0.58 + size.width * 0.05 * sin(angle),
        ),
        3,
        beadPaint,
      );
    }

    // Buttons on light hand sleeve
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.68),
      3,
      Paint()..color = const Color(0xFF533D2D),
    );
    canvas.drawCircle(
      Offset(size.width * 0.15, size.height * 0.73),
      3,
      Paint()..color = const Color(0xFF533D2D),
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
