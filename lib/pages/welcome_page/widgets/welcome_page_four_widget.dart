import 'package:flutter/material.dart';

class WelcomeScreenFour extends StatelessWidget {
  const WelcomeScreenFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFCCCBC9), // Gray background color
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
                    'Step Three',
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
                  // Background wave shape
                  Positioned(
                    top: 0,
                    right: 0,
                    child: CustomPaint(
                      size: const Size(250, 180),
                      painter: WavePainter(),
                    ),
                  ),

                  // Stars/sparkles
                  Positioned(top: 80, left: 60, child: _buildStar(20)),
                  Positioned(top: 140, left: 120, child: _buildStar(15)),

                  // Main illustration - person writing in journal
                  Positioned(
                    top: 100,
                    right: 0,
                    bottom: 0,
                    left: 0,
                    child: CustomPaint(painter: JournalingPersonPainter()),
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
                  const Text(
                    'AI Mental Journaling & AI Therapy Chatbot',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF533D2D),
                      height: 1.2,
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

  // Helper method to build star shape
  Widget _buildStar(double size) {
    return CustomPaint(size: Size(size, size), painter: StarPainter());
  }
}

// Painter for wave shape in background
class WavePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.3)
          ..style = PaintingStyle.fill;

    final path =
        Path()
          ..moveTo(0, 0)
          ..lineTo(size.width, 0)
          ..lineTo(size.width, size.height)
          ..quadraticBezierTo(
            size.width * 0.5,
            size.height * 0.7,
            0,
            size.height * 0.8,
          )
          ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Painter for star/sparkle shape
class StarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = Colors.white.withOpacity(0.7)
          ..style = PaintingStyle.fill;

    final path = Path();

    // Simple four-point star
    path.moveTo(size.width / 2, 0);
    path.lineTo(size.width * 0.4, size.height * 0.4);
    path.lineTo(0, size.height / 2);
    path.lineTo(size.width * 0.4, size.height * 0.6);
    path.lineTo(size.width / 2, size.height);
    path.lineTo(size.width * 0.6, size.height * 0.6);
    path.lineTo(size.width, size.height / 2);
    path.lineTo(size.width * 0.6, size.height * 0.4);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Painter for the person journaling illustration
class JournalingPersonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paintDark =
        Paint()
          ..color = const Color(0xFF533D2D)
          ..style = PaintingStyle.fill;

    final paintMedium =
        Paint()
          ..color = const Color(0xFF8B8B8B)
          ..style = PaintingStyle.fill;

    final paintLight =
        Paint()
          ..color = const Color(0xFFBBBBBB)
          ..style = PaintingStyle.fill;

    final strokePaint =
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = 2;

    // Draw hair/head
    final headPath = Path();
    headPath.moveTo(size.width * 0.6, size.height * 0.2);
    headPath.quadraticBezierTo(
      size.width * 0.9,
      size.height * 0.15,
      size.width * 0.85,
      size.height * 0.4,
    );
    headPath.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.5,
      size.width * 0.7,
      size.height * 0.45,
    );
    headPath.close();
    canvas.drawPath(headPath, paintDark);

    // Draw face
    final facePath = Path();
    facePath.moveTo(size.width * 0.6, size.height * 0.3);
    facePath.lineTo(size.width * 0.4, size.height * 0.5);
    facePath.lineTo(size.width * 0.5, size.height * 0.6);
    facePath.quadraticBezierTo(
      size.width * 0.65,
      size.height * 0.55,
      size.width * 0.7,
      size.height * 0.45,
    );
    facePath.close();
    canvas.drawPath(facePath, paintLight);

    // Draw eye (closed)
    canvas.drawLine(
      Offset(size.width * 0.5, size.height * 0.4),
      Offset(size.width * 0.55, size.height * 0.42),
      strokePaint,
    );

    // Draw smile
    final smilePath = Path();
    smilePath.moveTo(size.width * 0.48, size.height * 0.45);
    smilePath.quadraticBezierTo(
      size.width * 0.53,
      size.height * 0.48,
      size.width * 0.56,
      size.height * 0.45,
    );
    canvas.drawPath(smilePath, strokePaint);

    // Draw arm
    final armPath = Path();
    armPath.moveTo(size.width * 0.4, size.height * 0.5);
    armPath.lineTo(size.width * 0.2, size.height * 0.7);
    armPath.lineTo(size.width * 0.3, size.height * 0.8);
    armPath.lineTo(size.width * 0.5, size.height * 0.6);
    armPath.close();
    canvas.drawPath(armPath, paintLight);

    // Draw hand
    final handPath = Path();
    handPath.moveTo(size.width * 0.2, size.height * 0.7);
    handPath.lineTo(size.width * 0.1, size.height * 0.65);
    handPath.lineTo(size.width * 0.05, size.height * 0.7);
    handPath.lineTo(size.width * 0.2, size.height * 0.8);
    handPath.lineTo(size.width * 0.3, size.height * 0.8);
    handPath.close();
    canvas.drawPath(handPath, paintLight);

    // Draw fingers (lines)
    for (int i = 0; i < 4; i++) {
      canvas.drawLine(
        Offset(size.width * (0.1 + 0.03 * i), size.height * (0.65 + 0.02 * i)),
        Offset(size.width * (0.05 + 0.03 * i), size.height * (0.7 + 0.02 * i)),
        strokePaint,
      );
    }

    // Draw notebook
    final notebookPath = Path();
    notebookPath.moveTo(size.width * 0.1, size.height * 0.6);
    notebookPath.lineTo(size.width * 0.4, size.height * 0.5);
    notebookPath.lineTo(size.width * 0.4, size.height * 0.7);
    notebookPath.lineTo(size.width * 0.1, size.height * 0.8);
    notebookPath.close();
    canvas.drawPath(notebookPath, Paint()..color = Colors.white);
    canvas.drawPath(
      notebookPath,
      Paint()
        ..color = Colors.black
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1,
    );

    // Draw notebook lines
    for (int i = 0; i < 5; i++) {
      canvas.drawLine(
        Offset(size.width * 0.12, size.height * (0.63 + 0.03 * i)),
        Offset(size.width * 0.38, size.height * (0.53 + 0.03 * i)),
        Paint()
          ..color = Colors.grey
          ..strokeWidth = 1,
      );
    }

    // Draw pen
    final penPath = Path();
    penPath.moveTo(size.width * 0.3, size.height * 0.6);
    penPath.lineTo(size.width * 0.2, size.height * 0.7);
    penPath.lineTo(size.width * 0.22, size.height * 0.72);
    penPath.lineTo(size.width * 0.32, size.height * 0.62);
    penPath.close();
    canvas.drawPath(penPath, paintDark);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
