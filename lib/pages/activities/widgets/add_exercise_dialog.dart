// lib/pages/activities/widgets/add_exercise_dialog.dart

import 'package:flutter/material.dart';

// This widget is a dialog that allows the user to add a new exercise to their
// list of activities. 
class AddExerciseDialog extends StatefulWidget {
  final Function(String name, int durationInDays) onAdd;

  const AddExerciseDialog({Key? key, required this.onAdd}) : super(key: key);

  @override
  State<AddExerciseDialog> createState() => _AddExerciseDialogState();
}

class _AddExerciseDialogState extends State<AddExerciseDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _durationController = TextEditingController(text: '30');

  int _selectedDuration = 30;

  // Predefined durations
  final List<int> _durations = [7, 14, 30, 60, 90];

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: _buildDialogContent(context),
    );
  }

  Widget _buildDialogContent(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10.0,
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Title
            const Text(
              'Add New Activity',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Activity name input
            TextFormField(
              controller: _nameController,
              decoration: InputDecoration(
                labelText: 'Activity Name',
                hintText: 'e.g., Morning Yoga, Running, Meditation',
                prefixIcon: const Icon(Icons.fitness_center),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.grey[50],
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter an activity name';
                }
                return null;
              },
            ),
            const SizedBox(height: 20),

            // Duration selector
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Duration Goal (days):',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 12),

                // Duration chips
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children:
                      _durations
                          .map((duration) => _buildDurationChip(duration))
                          .toList(),
                ),

                const SizedBox(height: 12),

                // Custom duration input
                TextFormField(
                  controller: _durationController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: 'Custom Duration',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.grey[50],
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a duration';
                    }
                    try {
                      final duration = int.parse(value);
                      if (duration <= 0) {
                        return 'Duration must be positive';
                      }
                    } catch (e) {
                      return 'Please enter a valid number';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    try {
                      setState(() {
                        _selectedDuration = int.parse(value);
                      });
                    } catch (_) {}
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Action buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.teal,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 12,
                    ),
                  ),
                  child: const Text('Add Activity'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDurationChip(int duration) {
    final isSelected = _selectedDuration == duration;

    return ChoiceChip(
      label: Text('$duration days'),
      selected: isSelected,
      backgroundColor: Colors.grey[100],
      selectedColor: Colors.teal[100],
      labelStyle: TextStyle(
        color: isSelected ? Colors.teal[700] : Colors.black87,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      onSelected: (selected) {
        if (selected) {
          setState(() {
            _selectedDuration = duration;
            _durationController.text = duration.toString();
          });
        }
      },
    );
  }
  // Submit the form and call the onAdd callback with the entered data
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text.trim();
      int duration;

      try {
        duration = int.parse(_durationController.text);
      } catch (_) {
        duration = 30; // Default if parsing fails
      }

      widget.onAdd(name, duration);
    }
  }
}
