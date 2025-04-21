import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Color> _backgroundColors = [
    Colors.white,
    const Color(0xFFECEAD5),
    const Color(0xFFF4D4BB),
    const Color(0xFFCCCBC9),
    const Color(0xFFF5E8CB),
    const Color(0xFFD9D2F0),
  ];

  final List<String> _headings = [
    "Welcome to the ultimate freud UI Kit!",
    "Personalize Your Mental Health State \n With AI",
    "Intelligent Mood Tracking & AI Emotion \n Insights",
    "AI Mental Journaling & AI Therapy Chatbot",
    "Mindful Resources That Make You \n Happy",
    "Loving & Supportive Community",
  ];

  final List<String> _stepLabels = [
    "Welcome",
    "Step One",
    "Step Two",
    "Step Three",
    "Step Four",
    "Step Five",
  ];

  final List<String> _assetPaths = [
    "assets/svg/Screen1.svg",
    "assets/svg/Screen2.svg",
    "assets/svg/Screen3.svg",
    "assets/svg/Screen4.svg",
    "assets/svg/Screen5.svg",
    "assets/svg/Screen6.svg",
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _headings.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.push('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _currentPage == 0,
      onPopInvokedWithResult: (didPop, result) {
        if (_currentPage > 0) {
          _pageController.previousPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
          return;
        }
      },
      child: Scaffold(
        backgroundColor: _backgroundColors[_currentPage],
        body: SafeArea(
          child: Column(
            children: [
              // Top PageView content
              Expanded(
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: _assetPaths.length,
                  onPageChanged: (int page) {
                    setState(() => _currentPage = page);
                  },
                  itemBuilder: (context, index) {
                    return _buildTopContent(
                      _stepLabels[index],
                      _assetPaths[index],
                    );
                  },
                ),
              ),
              _buildBottomSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopContent(String? step, String assetPath) {
    return Column(
      children: [
        if (step != null)
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
                child: Text(
                  step,
                  style: const TextStyle(
                    color: Color(0xFF533D2D),
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        Expanded(
          child: Center(
            child: SvgPicture.asset(
              assetPath,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.contain,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSection() {
    double progressWidth = 250.0 * (_currentPage + 1) / _headings.length;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SizedBox(
        height: 300,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: Column(
            children: [
              // Progress bar
              Container(
                height: 10,
                width: 250,
                decoration: BoxDecoration(
                  color: const Color(0xFFECDAD5),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: progressWidth,
                    height: 10,
                    decoration: BoxDecoration(
                      color: const Color(0xFF8B6F54),
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 30),

              // Heading
              Text(
                _headings[_currentPage],
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF533D2D),
                  height: 1.3,
                ),
              ),

              const SizedBox(height: 30),

              // Next button
              InkWell(
                onTap: _onNext,
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
      ),
    );
  }
}
