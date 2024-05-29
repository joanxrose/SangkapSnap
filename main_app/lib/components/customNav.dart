import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:main_app/screens/detectIngredients.dart';
import 'package:main_app/screens/homePage.dart';
import 'package:main_app/screens/searchPage.dart';
import 'package:main_app/themes/colorConstants.dart';

class CustomNav extends StatefulWidget {
  const CustomNav({super.key});

  @override
  _CustomNavState createState() => _CustomNavState();
}

class _CustomNavState extends State<CustomNav> {
  // Page navigation
  int _pageIndex = 0;

  final List<Widget> _pages = [
    HomePage(),
    SearchPage(),
  ];

  // Image picker
  File? _image;

  // Choose an image either from the gallery, or take a photo using the phone's camera
  Future pickImage(type) async {
    try {
      final image = await ImagePicker().pickImage(
          source:
              (type == "gallery" ? ImageSource.gallery : ImageSource.camera));
      if (image == null) return;

      final imageTemp = File(image.path);
      setState(() {
        _image = imageTemp;
      });

      return _image;
    } on PlatformException catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: _pages[_pageIndex],
      floatingActionButton: SizedBox(
        width: 80,
        height: 80,
        child: FittedBox(
          child: FloatingActionButton.large(
            elevation: 0,
            backgroundColor: AppColors.mainGreen,
            shape: RoundedRectangleBorder(
                side: const BorderSide(width: 10, color: AppColors.mainWhite),
                borderRadius: BorderRadius.circular(100)),
            onPressed: () {
              // Modal when the camera FAB is clicked
              showModalBottomSheet(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: AppColors.mainWhite,
                      height: 160,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 20, left: 20, right: 20),
                        child: Center(
                            child: ListView(
                          children: [
                            // Choose image from the gallery
                            ListTile(
                              leading: const Icon(
                                Icons.collections,
                                color: AppColors.mainGreen,
                              ),
                              title: const Text('Choose image from Gallery'),
                              onTap: () async {
                                final selectedImage =
                                    await pickImage("gallery");

                                // Once the iamge is selected, pass it to the displayImagePage to display the image
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CameraPage(
                                            selectedImage: selectedImage,
                                            isGallery: true,
                                          )),
                                ).then((value) => Navigator.pop(context));
                              },
                            ),

                            // Take photo using the phone's camera
                            ListTile(
                              leading: const Icon(
                                Icons.camera_alt,
                                color: AppColors.mainGreen,
                              ),
                              title: const Text('Take photo'),
                              onTap: () async {
                                final selectedImage = await pickImage("camera");

                                // Once the iamge is selected, pass it to the displayImagePage to display the image
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CameraPage(
                                            selectedImage: selectedImage,
                                            isGallery: false,
                                          )),
                                ).then((value) => Navigator.pop(context));
                              },
                            ),
                          ],
                        )),
                      ),
                    );
                  });
            },
            child: const Icon(
              Icons.camera_alt,
              color: AppColors.mainWhite,
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Container(
        height: 70,
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Colors.black26,
              width: 0.5,
            ),
          ),
        ),
        child: BottomAppBar(
          elevation: 0,
          color: AppColors.mainWhite,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              // Home
              IconButton(
                  onPressed: () {
                    setState(() {
                      _pageIndex = 0;
                    });
                  },
                  icon: Icon(
                    Icons.home_filled,
                    color:
                        (_pageIndex == 0 ? AppColors.mainGreen : Colors.grey),
                    size: 28,
                  )),
              const SizedBox(width: 10),

              // Search
              IconButton(
                onPressed: () {
                  setState(() {
                    _pageIndex = 1;
                  });
                },
                icon: Icon(
                  Icons.search,
                  color: (_pageIndex == 1 ? AppColors.mainGreen : Colors.grey),
                  size: 28,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
