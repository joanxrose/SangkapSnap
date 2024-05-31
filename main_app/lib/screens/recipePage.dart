import 'package:flutter/material.dart';
import 'package:main_app/providers/recipe_provider.dart';
import 'package:main_app/screens/tabSections/ingredientsView.dart';
import 'package:main_app/screens/tabSections/nutriInfo.dart';
import 'package:main_app/screens/tabSections/preparationView.dart';
import 'package:main_app/themes/colorConstants.dart';
import 'package:provider/provider.dart';

class RecipePage extends StatelessWidget {
  final String recipeID;
  final List<String>? detectedList;

  const RecipePage({super.key, required this.recipeID, this.detectedList});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
      future: Provider.of<RecipeProvider>(context, listen: false)
          .fetchRecipeByID(recipeID),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: AppColors.mainGreen,
          ));
        } else if (snapshot.hasError) {
          return Text("Error ${snapshot.error}");
        } else {
          final recipe = Provider.of<RecipeProvider>(context).specificRecipe;
          return DefaultTabController(
            length: 3,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  expandedHeight: 250,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Image.network(
                      recipe["image"],
                      fit: BoxFit.cover,
                    ),
                  ),
                  backgroundColor: Colors.transparent,
                  foregroundColor: AppColors.mainWhite,
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          recipe["recipe_name"],
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.w800),
                        ),
                        Row(
                          children: [
                            const Text(
                              "Serving size: ",
                              style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.gray),
                            ),
                            Text(
                              "${recipe["serving_size"]} people",
                              style: const TextStyle(
                                  fontSize: 16, color: AppColors.gray),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Chip(
                            visualDensity: const VisualDensity(
                                horizontal: 0, vertical: -3),
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            side: BorderSide.none,
                            backgroundColor: AppColors.mainGreen,
                            label: recipe["calories"] != ""
                                ? Text(
                                    recipe["calories"],
                                    style: const TextStyle(
                                        color: AppColors.mainWhite,
                                        fontWeight: FontWeight.w600),
                                  )
                                : const Text(
                                    "No data available",
                                    style: TextStyle(
                                        color: AppColors.mainWhite,
                                        fontWeight: FontWeight.w600),
                                  )),
                      ],
                    ),
                  ),
                ),
                SliverPersistentHeader(
                  delegate: SliverAppBarDelegate(
                    const TabBar(
                      labelColor: AppColors.mainGreen,
                      indicatorColor: AppColors.mainGreen,
                      tabs: [
                        Tab(text: "Ingredients"),
                        Tab(text: "Preparation"),
                        Tab(text: "Nutritional Info"),
                      ],
                    ),
                  ),
                  pinned: true,
                ),
                SliverFillRemaining(
                  child: TabBarView(
                    children: [
                      IngredientsView(
                          ingredients: recipe["ingredients"],
                          detectedList: detectedList),
                      PreparationView(instructions: recipe["instructions"]),
                      NutriInfoView(
                        calories: recipe["calories"],
                        carb: recipe["carb"],
                        fat: recipe["fat"],
                        protein: recipe["protein"],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    ));
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.mainWhite,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
