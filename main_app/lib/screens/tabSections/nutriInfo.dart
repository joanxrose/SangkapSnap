import 'package:flutter/material.dart';
import 'package:main_app/themes/colorConstants.dart';

class NutriInfoView extends StatelessWidget {
  const NutriInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.mainWhite,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 50, horizontal: 90),
          child: Wrap(
            direction: Axis.horizontal,
            runSpacing: 16,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Energy (kcal) ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "200",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Carb (g)",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "3",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Protein (g)",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "9",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Fat (g)",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "25",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
