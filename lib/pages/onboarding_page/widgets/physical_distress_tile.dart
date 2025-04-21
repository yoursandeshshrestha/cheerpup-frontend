// File: lib/pages/widgets/physical_distress_tile.dart

import 'package:flutter/material.dart';

class PhysicalDistressTile extends StatelessWidget {
  final bool isPhysicalDistress;
  final bool? isPhysicalHelpBefore;
  final Function(bool) onPhysicalDistressChanged;
  final Function(bool?) onPhysicalHelpBeforeChanged;
  final VoidCallback onSkip;

  const PhysicalDistressTile({
    super.key,
    required this.isPhysicalDistress,
    required this.isPhysicalHelpBefore,
    required this.onPhysicalDistressChanged,
    required this.onPhysicalHelpBeforeChanged,
    required this.onSkip,
  });

  @override
  Widget build(BuildContext context) {
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
                onPhysicalDistressChanged(false);
                onPhysicalHelpBeforeChanged(false);
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
          ),
          const SizedBox(height: 16),
          _buildDistressOption(
            label: 'No Physical Pain At All',
            description: 'I\'m not experiencing any physical pain in my body at all.',
            value: false,
          ),
          const SizedBox(height: 30),
          const Divider(),
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
                  onPhysicalHelpBeforeChanged(true);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPhysicalHelpBefore == true ? Colors.green[400] : Colors.grey[300],
                  minimumSize: const Size(80, 40),
                ),
                child: const Text('Yes'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  onPhysicalHelpBeforeChanged(false);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPhysicalHelpBefore == false ? Colors.green[400] : Colors.grey[300],
                  minimumSize: const Size(80, 40),
                ),
                child: const Text('No'),
              ),
              const SizedBox(width: 10),
              ElevatedButton(
                onPressed: () {
                  onPhysicalHelpBeforeChanged(null);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isPhysicalHelpBefore == null ? Colors.grey[400] : Colors.grey[300],
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
  }) {
    final isSelected = isPhysicalDistress == value;
    
    return InkWell(
      onTap: () {
        onPhysicalDistressChanged(value);
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
                value ? Icons.check : Icons.close,
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