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
  List<String> selectedIngredients = [];
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

    // If query is an ingredient, toggle the specific ingredient chip
    _toggleChip(query.toLowerCase());

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

  // Fetch recipes based on the selected ingredient chips
  void _fetchRecipesByList() async {
    if (selectedIngredients.isEmpty) {
      setState(() {
        _searchResults = [];
        _isSearching = false;
      });
      return;
    }

    setState(() {
      _isSearching = true;
    });

    RecipeProvider recipeProvider =
        Provider.of<RecipeProvider>(context, listen: false);
    List<Map<String, dynamic>> results =
        await recipeProvider.fetchRecipesByList(selectedIngredients);

    setState(() {
      _searchResults = results;
      _isSearching = false;
    });
  }

  // Handle chip click
  void _toggleChip(String ingredient) {
    setState(() {
      if (selectedIngredients.contains(ingredient)) {
        selectedIngredients.remove(ingredient);
      } else {
        selectedIngredients.add(ingredient);
      }
    });

    // Fetch the recipes based on the selected chip ingredients
    _fetchRecipesByList();
  }

  // Check if ingredient is selected
  bool _isChipSelected(String ingredient) {
    return selectedIngredients.contains(ingredient);
  }

  final searchText = const Text(
    "Search",
    style: TextStyle(fontSize: 32, fontWeight: FontWeight.w800),
  );

  @override
  Widget build(BuildContext context) {
    // List of ingredient chips
    final List<String> ingredientsList = [
      "baboy",
      "bangus",
      "itlog",
      "kamatis",
      "kangkong",
      "malunggay",
      "monggo",
      "okra",
      "pechay",
      "sayote",
      "tokwa",
    ];

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
                  style: const TextStyle(color: AppColors.gray),
                  cursorColor: AppColors.mainGreen,
                  decoration: InputDecoration(
                    hintText: "Search a recipe or an ingredient",
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
                  children: ingredientsList.map((ingredient) {
                    return FilterChip(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      label: Text(
                        ingredient,
                        style: TextStyle(
                          color: _isChipSelected(ingredient)
                              ? AppColors.mainWhite
                              : AppColors.mainGreen,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      side: const BorderSide(color: AppColors.mainGreen),
                      selected: _isChipSelected(ingredient),
                      backgroundColor: AppColors.mainWhite,
                      selectedColor: AppColors.mainGreen,
                      checkmarkColor: AppColors.mainWhite,
                      onSelected: (isSelected) {
                        _toggleChip(ingredient);
                      },
                    );
                  }).toList(),
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
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CustomCard(
                              recipeID: recipe["recipe_id"],
                              recipeName: recipe["recipe_name"],
                              imageUrl: recipe["image"],
                              calories: recipe["calories"],
                              detectedList: selectedIngredients,
                            ),
                          );
                        }).toList(),
                      ),
              ],
            ),
          ),
        ));
  }
}
