import 'package:flutter/material.dart';

/// A custom button widget for the profile page.
class ProfileWeightSlider extends StatelessWidget {
  final double value;
  final Function(double) onChanged;
  final double min;
  final double max;

  const ProfileWeightSlider({
    super.key,
    required this.value,
    required this.onChanged,
    this.min = 50,
    this.max = 100,
  });

  @override
  Widget build(BuildContext context) {
    final actualValue =
        value > max
            ? max
            : value < min
            ? min
            : value;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Weight",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Column(
          children: [
            SliderTheme(
              data: SliderTheme.of(context).copyWith(
                activeTrackColor: const Color(0xFF8DAF5D),
                inactiveTrackColor: Colors.grey.shade300,
                thumbColor: const Color(0xFF8DAF5D),
                overlayColor: const Color(0xFF8DAF5D).withOpacity(0.2),
                trackHeight: 6.0,
                thumbShape: const RoundSliderThumbShape(
                  enabledThumbRadius: 8.0,
                ),
                overlayShape: const RoundSliderOverlayShape(
                  overlayRadius: 16.0,
                ),
              ),
              child: Slider(
                value: actualValue,
                min: min,
                max: max,
                onChanged: onChanged,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${min.toInt()}kg",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                  Text(
                    "${actualValue.toInt()}kg",
                    style: const TextStyle(
                      color: Color(0xFF8DAF5D),
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "${max.toInt()}kg",
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
