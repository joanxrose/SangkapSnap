import 'package:flutter/material.dart';
import 'package:main_app/themes/colorConstants.dart';

class NutriInfoView extends StatelessWidget {
  final String calories;
  final String carb;
  final String fat;
  final String protein;

  const NutriInfoView(
      {super.key,
      required this.calories,
      required this.carb,
      required this.fat,
      required this.protein});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.mainWhite,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 90),
          child: Wrap(
            direction: Axis.horizontal,
            runSpacing: 16,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Energy ",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    calories == "" ? "n/a" : calories,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Carbs",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    carb == "" ? "n/a" : carb,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Protein",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    protein == "" ? "n/a" : protein,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Fat",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    fat == "" ? "n/a" : fat,
                    style: const TextStyle(fontSize: 16),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
