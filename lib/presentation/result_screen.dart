import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_analysis_gemini/widgets/build_card.dart';
import 'package:food_analysis_gemini/widgets/food_composition_card.dart';
import 'package:food_analysis_gemini/widgets/nutrition_composition_grid.dart';

class ResultScreen extends StatelessWidget {
  final Map<String, dynamic> data;
  final File imageFile;

  const ResultScreen({super.key, required this.data, required this.imageFile});

  @override
  Widget build(BuildContext context) {
    final foodName = data['nama_makanan'];
    final halalStatus = data['kehalalan'];
    final nutritionComposition =
        data['komposisi_nutrisi'] as Map<String, dynamic>;
    final foodComposistion = data['komposisi_makanan']
        .toString()
        .split(",")
        .map((e) => e.trim())
        .toList();
    final additionalInfo = data['infromasi_tambahan'];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Hasil Analisis",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueAccent[700],
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(20),
        child: Column(
          spacing: 12,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.file(
                File(imageFile.path),
                width: double.infinity,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            BuildCard(
              icon: Icons.fastfood_rounded,
              title: "Nama Makanan",
              content: foodName,
              cardColor: Colors.lightBlueAccent,
            ),
            BuildCard(
              icon: Icons.verified_rounded,
              title: "Status kehalalan",
              content: halalStatus,
              cardColor: Colors.greenAccent,
            ),
            Text(
              "Komposisi Nutrisi :",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            NutritionCompositionGrid(data: nutritionComposition),
            FoodCompositionCard(foodComposistion),
            BuildCard(
              icon: Icons.info_rounded,
              title: "Informasi Tambahan",
              content: additionalInfo,
              cardColor: Colors.red.shade100,
            ),
          ],
        ),
      ),
    );
  }
}
