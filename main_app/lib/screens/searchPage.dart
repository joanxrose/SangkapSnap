import 'package:flutter/material.dart';
import 'package:main_app/components/customCard.dart';
import 'package:main_app/providers/recipe_provider.dart';
import 'package:main_app/themes/colorConstants.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  SearchPage({super.key});

  static const routename = '/search';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  List<Map<String, dynamic>> _searchResults = [];
  bool _isSearching = false;

  void _performSearch(String query) async {
    setState(() {
      _isSearching = true;
    });

    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
        _isSearching = false;
      });

      return;
    }

    // Fetch recipes based on the query of the user
    RecipeProvider recipeProvider =
        Provider.of<RecipeProvider>(context, listen: false);
    List<Map<String, dynamic>> results =
        await recipeProvider.searchRecipes(query);

    // After fetching the results, toggle the isSearching
    setState(() {
      _searchResults = results;
      _isSearching = false;
    });
  }

  final searchText = const Text(
    "Search",
    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
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
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 30)
                .copyWith(bottom: 120),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                searchText,
                const SizedBox(
                  height: 24,
                ),
                TextField(
                  controller: searchController,
                  autofocus: true,
                  style: const TextStyle(color: AppColors.gray),
                  cursorColor: AppColors.mainGreen,
                  decoration: InputDecoration(
                    hintText: "Search recipes or ingredients",
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.mainGreen, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.mainGreen, width: 1.5),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: AppColors.mainGreen, width: 2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    prefixIcon:
                        const Icon(Icons.search, color: AppColors.mainGreen),
                    labelStyle: const TextStyle(color: AppColors.mainGreen),
                  ),
                  onSubmitted: _performSearch,
                ),
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
                ),
                const SizedBox(
                  height: 30,
                ),
                _isSearching
                    ? const Center(
                        child: CircularProgressIndicator(
                        color: AppColors.mainGreen,
                      ))
                    : Column(
                        children: _searchResults.map((recipe) {
                          return CustomCard(
                            recipeID: recipe["recipe_id"],
                            recipeName: recipe["recipe_name"],
                            imageUrl: recipe["image"],
                            calories: recipe["calories"],
                          );
                        }).toList(),
                      ),
              ],
            ),
          ),
        ));
  }
}
