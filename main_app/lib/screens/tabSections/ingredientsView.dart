import 'package:flutter/material.dart';
import 'package:main_app/themes/colorConstants.dart';

class IngredientsView extends StatelessWidget {
  const IngredientsView({super.key});

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
                    "1kg",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Chicken",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2 tbsp.",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Vinegar",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "2 tbsp.",
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    "Vinegar",
                    style: TextStyle(fontSize: 16),
                  )
                ],
              ),
            ],
          ),
        ));
  }
}
