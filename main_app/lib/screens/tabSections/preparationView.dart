import 'package:flutter/material.dart';
import 'package:main_app/themes/colorConstants.dart';

class PreparationView extends StatelessWidget {
  final String instructions;

  const PreparationView({super.key, required this.instructions});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.mainWhite,
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 36),
            child: Column(
              children: [
                Text(
                  instructions.replaceAll('\\n', '\n\n'),
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ));
  }
}
