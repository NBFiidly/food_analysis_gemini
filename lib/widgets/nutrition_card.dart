import 'package:flutter/material.dart';

class NutritionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color backgroundColor;

  const NutritionCard({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    required this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(16),
      ),
      padding: EdgeInsets.all(12),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: Colors.red, size: 20),
          Text(
            label,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          Flexible(
            child: Text(
              value,
              style: TextStyle(fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
