import 'package:flutter/material.dart';

class ProfileDropdownField extends StatelessWidget {
  final String label;
  final String value;
  final IconData icon;
  final Function(String?) onChanged;
  final List<String> items;

  const ProfileDropdownField({
    super.key,
    required this.label,
    required this.value,
    required this.icon,
    required this.onChanged,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade300, width: 1),
          ),
          child: DropdownButtonHideUnderline(
            child: ButtonTheme(
              alignedDropdown: true,
              child: DropdownButton<String>(
                value: value,
                isExpanded: true,
                icon: Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 8, 0),
                  child: const Icon(Icons.keyboard_arrow_down),
                ),
                style: const TextStyle(color: Colors.black87, fontSize: 14),
                dropdownColor: Colors.white,
                borderRadius: BorderRadius.circular(12),
                onChanged: onChanged,
                items:
                    items.map<DropdownMenuItem<String>>((String item) {
                      return DropdownMenuItem<String>(
                        value: item,
                        child: Row(
                          children: [
                            Text(item, style: const TextStyle(fontSize: 14)),
                          ],
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
