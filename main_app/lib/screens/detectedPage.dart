import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_app/themes/colorConstants.dart';

class DetectedPage extends StatelessWidget {
  DetectedPage({super.key, this.selectedImage, required this.objDetect});

  final File? selectedImage;
  List<String?> objDetect = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainWhite,
          title: const Text(
            "Detected ingredients",
            style: TextStyle(
                color: AppColors.mainGreen,
                fontWeight: FontWeight.w800,
                fontSize: 20),
          ),
        ),
        body: ListView.builder(
            itemCount: objDetect.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                title: Text(objDetect[index]!),
              );
            }));
  }
}
