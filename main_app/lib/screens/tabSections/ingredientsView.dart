import 'package:flutter/material.dart';
import 'package:main_app/themes/colorConstants.dart';

class IngredientsView extends StatelessWidget {
  final List<dynamic> ingredients;

  const IngredientsView({super.key, required this.ingredients});

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
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ingredient["measurement"] ?? "",
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                ingredient["name"] ?? "",
                style: const TextStyle(fontSize: 16),
              ),
            ],
          );
        },
      ),
    );
  }
}
