// File: lib/pages/onboarding_page.dart

import 'package:flutter/material.dart';
import 'dart:io';
import 'widgets/profile_image_tile.dart';
import 'widgets/age_selection_tile.dart';
import 'widgets/gender_selection_tile.dart';
import 'widgets/medications_page_tile.dart';
import 'widgets/physical_distress_tile.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
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
    'Aspirin', 'Ibuprofen', 'Lisinopril', 'Metformin', 'Simvastatin',
    'Amoxicillin', 'Atorvastatin', 'Levothyroxine', 'Omeprazole', 'Losartan',
    'Albuterol', 'Gabapentin', 'Hydrochlorothiazide', 'Sertraline', 'Fluoxetine'
  ];

  void _setProfileImage(File? image) {
    setState(() {
      _profileImage = image;
    });
  }

  void _setAge(int? age) {
    setState(() {
      _age = age;
    });
  }

  void _setGender(String? gender) {
    setState(() {
      _gender = gender;
    });
  }

  void _setPhysicalDistress(bool value) {
    setState(() {
      _isPhysicalDistress = value;
    });
  }

  void _setPhysicalHelpBefore(bool? value) {
    setState(() {
      _isPhysicalHelpBefore = value;
    });
  }

  void _addMedicine(String medicine) {
    setState(() {
      if (!_selectedMedicines.contains(medicine)) {
        _selectedMedicines.add(medicine);
      }
    });
  }

  void _removeMedicine(String medicine) {
    setState(() {
      _selectedMedicines.remove(medicine);
    });
  }

  void _clearMedicines() {
    setState(() {
      _selectedMedicines = [];
    });
  }

  void _addCustomMedicine(String medicine) {
    if (medicine.isNotEmpty && !_selectedMedicines.contains(medicine)) {
      setState(() {
        _selectedMedicines.add(medicine);
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
    // Create a map of the collected data
    final userData = {
      'profileImage': _profileImage?.path,
      'age': _age,
      'gender': _gender,
      'isPhysicalHelpBefore': _isPhysicalHelpBefore,
      'isPhysicalDistress': _isPhysicalDistress,
      'medicines': _selectedMedicines,
    };
    
    // Show all collected data, including skipped fields
    print('User data collected: $userData');
    
    // Show a success dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Onboarding Complete'),
        content: const Text('Your profile has been set up successfully!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Navigate to the next screen (replace with your navigation logic)
              // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: const Text('Continue'),
          ),
        ],
      ),
    );
  }
  
  @override
  Widget build(BuildContext context) {
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
                    'Onboarding',
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
                  ProfileImageTile(
                    profileImage: _profileImage,
                    onImageSelected: _setProfileImage,
                    onSkip: _nextPage,
                  ),
                  AgeSelectionTile(
                    selectedAge: _age,
                    onAgeSelected: _setAge,
                    onSkip: _nextPage,
                  ),
                  GenderSelectionTile(
                    selectedGender: _gender,
                    onGenderSelected: _setGender,
                    onSkip: _nextPage,
                  ),
                  MedicationsPageTile(
                    availableMedicines: _availableMedicines,
                    selectedMedicines: _selectedMedicines,
                    onMedicineAdded: _addMedicine,
                    onMedicineRemoved: _removeMedicine,
                    onClearMedicines: _clearMedicines,
                    onCustomMedicineAdded: _addCustomMedicine,
                    onSkip: _nextPage,
                  ),
                  PhysicalDistressTile(
                    isPhysicalDistress: _isPhysicalDistress,
                    isPhysicalHelpBefore: _isPhysicalHelpBefore,
                    onPhysicalDistressChanged: _setPhysicalDistress,
                    onPhysicalHelpBeforeChanged: _setPhysicalHelpBefore,
                    onSkip: _nextPage,
                  ),
                ],
              ),
            ),
            
            // Skip option - removed from main container since it's now in each individual tile
            /*
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
            */
            
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
}