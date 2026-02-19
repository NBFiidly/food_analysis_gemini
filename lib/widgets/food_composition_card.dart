import 'package:flutter/material.dart';

class FoodCompositionCard extends StatelessWidget {
  final List<String> foodComposition;

  const FoodCompositionCard(this.foodComposition, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orangeAccent[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Row(
            spacing: 4,
            children: [
              Icon(Icons.list_alt_rounded, color: Colors.red, size: 24),
              Text(
                "Komposisi Makanan",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
          SizedBox(height: 12),
          ...foodComposition.map((item) {
            return Padding(
              padding: EdgeInsetsGeometry.all(4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Icon(
                      Icons.radio_button_checked_rounded,
                      color: Colors.blueAccent[700],
                      size: 10,
                    ),
                  ),
                  Expanded(child: Text(item)),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}
