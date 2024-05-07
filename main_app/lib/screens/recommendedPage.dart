import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:main_app/themes/colorConstants.dart';

class RecommendedPage extends StatelessWidget {
  RecommendedPage({super.key, required this.detectedList});

  final List<String?> detectedList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainWhite,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Recommended Recipes",
              style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 32,
                  height: 1.2,
                  color: AppColors.mainGreen),
            ),
            const SizedBox(
              height: 36,
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 4,
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Container(
                    width: 400,
                    height: 200,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0),
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0),
                      ),
                      color: AppColors.mainGreen,
                    ),
                  ),
                  Positioned(
                    top: 130,
                    child: Container(
                      width: 337,
                      height: 70,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20.0),
                          bottomRight: Radius.circular(20.0),
                        ),
                        color: Colors.white,
                      ),
                      child: const Padding(
                        padding: const EdgeInsets.only(top: 24, left: 20),
                        child: Text(
                          "Adobong Manok",
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
