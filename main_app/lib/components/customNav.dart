import 'package:flutter/material.dart';
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
              setState(() {
                _pageIndex = 1;
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
