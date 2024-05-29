import 'package:flutter/material.dart';
import 'package:main_app/themes/colorConstants.dart';

class PreparationView extends StatelessWidget {
  const PreparationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        color: AppColors.mainWhite,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 30, horizontal: 36),
          child: Column(
            children: [
              Text(
                "1. Lorem ipsum dolor sit amet, consectetur adipiscing elit.\n\n2. Pretium aenean pharetra magna ac placerat vestibulum lectus mauris.\n\n3. Sociis natoque penatibus et magnis dis parturient montes.\n\n4. Quis risus sed vulputate odio ut enim blandit volutpat. ",
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ));
  }
}
