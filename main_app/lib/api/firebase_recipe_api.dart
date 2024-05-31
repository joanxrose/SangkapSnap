import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseRecipeAPI {
  static final FirebaseFirestore recipeDB = FirebaseFirestore.instance;

  // Fetch all recipes
  Stream<QuerySnapshot> fetchAllRecipes() {
    return recipeDB.collection("recipes").snapshots();
  }

  // Fetch specific recipe
  Future<DocumentSnapshot> fetchRecipe(String recipeID) {
    return recipeDB.collection("recipes").doc(recipeID).get();
  }

  // Fetch recipes given a list of ingredients
  Future<List<Map<String, dynamic>>> fetchRecipesByIngredients(
      List<String> ingredientNames) async {
    List<Map<String, dynamic>> recipes = [];

    // Query all recipes
    QuerySnapshot recipesSnapshot = await recipeDB.collection("recipes").get();

    // Iterate through each recipe
    for (QueryDocumentSnapshot doc in recipesSnapshot.docs) {
      List<dynamic> ingredients = doc["ingredients"];

      // Check if the ingredients in the list is in the recipe's ingredients
      bool containsIngredient = false;

      for (Map<String, dynamic> ingredient in ingredients) {
        if (ingredientNames
            .contains(ingredient["name"].toString().toLowerCase())) {
          containsIngredient = true;
          break;
        }
      }

      // If recipe contains at least one of the ingredients in the list, add the recipe to the result list
      if (containsIngredient) {
        recipes.add(doc.data() as Map<String, dynamic>);
      }
    }

    return recipes;
  }
}
