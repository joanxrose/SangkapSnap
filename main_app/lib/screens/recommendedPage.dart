import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_app/components/customCard.dart';
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
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Recommended Recipes",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                    height: 1.2,
                    color: AppColors.mainGreen),
              ),
              SizedBox(
                height: 30,
              ),
              CustomCard(),
              SizedBox(
                height: 16,
              ),
              CustomCard(),
              SizedBox(
                height: 16,
              ),
              CustomCard(),
            ],
          ),
        ),
      ),
    );
  }
}
