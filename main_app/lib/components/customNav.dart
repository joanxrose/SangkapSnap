import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main_app/screens/cameraPage.dart';
import 'package:main_app/screens/homePage.dart';
import 'package:main_app/screens/searchPage.dart';
import 'package:main_app/themes/colorConstants.dart';

class CustomNav extends StatefulWidget {
  const CustomNav({super.key});

  @override
  _CustomNavState createState() => _CustomNavState();
}

class _CustomNavState extends State<CustomNav> {
  int _pageIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const CameraPage(),
    const SearchPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              /* setState(() {
                _pageIndex = 1;
              }); */

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
                            ListTile(
                              leading: const Icon(
                                Icons.collections,
                                color: AppColors.mainGreen,
                              ),
                              title: const Text('Choose image from Gallery'),
                              onTap: () {
                                print("Choose from gallery");
                              },
                            ),
                            ListTile(
                              leading: const Icon(
                                Icons.camera_alt,
                                color: AppColors.mainGreen,
                              ),
                              title: const Text('Take photo'),
                              onTap: () {
                                print("Take photo");
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
              // Add top border side here
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
              IconButton(
                onPressed: () {
                  setState(() {
                    _pageIndex = 2;
                  });
                },
                icon: Icon(
                  Icons.search,
                  color: (_pageIndex == 2 ? AppColors.mainGreen : Colors.grey),
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
