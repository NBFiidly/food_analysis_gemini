import 'package:flutter/material.dart';
import 'package:food_analysis_gemini/widgets/nutrition_card.dart';

class NutritionCompositionGrid extends StatelessWidget {
  final Map<String, dynamic> data;

  const NutritionCompositionGrid({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 1.3,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        NutritionCard(
          icon: Icons.local_pizza_rounded,
          label: "Karbohidrat",
          value: data["karbohidrat"]?.toString() ?? "0g",
          backgroundColor: Colors.orange.shade100,
        ),
        NutritionCard(
          icon: Icons.egg_alt_rounded,
          label: "Protein",
          value: data["protein"]?.toString() ?? "0g",
          backgroundColor: Colors.green.shade100,
        ),
        NutritionCard(
          icon: Icons.bubble_chart_rounded,
          label: "Lemak",
          value: data["lemak"]?.toString() ?? "0g",
          backgroundColor: Colors.red.shade100,
        ),
        NutritionCard(
          icon: Icons.alt_route,
          label: "Serat",
          value: data["serat"]?.toString() ?? "0g",
          backgroundColor: Colors.blue.shade100,
        ),
        NutritionCard(
          icon: Icons.local_hospital_rounded,
          label: "Vitamin",
          value: data["vitamin"]?.toString() ?? "0g",
          backgroundColor: Colors.purple.shade100,
        ),
        NutritionCard(
          icon: Icons.heart_broken,
          label: "Kolesterol",
          value: data["kolesterol"]?.toString() ?? "0g",
          backgroundColor: Colors.yellow.shade100,
        ),
      ],
    );
  }
}
