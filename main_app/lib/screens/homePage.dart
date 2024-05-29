import 'package:flutter/material.dart';
import 'package:main_app/themes/colorConstants.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // TODO: Edit spacing between texts
  final header = const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Welcome to",
        style: TextStyle(fontSize: 34, fontWeight: FontWeight.w600),
      ),
      Text(
        "SangkapSnap!",
        style: TextStyle(
            fontSize: 34,
            fontWeight: FontWeight.w800,
            color: AppColors.mainGreen),
      ),
    ],
  );

  // Search
  // TODO: FAB stay in place when keyboard is active
  final searchField = TextField(
    style: const TextStyle(color: AppColors.gray),
    decoration: InputDecoration(
      hintText: "Search recipes or ingredients",
      border: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.mainGreen, width: 1.5),
        borderRadius: BorderRadius.circular(50),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.mainGreen, width: 1.5),
        borderRadius: BorderRadius.circular(50),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: AppColors.mainGreen, width: 2),
        borderRadius: BorderRadius.circular(50),
      ),
      prefixIcon: const Icon(Icons.search, color: AppColors.mainGreen),
      labelStyle: const TextStyle(color: AppColors.mainGreen),
    ),
    onTap: () {},
  );

  // Available Recipes Text
  final availableText = const Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "Available Recipes",
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800),
      ),
      Text(
        "Feel free to try any of the recipes here!",
        style: TextStyle(fontSize: 16, color: AppColors.gray),
      )
    ],
  );

  // Card
  final card = Container(
    decoration: BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: AppColors.gray.withOpacity(0.1),
          blurRadius: 8,
          offset: const Offset(
            0, // horizontally
            8.0, // vertically
          ),
        )
      ],
    ),
    child: Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      color: AppColors.mainWhite,
      child: InkWell(
        onTap: () {
          debugPrint("Clicked card!");
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  height: 180,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        "https://takestwoeggs.com/wp-content/uploads/2024/04/Filipino-Chicken-Adobo-adobong-manok-4-500x500.jpg",
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16)
                  .copyWith(bottom: 20),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Adobong Manok",
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Chip(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      side: BorderSide.none,
                      backgroundColor: AppColors.mainGreen,
                      label: Text(
                        "217 kcal",
                        style: TextStyle(
                            color: AppColors.mainWhite,
                            fontWeight: FontWeight.w600),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.mainWhite,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30)
                .copyWith(bottom: 120),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header,
                const SizedBox(
                  height: 20,
                ),
                searchField,
                const SizedBox(
                  height: 36,
                ),
                availableText,
                const SizedBox(
                  height: 24,
                ),
                card,
                const SizedBox(
                  height: 16,
                ),
                card,
              ],
            ),
          ),
        ));
  }
}
