import 'package:flutter/material.dart';
import 'package:main_app/themes/colorConstants.dart';

class IngredientsView extends StatelessWidget {
  final List<dynamic> ingredients;
  final List<String>? detectedList;

  const IngredientsView(
      {Key? key, required this.ingredients, this.detectedList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.mainWhite,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 70),
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ingredients.length,
        itemBuilder: (context, index) {
          final ingredient = ingredients[index];
          final ingredientName = ingredient["name"];

          // Check if the ingredient name is in the detected list
          final bool isDetected =
              detectedList?.contains(ingredientName) ?? false;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ingredient["measurement"],
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                ingredientName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: isDetected ? FontWeight.w800 : FontWeight.w400,
                  color: isDetected ? AppColors.mainGreen : Colors.black,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
