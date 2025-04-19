import 'package:flutter/material.dart';

class WelcomeScreenThree extends StatelessWidget {
  const WelcomeScreenThree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4D4BB), // Peach background color
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
                    'Step Two',
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
                  // Background shapes (simplified)
                  Positioned(
                    top: 30,
                    right: 20,
                    child: Container(
                      width: 150,
                      height: 100,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    left: 10,
                    child: Container(
                      width: 120,
                      height: 80,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                  ),

                  // Character illustration with emotion icons
                  Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        // Main character
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Character's head and upper body
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                // Hair
                                Positioned(
                                  top: 0,
                                  left: 50,
                                  child: Container(
                                    width: 100,
                                    height: 100,
                                    decoration: const BoxDecoration(
                                      color: Color(
                                        0xFF533D2D,
                                      ), // Dark brown hair
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(50),
                                        topRight: Radius.circular(20),
                                        bottomLeft: Radius.circular(40),
                                        bottomRight: Radius.circular(50),
                                      ),
                                    ),
                                  ),
                                ),

                                // Face
                                Container(
                                  width: 80,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    color: Color(
                                      0xFFE8A87C,
                                    ), // Light orange face
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(40),
                                    ),
                                  ),
                                  child: Stack(
                                    children: [
                                      // Eyes (simplified)
                                      Positioned(
                                        top: 40,
                                        left: 20,
                                        child: Container(
                                          width: 5,
                                          height: 15,
                                          color: Colors.black,
                                        ),
                                      ),
                                      Positioned(
                                        top: 40,
                                        right: 20,
                                        child: Container(
                                          width: 5,
                                          height: 15,
                                          color: Colors.black,
                                        ),
                                      ),

                                      // Mouth (sad)
                                      Positioned(
                                        bottom: 30,
                                        left: 25,
                                        child: Container(
                                          width: 30,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide.none,
                                              bottom: BorderSide(
                                                color: Colors.black,
                                                width: 2,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Tears
                                      Positioned(
                                        top: 60,
                                        left: 15,
                                        child: Container(
                                          width: 10,
                                          height: 15,
                                          decoration: const BoxDecoration(
                                            color: Color(
                                              0xFFA3BCF9,
                                            ), // Light blue tear
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        top: 70,
                                        right: 15,
                                        child: Container(
                                          width: 10,
                                          height: 15,
                                          decoration: const BoxDecoration(
                                            color: Color(
                                              0xFFA3BCF9,
                                            ), // Light blue tear
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(5),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),

                            // Body/shirt
                            Container(
                              width: 200,
                              height: 150,
                              decoration: const BoxDecoration(
                                color: Color(0xFFE8945B), // Orange shirt
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(60),
                                  topRight: Radius.circular(60),
                                  bottomLeft: Radius.circular(100),
                                  bottomRight: Radius.circular(100),
                                ),
                              ),
                              child: Center(
                                child: Container(
                                  width: 80,
                                  height: 120,
                                  decoration: const BoxDecoration(
                                    color: Colors.white, // White undershirt
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(30),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        // Emotion icons
                        Positioned(
                          top: 40,
                          right: 50,
                          child: Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: const Color(0xFFB5B3E6), // Light purple
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '✗',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '✗',
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '◡',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 60,
                          left: 50,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8945B), // Orange
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                            ),
                            child: const Center(
                              child: Text(
                                '◡╭╮',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black54,
                                ),
                              ),
                            ),
                          ),
                        ),

                        Positioned(
                          bottom: 60,
                          right: 50,
                          child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                              color: const Color(0xFFBFAEA4), // Gray
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.blue.withOpacity(0.3),
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        '|',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 10),
                                      Text(
                                        '|',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '―',
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
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
                        height: 1.2,
                      ),
                      children: [
                        TextSpan(
                          text: 'Intelligent ',
                          style: TextStyle(
                            color: Color(0xFFE8945B), // Orange color
                          ),
                        ),
                        TextSpan(
                          text: 'Mood Tracking\n& AI Emotion Insights',
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
