import 'package:cheerpup/pages/layout/layout_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NavBar extends ConsumerWidget {
  final Function(int) onItemTapped;

  const NavBar({super.key, required this.onItemTapped});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedIndex = ref.watch(navigationIndexProvider);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(48),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 0,
          ),
        ],
      ),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      height: 70,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(context, 0, Icons.home, "Home", selectedIndex),
          _buildNavItem(
            context,
            1,
            Icons.chat_bubble_outline,
            "Messages",
            selectedIndex,
          ),
          _buildNavItem(context, 2, Icons.bar_chart, "Stats", selectedIndex),
          _buildNavItem(
            context,
            3,
            Icons.person_outline,
            "Profile",
            selectedIndex,
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(
    BuildContext context,
    int index,
    IconData icon,
    String label,
    int selectedIndex,
  ) {
    final isSelected = index == selectedIndex;
    final color = isSelected ? const Color(0xFF8DAF5D) : Colors.grey;

    return InkWell(
      onTap: () => onItemTapped(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
