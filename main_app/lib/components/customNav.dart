import 'package:flutter/material.dart';
import 'package:main_app/screens/cameraPage.dart';
import 'package:main_app/screens/homePage.dart';
import 'package:main_app/screens/searchPage.dart';

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

  void _onItemTapped(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_pageIndex],
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        backgroundColor: const Color(0xff357960),
        selectedItemColor: const Color(0xffffbb34),
        unselectedItemColor: const Color(0xfffbfcf6),
        elevation: 10,
        iconSize: 28,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home_filled), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.camera_alt), label: "Camera"),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search"),
        ],
        currentIndex: _pageIndex,
        onTap: (index) => _onItemTapped(index),
      ),
    );
  }
}
