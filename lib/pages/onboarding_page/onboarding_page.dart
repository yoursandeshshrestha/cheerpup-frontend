import 'package:cheerpup/pages/onboarding_page/riverpod/onboarding_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final int _totalPages = 5;
  
  // User data
  File? _profileImage;
  int? _age = 18;
  String? _gender;
  bool? _isPhysicalHelpBefore;
  bool _isPhysicalDistress = false;
  List<String> _selectedMedicines = [];
  final List<String> _availableMedicines = [
    'Abilify', 'Abilify Maintena', 'Abiraterone', 'Acetaminophen', 'Axpelliamus',
    'Aspirin', 'Ibuprofen', 'Lisinopril', 'Metformin', 'Simvastatin'
  ];

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    
    if (image != null) {
      setState(() {
        _profileImage = File(image.path);
      });
    }
  }

  bool _canContinue() {
    // All steps are skippable, so we can always continue
    return true;
  }

  void _nextPage() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      // Submit the data
      _submitData();
    }
  }

  void _submitData() {
    // Call the Riverpod provider to submit data to the API
    ref.read(onboardingProvider.notifier).completeOnboarding(
      profileImage: _profileImage,
      age: _age,
      gender: _gender,
      isPhysicalHelpBefore: _isPhysicalHelpBefore,
      isPhysicalDistress: _isPhysicalDistress,
      medicines: _selectedMedicines,
    );
  }
  
  @override
  Widget build(BuildContext context) {
    final onboardingState = ref.watch(onboardingProvider);

    // If onboarding was completed successfully, navigate to home
    if (onboardingState.isCompleted && !onboardingState.isLoading) {
      // Use addPostFrameCallback to avoid build-during-build errors
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.goNamed("home");
      });
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.black54),
                    onPressed: _currentPage > 0 
                      ? () => _pageController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOut,
                        )
                      : null,
                  ),
                  const Spacer(),
                  Text(
                    'Assessment',
                    style: TextStyle(
                      color: Colors.brown[800],
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${_currentPage + 1} of $_totalPages',
                    style: TextStyle(
                      color: Colors.brown[300],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            
            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _buildProfileImagePage(),
                  _buildAgePage(),
                  _buildGenderPage(),
                  _buildMedicationsPage(),
                  _buildPhysicalDistressPage(),
                ],
              ),
            ),
            
            // Skip option
            if (_currentPage < _totalPages - 1)
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: TextButton(
                  onPressed: _nextPage,
                  child: Text(
                    'Skip this step',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            
            // Error message
            if (onboardingState.error != null)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  onboardingState.error!,
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                  textAlign: TextAlign.center,
                ),
              ),
              
            // Continue button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _canContinue() ? _nextPage : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.brown[700],
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.brown[300],
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    _currentPage < _totalPages - 1 ? 'Continue' : 'Submit',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImagePage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Choose your profile picture',
            style: TextStyle(
              color: Colors.brown[900],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          GestureDetector(
            onTap: _pickImage,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey[200],
                image: _profileImage != null
                    ? DecorationImage(
                        image: FileImage(_profileImage!),
                        fit: BoxFit.cover,
                      )
                    : null,
              ),
              child: _profileImage == null
                  ? Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.grey[600],
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Tap to select an image',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Optional: You can skip this step',
                  style: TextStyle(
                    color: Colors.grey[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.arrow_forward, color: Colors.grey[700], size: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgePage() {
    List<int> ages = List.generate(12, (index) => 14 + index);
    
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text(
            "What's your age?",
            style: TextStyle(
              color: Colors.brown[900],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 200,
                    child: ListWheelScrollView(
                      itemExtent: 60,
                      diameterRatio: 1.5,
                      onSelectedItemChanged: (index) {
                        setState(() {
                          _age = ages[index];
                        });
                      },
                      children: ages.map((age) {
                        bool isSelected = _age == age;
                        return Container(
                          decoration: BoxDecoration(
                            color: isSelected ? Colors.green[400] : Colors.transparent,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          width: double.infinity,
                          child: Center(
                            child: Text(
                              age.toString(),
                              style: TextStyle(
                                color: isSelected ? Colors.white : Colors.grey,
                                fontSize: isSelected ? 24 : 20,
                                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  const SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      setState(() {
                        _age = null;
                      });
                      _nextPage();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            'Prefer not to say',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Icon(Icons.skip_next, color: Colors.grey[700], size: 16),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text(
            "What's your official gender?",
            style: TextStyle(
              color: Colors.brown[900],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 40),
          _buildGenderOption(
            label: 'I am Male',
            value: 'male',
            icon: Icons.male,
            color: Colors.green[300],
          ),
          const SizedBox(height: 16),
          _buildGenderOption(
            label: 'I am Female',
            value: 'female',
            icon: Icons.female,
            color: Colors.orange[300],
          ),
          const SizedBox(height: 16),
          InkWell(
            onTap: () {
              setState(() {
                _gender = 'prefer_not_to_say';
              });
              _nextPage();
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Prefer to skip, thanks',
                    style: TextStyle(
                      color: Colors.grey[800],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(Icons.close, color: Colors.grey[700], size: 16),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption({
    required String label,
    required String value,
    required IconData icon,
    required Color? color,
  }) {
    bool isSelected = _gender == value;
    
    return InkWell(
      onTap: () {
        setState(() {
          _gender = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? color ?? Colors.grey : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: (color ?? Colors.grey).withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Text(
              label,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
            ),
            const Spacer(),
            Icon(
              icon,
              color: isSelected ? color : Colors.grey[400],
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedicationsPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Please specify your medications!",
            style: TextStyle(
              color: Colors.brown[900],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Center(
            child: InkWell(
              onTap: () {
                // Skip medications
                setState(() {
                  _selectedMedicines = [];
                });
                _nextPage();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'No medications',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.close, color: Colors.grey[700], size: 16),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              for (final letter in ['A', 'B', 'C', 'X', 'Y', 'Z'])
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: CircleAvatar(
                    radius: 14,
                    backgroundColor: letter == 'A' ? Colors.orange[300] : Colors.grey[200],
                    child: Text(
                      letter,
                      style: TextStyle(
                        color: letter == 'A' ? Colors.white : Colors.grey[700],
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              const Spacer(),
              const Icon(Icons.search, color: Colors.grey),
            ],
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _availableMedicines.length,
              itemBuilder: (context, index) {
                final medicine = _availableMedicines[index];
                final isSelected = _selectedMedicines.contains(medicine);
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: isSelected ? Colors.green[100] : Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: isSelected ? Colors.green : Colors.grey[300]!,
                    ),
                  ),
                  child: ListTile(
                    title: Text(
                      medicine,
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                    trailing: Radio<bool>(
                      value: true,
                      groupValue: isSelected,
                      activeColor: Colors.green,
                      onChanged: (value) {
                        setState(() {
                          if (isSelected) {
                            _selectedMedicines.remove(medicine);
                          } else {
                            _selectedMedicines.add(medicine);
                          }
                        });
                      },
                    ),
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _selectedMedicines.remove(medicine);
                        } else {
                          _selectedMedicines.add(medicine);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),
          if (_selectedMedicines.isNotEmpty)
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Wrap(
                spacing: 8,
                children: _selectedMedicines.map((medicine) {
                  return Chip(
                    label: Text(medicine),
                    deleteIcon: const Icon(Icons.close, size: 18),
                    onDeleted: () {
                      setState(() {
                        _selectedMedicines.remove(medicine);
                      });
                    },
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildPhysicalDistressPage() {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Text(
            "Are you experiencing any physical distress?",
            style: TextStyle(
              color: Colors.brown[900],
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          Center(
            child: InkWell(
              onTap: () {
                // Skip this question
                setState(() {
                  _isPhysicalDistress = false;
                  _isPhysicalHelpBefore = false;
                });
                _nextPage();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Prefer not to answer',
                      style: TextStyle(
                        color: Colors.grey[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Icon(Icons.skip_next, color: Colors.grey[700], size: 16),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          _buildDistressOption(
            label: 'Yes, one or multiple',
            description: 'I\'m experiencing physical pain in different places over my body.',
            value: true,
            icon: Icons.check,
          ),
          const SizedBox(height: 16),
          _buildDistressOption(
            label: 'No Physical Pain At All',
            description: 'I\'m not experiencing any physical pain in my body at all.',
            value: false,
            icon: Icons.close,
          ),
          const SizedBox(height: 30),
          Divider(),
          const SizedBox(height: 10),
          Text(
            'Have you sought professional help before?',
            style: TextStyle(
              color: Colors.grey[800],
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isPhysicalHelpBefore = true;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isPhysicalHelpBefore == true ? Colors.green[400] : Colors.grey[300],
                  minimumSize: const Size(80, 40),
                ),
                child: const Text('Yes'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isPhysicalHelpBefore = false;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isPhysicalHelpBefore == false ? Colors.green[400] : Colors.grey[300],
                  minimumSize: const Size(80, 40),
                ),
                child: const Text('No'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isPhysicalHelpBefore = null;
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isPhysicalHelpBefore == null ? Colors.grey[400] : Colors.grey[300],
                  minimumSize: const Size(80, 40),
                ),
                child: const Text('Skip'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDistressOption({
    required String label,
    required String description,
    required bool value,
    required IconData icon,
  }) {
    final isSelected = _isPhysicalDistress == value;
    
    return InkWell(
      onTap: () {
        setState(() {
          _isPhysicalDistress = value;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? Colors.green[100] : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? Colors.green : Colors.grey[300]!,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.grey[200],
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
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