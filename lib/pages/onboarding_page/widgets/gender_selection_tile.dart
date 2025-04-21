// File: lib/pages/widgets/gender_selection_tile.dart

import 'package:flutter/material.dart';

class GenderSelectionTile extends StatelessWidget {
  final String? selectedGender;
  final Function(String?) onGenderSelected;
  final VoidCallback onSkip;

  const GenderSelectionTile({
    super.key,
    required this.selectedGender,
    required this.onGenderSelected,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
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
              onGenderSelected('prefer_not_to_say');
              onSkip();
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
    bool isSelected = selectedGender == value;
    
    return InkWell(
      onTap: () {
        onGenderSelected(value);
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
}