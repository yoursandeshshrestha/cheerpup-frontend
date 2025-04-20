// File: lib/pages/widgets/age_selection_tile.dart

import 'package:flutter/material.dart';

class AgeSelectionTile extends StatelessWidget {
  final int? selectedAge;
  final Function(int?) onAgeSelected;
  final VoidCallback onSkip;

  const AgeSelectionTile({
    super.key,
    required this.selectedAge,
    required this.onAgeSelected,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
    List<int> ages = List.generate(50, (index) =>12  + index);
    
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
                        onAgeSelected(ages[index]);
                      },
                      children: ages.map((age) {
                        bool isSelected = selectedAge == age;
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
                      onAgeSelected(null);
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
}