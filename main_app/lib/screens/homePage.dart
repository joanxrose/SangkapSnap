import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_app/components/customCard.dart';
import 'package:main_app/providers/recipe_provider.dart';
import 'package:main_app/screens/searchPage.dart';
import 'package:main_app/themes/colorConstants.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  static const routename = '/home';

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
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 116, horizontal: 30)
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
                return StreamBuilder<QuerySnapshot>(
                    stream: provider.recipesStream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.mainGreen,
                          ),
                        );
                      } else if (snapshot.hasError) {
                        return Text("Error: ${snapshot.error}");
                      } else if (!snapshot.hasData) {
                        return const Center(
                          child: Text("No recipes available!"),
                        );
                      } else {
                        return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: snapshot.data!.docs.length,
                            itemBuilder: (context, index) {
                              var recipe = snapshot.data!.docs[index];
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: CustomCard(
                                    recipeID: recipe.id,
                                    recipeName: recipe["recipe_name"],
                                    imageUrl: recipe["image"],
                                    calories: recipe["calories"]),
                              );
                            });
                      }
                    });
              },
            )
          ],
        ),
      ),
    ));
  }
}
