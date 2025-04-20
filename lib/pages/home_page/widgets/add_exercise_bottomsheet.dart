import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cheerpup/pages/home_page/riverpod/home_provider.dart';
import 'package:cheerpup/commons/services/exercise_service.dart';

class AddExerciseBottomSheet extends ConsumerStatefulWidget {
  final String initialExerciseName;

  const AddExerciseBottomSheet({Key? key, required this.initialExerciseName})
    : super(key: key);

  @override
  ConsumerState<AddExerciseBottomSheet> createState() =>
      _AddExerciseBottomSheetState();
}

class _AddExerciseBottomSheetState
    extends ConsumerState<AddExerciseBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  final TextEditingController _durationController = TextEditingController(
    text: '7',
  );
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();

    // Parse the exercise string - assuming format is "Title: Description"
    final parts = widget.initialExerciseName.split(': ');
    _nameController = TextEditingController(text: parts[0]);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  // Add exercise function
  Future<void> _addExercise() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      final exerciseName = _nameController.text;
      final duration = int.tryParse(_durationController.text) ?? 7;

      // Get user ID from current state
      final userId = ref.read(homePageProvider).currentUser?.id;

      if (userId != null) {
        // Create the exercise service
        final exerciseService = ExerciseService();

        // Call the API to add exercise
        final response = await exerciseService.addExercise(
          userId: userId,
          name: exerciseName,
          durationInDays: duration,
        );

        setState(() {
          _isLoading = false;
        });

        if (response['success'] == true) {
          // If successful, update the home state with the new exercise
          if (mounted) {
            // First close the bottom sheet
            Navigator.of(context).pop();

            // Then update the state
            final newExercise = response['data'];
            ref.read(homePageProvider.notifier).addExerciseToUser(newExercise);

            // Show success message
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Exercise added successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          }
        } else {
          // Show error message
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(response['message'] ?? 'Failed to add exercise'),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
      } else {
        setState(() {
          _isLoading = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User not found. Please log in again.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Bottom sheet header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add New Habit',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1565C0),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Exercise name field
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Exercise Name',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.fitness_center),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter an exercise name';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // Duration field
            TextFormField(
              controller: _durationController,
              decoration: const InputDecoration(
                labelText: 'Duration (days)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.calendar_today),
              ),
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter duration';
                }
                if (int.tryParse(value) == null || int.parse(value) <= 0) {
                  return 'Please enter a valid number of days';
                }
                return null;
              },
            ),
            const SizedBox(height: 24),

            // Add button
            ElevatedButton(
              onPressed: _isLoading ? null : _addExercise,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1565C0),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child:
                  _isLoading
                      ? const SizedBox(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                      : const Text(
                        'Add Habit',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
