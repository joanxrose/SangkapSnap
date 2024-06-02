import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:main_app/api/firebase_recipe_api.dart';

class RecipeProvider with ChangeNotifier {
  late FirebaseRecipeAPI firebaseService;
  late Stream<QuerySnapshot> _recipesStream;
  late DocumentSnapshot _specificRecipe;
  late List<Map<String, dynamic>> _recipesByIngredients;
  late List<DocumentSnapshot> _recipes = [];
  DocumentSnapshot? _lastDocument;
  bool _hasMoreRecipes = true;
  bool _isFetchingRecipes = false;

  RecipeProvider() {
    firebaseService = FirebaseRecipeAPI();
    fetchRecipes();
  }

  // Getter (to get all the recipes in the database)
  // For fetching recipes without pagination
  Stream<QuerySnapshot> get recipesStream => _recipesStream;

  // Getter to get list of recipes
  // For pagination
  List<DocumentSnapshot> get recipes => _recipes;

  // Check if there are still recipes to load
  bool get hasMoreRecipes => _hasMoreRecipes;

  // Check if currently fetching recipes
  bool get isFetchingRecipes => _isFetchingRecipes;

  // Getter for a specific recipe
  DocumentSnapshot get specificRecipe => _specificRecipe;

  // Fetch all recipes
  /* void fetchRecipes() {
    _recipesStream = firebaseService.fetchAllRecipes();
    notifyListeners();
  } */
  void fetchRecipes() async {
    if (_isFetchingRecipes) return;

    _isFetchingRecipes = true;
    notifyListeners();

    QuerySnapshot snapshot = await firebaseService.fetchRecipesPagination();
    _recipes = snapshot.docs;
    _lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
    _hasMoreRecipes = snapshot.docs.length == 5;

    _isFetchingRecipes = false;
    notifyListeners();
  }

  // Fetch more recipes for pagination
  void fetchMoreRecipes() async {
    if (_isFetchingRecipes || !_hasMoreRecipes) return;

    _isFetchingRecipes = true;
    notifyListeners();

    QuerySnapshot snapshot =
        await firebaseService.fetchRecipesPagination(lastDoc: _lastDocument);

    _recipes.addAll(snapshot.docs);
    _lastDocument = snapshot.docs.isNotEmpty ? snapshot.docs.last : null;
    _hasMoreRecipes = snapshot.docs.length == 5;

    _isFetchingRecipes = false;
    notifyListeners();
  }

  // Fetch a specific recipe by ID
  Future<void> fetchRecipeByID(String recipeID) async {
    _specificRecipe = await firebaseService.fetchRecipe(recipeID);
    notifyListeners();
  }

  // Fetch recipes based on a list of ingredients
  Future<List<Map<String, dynamic>>> fetchRecipesByList(
      List<String> ingredientNames) async {
    _recipesByIngredients =
        await firebaseService.fetchRecipesByIngredients(ingredientNames);
    return _recipesByIngredients;
  }

  // Search
  Future<List<Map<String, dynamic>>> searchRecipes(String query) async {
    return await firebaseService.searchRecipes(query);
  }
}
