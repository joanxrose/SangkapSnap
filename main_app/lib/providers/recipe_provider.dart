import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:main_app/api/firebase_recipe_api.dart';

class RecipeProvider with ChangeNotifier {
  late FirebaseRecipeAPI firebaseService;
  late Stream<QuerySnapshot> _recipesStream;
  late DocumentSnapshot _specificRecipe;
  late List<Map<String, dynamic>> _recipesByIngredients;

  RecipeProvider() {
    firebaseService = FirebaseRecipeAPI();
    fetchRecipes();
  }

  // Getter (to get all the recipes in the database)
  Stream<QuerySnapshot> get recipesStream => _recipesStream;

  // Getter for a specific recipe
  DocumentSnapshot get specificRecipe => _specificRecipe;

  // Getter to get all the recipes that have specific ingredients
  List<Map<String, dynamic>> get recipesByIngredients => _recipesByIngredients;

  // Fetch all recipes
  void fetchRecipes() {
    _recipesStream = firebaseService.fetchAllRecipes();
    notifyListeners();
  }

  // Fetch a specific recipe by ID
  Future<void> fetchRecipeByID(String recipeID) async {
    _specificRecipe = await firebaseService.fetchRecipe(recipeID);
    notifyListeners();
  }

  // Fetch recipes based on a list of ingredients
  Future<void> fetchRecipesByList(List<String> ingredientNames) async {
    _recipesByIngredients =
        await firebaseService.fetchRecipesByIngredients(ingredientNames);
    notifyListeners();
  }
}
