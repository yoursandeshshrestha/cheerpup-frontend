import 'package:flutter/material.dart';

class ProfilePasswordField extends StatefulWidget {
  final String label;
  final TextEditingController controller;

  const ProfilePasswordField({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  State<ProfilePasswordField> createState() => _ProfilePasswordFieldState();
}

class _ProfilePasswordFieldState extends State<ProfilePasswordField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
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
          child: TextField(
            controller: widget.controller,
            obscureText: _obscureText,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.symmetric(vertical: 15),
              border: InputBorder.none,
              prefixIcon: const Icon(
                Icons.lock_outline,
                color: Colors.grey,
                size: 22,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: Colors.grey,
                  size: 22,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              ),
              hintText: widget.label,
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
            ),
          ),
        ),
      ],
    );
  }
}
