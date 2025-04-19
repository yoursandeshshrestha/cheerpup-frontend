import 'package:flutter/material.dart';

class WelcomeScreenFive extends StatelessWidget {
  const WelcomeScreenFive({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5E8CB), // Light beige/cream background
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
                    'Step Four',
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
                  // Background wavy shapes
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: CustomPaint(
                      size: const Size(double.infinity, 200),
                      painter: TopWavePainter(),
                    ),
                  ),

                  // Blue wave lines
                  Positioned(
                    top: 150,
                    left: 0,
                    right: 0,
                    child: CustomPaint(
                      size: const Size(double.infinity, 300),
                      painter: WaveLinesPainter(),
                    ),
                  ),

                  // Main character illustration
                  Positioned(
                    top: 120,
                    left: 0,
                    right: 0,
                    child: CustomPaint(
                      size: const Size(double.infinity, 400),
                      painter: HappyPersonPainter(),
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
                    child: Row(
                      children: [
                        Container(
                          width: 180,
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
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(
                          text: 'Mindful ',
                          style: TextStyle(
                            color: Color(0xFF533D2D), // Dark brown
                          ),
                        ),
                        TextSpan(
                          text: 'Resources ',
                          style: TextStyle(
                            color: Color(0xFFE8C963), // Gold/yellow
                          ),
                        ),
                        TextSpan(
                          text: 'That\nMakes You Happy',
                          style: TextStyle(
                            color: Color(0xFF533D2D), // Dark brown
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

// Painter for top wave background
class TopWavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFFEAD4A7).withOpacity(
            0.7,
          ) // Lighter cream color
          ..style = PaintingStyle.fill;

    final path =
        Path()
          ..moveTo(0, 0)
          ..lineTo(size.width, 0)
          ..lineTo(size.width, size.height * 0.7)
          ..quadraticBezierTo(
            size.width * 0.7,
            size.height * 0.6,
            size.width * 0.5,
            size.height * 0.8,
          )
          ..quadraticBezierTo(
            size.width * 0.3,
            size.height,
            0,
            size.height * 0.9,
          )
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Painter for blue wave lines
class WaveLinesPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = const Color(0xFF4A90E2) // Blue
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    // First wave line
    final path1 =
        Path()
          ..moveTo(0, size.height * 0.2)
          ..quadraticBezierTo(
            size.width * 0.3,
            size.height * 0.1,
            size.width * 0.5,
            size.height * 0.2,
          )
          ..quadraticBezierTo(
            size.width * 0.7,
            size.height * 0.3,
            size.width,
            size.height * 0.2,
          );

    // Second wave line
    final path2 =
        Path()
          ..moveTo(0, size.height * 0.5)
          ..quadraticBezierTo(
            size.width * 0.3,
            size.height * 0.4,
            size.width * 0.5,
            size.height * 0.5,
          )
          ..quadraticBezierTo(
            size.width * 0.7,
            size.height * 0.6,
            size.width,
            size.height * 0.5,
          );

    canvas.drawPath(path1, paint);
    canvas.drawPath(path2, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Painter for happy person
class HappyPersonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Hair
    final hairPaint =
        Paint()
          ..color = const Color(0xFF533D2D) // Dark brown
          ..style = PaintingStyle.fill;

    final hairPath =
        Path()
          ..moveTo(size.width * 0.55, size.height * 0.15)
          ..quadraticBezierTo(
            size.width * 0.7,
            size.height * 0.1,
            size.width * 0.8,
            size.height * 0.3,
          )
          ..lineTo(size.width * 0.65, size.height * 0.4)
          ..quadraticBezierTo(
            size.width * 0.6,
            size.height * 0.35,
            size.width * 0.5,
            size.height * 0.3,
          )
          ..close();

    canvas.drawPath(hairPath, hairPaint);

    // Face
    final facePaint =
        Paint()
          ..color = const Color(0xFFE8A87C) // Light orange/skin tone
          ..style = PaintingStyle.fill;

    final facePath =
        Path()
          ..moveTo(size.width * 0.45, size.height * 0.25)
          ..quadraticBezierTo(
            size.width * 0.5,
            size.height * 0.2,
            size.width * 0.55,
            size.height * 0.25,
          )
          ..lineTo(size.width * 0.5, size.height * 0.4)
          ..lineTo(size.width * 0.35, size.height * 0.35)
          ..close();

    canvas.drawPath(facePath, facePaint);

    // Shirt/body
    final shirtPaint =
        Paint()
          ..color = const Color(0xFFE8C963) // Yellow
          ..style = PaintingStyle.fill;

    final shirtPath =
        Path()
          ..moveTo(size.width * 0.35, size.height * 0.35)
          ..lineTo(size.width * 0.5, size.height * 0.4)
          ..lineTo(size.width * 0.65, size.height * 0.4)
          ..lineTo(size.width * 0.7, size.height * 0.7)
          ..quadraticBezierTo(
            size.width * 0.5,
            size.height * 0.8,
            size.width * 0.3,
            size.height * 0.7,
          )
          ..close();

    canvas.drawPath(shirtPath, shirtPaint);

    // Arm outline
    final strokePaint =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1;

    final leftArmPath =
        Path()
          ..moveTo(size.width * 0.35, size.height * 0.4)
          ..quadraticBezierTo(
            size.width * 0.2,
            size.height * 0.45,
            size.width * 0.15,
            size.height * 0.5,
          );

    final rightArmPath =
        Path()
          ..moveTo(size.width * 0.65, size.height * 0.4)
          ..quadraticBezierTo(
            size.width * 0.8,
            size.height * 0.45,
            size.width * 0.85,
            size.height * 0.5,
          );

    canvas.drawPath(leftArmPath, strokePaint);
    canvas.drawPath(rightArmPath, strokePaint);

    // Smiling face
    // Eyes
    canvas.drawLine(
      Offset(size.width * 0.40, size.height * 0.28),
      Offset(size.width * 0.42, size.height * 0.28),
      strokePaint,
    );

    canvas.drawLine(
      Offset(size.width * 0.47, size.height * 0.28),
      Offset(size.width * 0.49, size.height * 0.28),
      strokePaint,
    );

    // Smile
    final smilePath =
        Path()
          ..moveTo(size.width * 0.40, size.height * 0.33)
          ..quadraticBezierTo(
            size.width * 0.45,
            size.height * 0.36,
            size.width * 0.50,
            size.height * 0.33,
          );

    canvas.drawPath(smilePath, strokePaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
