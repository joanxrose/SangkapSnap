import 'package:flutter/material.dart';
import 'package:main_app/themes/colorConstants.dart';

class SearchPage extends StatelessWidget {
  SearchPage({super.key});

  static const routename = '/search';

  final searchText = const Text(
    "Search",
    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
  );

  // Search
  final searchField = TextField(
    autofocus: true,
    style: const TextStyle(color: AppColors.gray),
    cursorColor: AppColors.mainGreen,
    decoration: InputDecoration(
      hintText: "Search recipes or ingredients",
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.mainGreen, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.mainGreen, width: 1.5),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.mainGreen, width: 2),
        borderRadius: BorderRadius.circular(20),
      ),
      prefixIcon: const Icon(Icons.search, color: AppColors.mainGreen),
      labelStyle: const TextStyle(color: AppColors.mainGreen),
    ),
    onTap: () {},
  );

  // Ingredient Chip
  final ingredientChip = const Chip(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(20))),
      side: BorderSide(color: AppColors.mainGreen),
      backgroundColor: AppColors.mainWhite,
      label: Text(
        "Baboy",
        style:
            TextStyle(color: AppColors.mainGreen, fontWeight: FontWeight.w600),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainWhite,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30)
              .copyWith(bottom: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              searchText,
              const SizedBox(
                height: 24,
              ),
              searchField,
              const SizedBox(
                height: 30,
              ),
              Wrap(
                direction: Axis.horizontal,
                runSpacing: 4,
                spacing: 4,
                children: [
                  ingredientChip,
                  ingredientChip,
                  ingredientChip,
                  ingredientChip,
                  ingredientChip,
                  ingredientChip,
                  ingredientChip,
                  ingredientChip,
                  ingredientChip,
                  ingredientChip,
                  ingredientChip,
                ],
              )
            ],
          ),
        ));
  }
}
