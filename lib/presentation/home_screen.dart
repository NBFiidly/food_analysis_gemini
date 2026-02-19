import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_analysis_gemini/presentation/loading_screen.dart';
import 'package:food_analysis_gemini/presentation/result_screen.dart';
import 'package:food_analysis_gemini/services/gemini_services.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  XFile? imageFile;
  final GeminiServices _geminiServices = GeminiServices();

  Future<void> _pickImage(ImageSource source) async {
    final PickedFile = await ImagePicker().pickImage(source: source);
    if (PickedFile != null) {
      setState(() {
        imageFile = PickedFile;
      });
    }
  }

  void _showPickerOptions() {
    showModalBottomSheet(
      context: context,
      builder: (_) =>
          SafeArea(
            child: Wrap(
              children: [
                ListTile(
                  leading: Icon(Icons.camera_alt_rounded),
                  title: Text("Kamera"),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.camera);
                  },
                ),
                ListTile(
                  leading: Icon(Icons.photo_library_rounded),
                  title: Text('Galeri'),
                  onTap: () {
                    Navigator.pop(context);
                    _pickImage(ImageSource.gallery);
                  },
                ),
              ],
            ),
          ),
    );
  }

  Future<void> _analysisImage() async {
    if (imageFile == null) {
      return showDialog(
          context: context,
          builder: (_) =>
              AlertDialog(
                title: Text('Gambar belum ada!'),
                content: Text(
                    'Tambahkan gambar terlebih dahulu sebelum melakukan analisis.'),
              )
      );
    }

    Navigator.push(context, MaterialPageRoute(builder: (_) => LoadingScreen()));

    try {
      final data = await _geminiServices.analyzeImage(File(imageFile!.path));
      if (!mounted) return;

      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (_) => ResultScreen(data: data, imageFile: File(imageFile!.path),),)
      );
    } catch (e) {
      if (mounted) Navigator.pop(context);
      return showDialog(context: context,
        builder: (_) =>
            AlertDialog(title: Text('Gagal melakukan analisis!'),
              content: Text(e.toString()),)
      );
    }
  }

  void _deleteImage() {
    setState(() {
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 20,
          children: [_instructionText(), _imageArea(), _uploadButton()],
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.blueAccent[700],
      title: Text(
        'Food Nutrition \nComposition Analysis',
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),
      centerTitle: true,
    );
  }

  Widget _instructionText() {
    return Text(
      "Unggah gambar makanan atau minuman\nyang ingin kamu ketahui komposisi nutrisinya\ndan kehalalannya.",
      textAlign: TextAlign.center,
    );
  }

  Widget _imageArea() {
    return Container(
      width: 300,
      height: 200,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.blueAccent.shade400,
          width: 2,
          style: BorderStyle.solid,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (imageFile != null)
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.file(
                    File(imageFile!.path),
                    width: 300,
                    height: 175,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: _deleteImage,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(4),
                      child: Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                  ),
                )
              ],
            )
          else
            GestureDetector(
              onTap: _showPickerOptions,
              child: Icon(
                Icons.camera_alt_rounded,
                size: 100,
                color: Colors.blueAccent[700],
              ),
            ),
        ],
      ),
    );
  }

  Widget _uploadButton() {
    return ElevatedButton(
      onPressed: _analysisImage,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueAccent[700],
          fixedSize: Size(250, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          )
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Text("Analisis Gambar",
            style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold
            ),
          ),
          Icon(Icons.rocket_launch_rounded, color: Colors.white,)
        ],
      ),
    );
  }
}