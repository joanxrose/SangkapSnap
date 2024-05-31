import 'dart:io';

import 'package:flutter/material.dart';
import 'package:main_app/components/customButton.dart';
import 'package:main_app/screens/recommendedPage.dart';
import 'package:main_app/themes/colorConstants.dart';
import 'package:pytorch_lite/lib.dart';
import 'package:pytorch_lite/pytorch_lite.dart';

import 'dart:async';
import 'package:flutter/services.dart';

class CameraPage extends StatefulWidget {
  const CameraPage({super.key, this.selectedImage, this.isGallery});

  final File? selectedImage;
  final bool? isGallery;

  @override
  State<CameraPage> createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File? _image;

  ModelObjectDetection? _objectModel;
  List<ResultObjectDetection?> objDetect = [];

  // Keeps track of the app state (loading)
  bool _isLoading = false;

  // Check if the model has detected ingredients
  bool _hasDetected = false;

  // Store all the classNames of the detected objects
  List<String> detectedObjectsList = [];

  @override
  void initState() {
    super.initState();
    loadModel();
  }

  // Load model
  Future loadModel() async {
    String pathObjectDetectionModelYolov5 = "assets/models/best.torchscript";
    String labelPath = "assets/models/classes.txt";
    try {
      _objectModel = await PytorchLite.loadObjectDetectionModel(
          pathObjectDetectionModelYolov5, 11, 640, 640,
          labelPath: labelPath,
          objectDetectionModelType: ObjectDetectionModelType.yolov5);
    } catch (e) {
      print("Error $e");
    }
  }

  Future runObjectDetection() async {
    objDetect = await _objectModel!.getImagePrediction(
        await (widget.selectedImage!).readAsBytes(),
        minimumScore: 0.5,
        iOUThreshold: 0.3);

    for (var element in objDetect) {
      print({
        "score": element?.score,
        "className": element?.className,
        "class": element?.classIndex,
        "rect": {
          "left": element?.rect.left,
          "top": element?.rect.top,
          "width": element?.rect.width,
          "height": element?.rect.height,
          "right": element?.rect.right,
          "bottom": element?.rect.bottom,
        },
      });
    }

    setState(() {
      _image = widget.selectedImage;
      detectedObjectsList =
          objDetect.map((obj) => obj!.className.toString().trim()).toList();
      detectedObjectsList = detectedObjectsList.toSet().toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController ingredientController = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainWhite,
          title: widget.isGallery!
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              // If an image is selected, display that image
              // Otherwise, show "No image is selected"
              Center(
                  child: widget.selectedImage != null
                      ? Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 30),
                          child: Image.file(
                            widget.selectedImage!,
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

              // Display the list of detected ingredients / objects
              detectedObjectsList.isEmpty
                  ? const SizedBox(height: 5)
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 30, bottom: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Detected ingredients",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.mainGreen),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40, right: 20),
                          child: ListView.builder(
                              // scrollDirection: Axis.vertical,
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: detectedObjectsList.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  title: Text(detectedObjectsList[index]!),
                                  trailing: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.delete,
                                          color: AppColors.gray,
                                        ),
                                        onPressed: () {
                                          detectedObjectsList.remove(
                                              detectedObjectsList[index]);

                                          setState(() {
                                            detectedObjectsList =
                                                detectedObjectsList;
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),

                        // Add more ingredients
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 312,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 32, top: 20, bottom: 10),
                                child: TextFormField(
                                  controller: ingredientController,
                                  decoration: InputDecoration(
                                    hintText: "Add more ingredients",
                                    enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: AppColors.mainGreen,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: AppColors.mainGreen,
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    hintStyle:
                                        const TextStyle(color: AppColors.gray),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    detectedObjectsList
                                        .add(ingredientController.text.trim());
                                  });
                                },
                                icon: const Icon(
                                  Icons.add_circle,
                                  size: 36,
                                  color: AppColors.mainGreen,
                                ))
                          ],
                        )
                      ],
                    ),

              const SizedBox(
                height: 20,
              ),

              // Only Go Back button will be visible when no image is selected
              (widget.selectedImage != null)
                  ? Padding(
                      padding:
                          const EdgeInsets.only(left: 30, right: 30, top: 20),
                      child: _isLoading == false
                          ? _hasDetected
                              ? CustomButton(
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => RecommendedPage(
                                              detectedList:
                                                  detectedObjectsList)),
                                    );
                                  },
                                  text: "Recommend Recipes",
                                  backgroundColor: AppColors.mainGreen,
                                  textColor: AppColors.mainWhite,
                                )
                              : CustomButton(
                                  onPressed: () async {
                                    setState(() {
                                      _isLoading = true;
                                    });

                                    await runObjectDetection();

                                    setState(() {
                                      _isLoading = false;

                                      detectedObjectsList = objDetect
                                          .map((obj) =>
                                              obj!.className.toString().trim())
                                          .toList();

                                      // Remove duplicates to the list by converting the list into a set,
                                      // Then converting back to list
                                      detectedObjectsList =
                                          detectedObjectsList.toSet().toList();

                                      if (detectedObjectsList.isNotEmpty) {
                                        _hasDetected = true;
                                      }
                                    });
                                  },
                                  text: "Detect ingredients",
                                  backgroundColor: AppColors.mainGreen,
                                  textColor: AppColors.mainWhite,
                                )
                          : const Center(
                              child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      AppColors.mainGreen)),
                            ))
                  : const SizedBox(
                      height: 5,
                    ),
              const SizedBox(
                height: 15,
              ),

              Padding(
                  padding:
                      const EdgeInsets.only(left: 30, right: 30, bottom: 50),
                  child: CustomButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    text: "Go back",
                    backgroundColor: AppColors.mainWhite,
                  )),
            ],
          ),
        ));
  }
}
