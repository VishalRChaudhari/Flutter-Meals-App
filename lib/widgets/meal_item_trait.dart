import 'package:flutter/material.dart';

class MealItemTrait extends StatelessWidget {
  const MealItemTrait({super.key, required this.icon, required this.duration});

  final IconData icon;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 17, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          duration,
          style: const TextStyle(color: Colors.white),
        ),
      ],
    );
  }
}
