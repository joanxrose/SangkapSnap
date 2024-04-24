import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_app/components/customButton.dart';
import 'package:main_app/themes/colorConstants.dart';

class CameraPage extends StatelessWidget {
  const CameraPage({super.key, this.selectedImage, this.isGallery});

  final File? selectedImage;
  final bool? isGallery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainWhite,
          title: isGallery!
              ? const Text(
                  "Selected image",
                  style: TextStyle(
                      color: AppColors.mainGreen,
                      fontWeight: FontWeight.w800,
                      fontSize: 20),
                )
              : const Text("Captured image",
                  style: TextStyle(
                      color: AppColors.mainGreen,
                      fontWeight: FontWeight.w800,
                      fontSize: 20)),
        ),
        body: Column(
          children: [
            // If an image is selected, display that image
            // Otherwise, show "No image is selected"
            Center(
                child: selectedImage != null
                    ? Padding(
                        padding: const EdgeInsets.only(top: 20, bottom: 30),
                        child: Image.file(
                          selectedImage!,
                          fit: BoxFit.contain,
                          height: 400,
                          width: 400,
                        ),
                      )
                    : const Padding(
                        padding: EdgeInsets.only(top: 100, bottom: 40),
                        child: Column(
                          children: [
                            Icon(
                              Icons.image_not_supported_rounded,
                              color: AppColors.mainGreen,
                              size: 50,
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            Text(
                              "No image selected.",
                              style: TextStyle(fontSize: 18),
                            )
                          ],
                        ),
                      )),

            // Only Go Back button will be visible when no image is selected
            (selectedImage != null)
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: CustomButton(
                      onPressed: () {},
                      text: "Detect ingredients",
                      backgroundColor: AppColors.mainGreen,
                      textColor: AppColors.mainWhite,
                    ),
                  )
                : const SizedBox(
                    height: 5,
                  ),
            const SizedBox(
              height: 15,
            ),
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: CustomButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  text: "Go back",
                  backgroundColor: AppColors.mainWhite,
                )),
          ],
        ));
  }
}
