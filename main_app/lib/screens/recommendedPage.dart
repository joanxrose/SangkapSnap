import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:main_app/components/customCard.dart';
import 'package:main_app/providers/recipe_provider.dart';
import 'package:main_app/themes/colorConstants.dart';
import 'package:provider/provider.dart';

class RecommendedPage extends StatelessWidget {
  RecommendedPage({Key? key, required this.detectedList}) : super(key: key);

  final List<String> detectedList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainWhite,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recommended Recipes",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 32,
                  height: 1.2,
                  color: AppColors.mainGreen,
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: Provider.of<RecipeProvider>(context)
                    .fetchRecipesByList(detectedList),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.mainGreen,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                      child: Text("No recipes available!"),
                    );
                  } else {
                    print("Detected List: ${detectedList}");

                    print("Future List: ${snapshot.data}");
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        var recipe = snapshot.data![index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: CustomCard(
                            recipeID: recipe["recipe_id"],
                            recipeName: recipe["recipe_name"],
                            imageUrl: recipe["image"],
                            calories: recipe["calories"],
                            detectedList: detectedList,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
