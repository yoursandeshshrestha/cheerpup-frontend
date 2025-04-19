import 'package:flutter/material.dart';

class WelcomeScreenOne extends StatelessWidget {
  const WelcomeScreenOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const Spacer(flex: 2),
              // Logo at the top
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: const Color(0xFF533D2D),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    width: 40,
                    height: 40,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Welcome text
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF533D2D),
                  ),
                  children: [
                    TextSpan(text: 'Welcome to the ultimate '),
                    TextSpan(
                      text: 'freud',
                      style: TextStyle(color: Color(0xFF8B6F54)),
                    ),
                    TextSpan(text: ' UI Kit!'),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Subtitle text
              const Text(
                'Your mindful mental health AI companion for everyone, anywhere 🍃',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Color(0xFF777777)),
              ),
              const Spacer(flex: 1),
              // Character illustration
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/character.png',
                    width: 300,
                    height: 300,
                  ),
                  // Positioning the icons around the character
                  Positioned(
                    top: 0,
                    right: 30,
                    child: _buildFeatureIcon(
                      Icons.lightbulb,
                      const Color(0xFFF39C50),
                    ),
                  ),
                  Positioned(
                    top: 60,
                    left: 0,
                    child: _buildFeatureIcon(
                      Icons.show_chart,
                      const Color(0xFFF39C50),
                    ),
                  ),
                  Positioned(
                    bottom: 40,
                    right: 20,
                    child: _buildFeatureIcon(
                      Icons.calendar_today,
                      const Color(0xFFF39C50),
                    ),
                  ),
                  Positioned(
                    bottom: 90,
                    left: 10,
                    child: Container(
                      width: 30,
                      height: 30,
                      decoration: const BoxDecoration(
                        color: Color(0xFFD9D2F0),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 1),
              // Get Started button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () {
                    // Add your navigation logic here
                    print('Get Started button pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF533D2D),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 8),
                      Icon(Icons.arrow_forward, size: 20),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              // Already have an account text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already have an account? ',
                    style: TextStyle(color: Color(0xFF666666), fontSize: 16),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Add your sign in navigation logic here
                      print('Sign In text pressed');
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Color(0xFFF39C50),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              // Home indicator
              Container(
                width: 120,
                height: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFF533D2D),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureIcon(IconData icon, Color backgroundColor) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Icon(icon, color: Colors.white, size: 24),
    );
  }
}
