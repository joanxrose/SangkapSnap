import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_app/components/customCard.dart';
import 'package:main_app/providers/recipe_provider.dart';
import 'package:main_app/screens/searchPage.dart';
import 'package:main_app/themes/colorConstants.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  static const routename = '/home';

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // For pagination scrolling
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener(scrollListener);
  }

  @override
  void dispose() {
    scrollController.removeListener(scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  void scrollListener() {
    if (scrollController.position.pixels >=
        scrollController.position.maxScrollExtent - 200) {
      Provider.of<RecipeProvider>(context, listen: false).fetchMoreRecipes();
    }
  }

  // Header
  final header = RichText(
    text: const TextSpan(
      style: TextStyle(
        height: 1.3,
        fontSize: 34,
        fontFamily: "PPPangramSans",
        color: Colors.black,
      ),
      children: [
        TextSpan(
          text: "Welcome to\n",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        TextSpan(
          text: "SangkapSnap",
          style: TextStyle(
            fontWeight: FontWeight.w800,
            color: AppColors.mainGreen,
          ),
        ),
        TextSpan(
          text: "!",
          style: TextStyle(
            fontWeight: FontWeight.w800,
          ),
        ),
      ],
    ),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      controller: scrollController,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 96, horizontal: 30)
            .copyWith(bottom: 120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            header,
            const SizedBox(
              height: 30,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        SearchPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: child,
                      );
                    },
                  ),
                );
              },
              child: IgnorePointer(
                child: TextField(
                  style: const TextStyle(color: AppColors.gray),
                  cursorColor: AppColors.mainGreen,
                  decoration: InputDecoration(
                    hintText: "Search recipes or ingredients",
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.mainGreen, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon:
                        const Icon(Icons.search, color: AppColors.mainGreen),
                    labelStyle: const TextStyle(color: AppColors.mainGreen),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 36,
            ),
            availableText,
            Consumer<RecipeProvider>(
              builder: (context, provider, child) {
                return Column(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: provider.recipes.length,
                      itemBuilder: (context, index) {
                        var recipe = provider.recipes[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CustomCard(
                              recipeID: recipe.id,
                              recipeName: recipe["recipe_name"],
                              imageUrl: recipe["image"],
                              calories: recipe["calories"]),
                        );
                      },
                    ),
                    if (provider.isFetchingRecipes)
                      const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainGreen,
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    ));
  }
}
