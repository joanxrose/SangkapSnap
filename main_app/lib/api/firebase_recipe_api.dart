import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FirebaseRecipeAPI {
  static final FirebaseFirestore recipeDB = FirebaseFirestore.instance;

  // Fetch all recipes
  /* Stream<QuerySnapshot> fetchAllRecipes() {
    return recipeDB.collection("recipes").snapshots();
  } */

  // Fetch all recipes WITH pagination
  Future<QuerySnapshot> fetchRecipesPagination(
      {DocumentSnapshot? lastDoc, int limit = 5}) {
    Query query =
        recipeDB.collection("recipes").orderBy("recipe_name").limit(limit);

    if (lastDoc != null) {
      query = query.startAfterDocument(lastDoc);
    }

    return query.get();
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

      // Count how many ingredients in the list are in the recipe
      int matchCount = 0;
      for (Map<String, dynamic> ingredient in ingredients) {
        if (ingredientNames
            .contains(ingredient["name"].toString().toLowerCase())) {
          matchCount++;
        }
      }

      // If recipe contains at least one ingredient in the list, add the recipe
      if (matchCount > 0) {
        Map<String, dynamic> foundRecipes = doc.data() as Map<String, dynamic>;
        foundRecipes["recipe_id"] = doc.id;

        // Add how many ingredients matches to be able to sort recipes later
        foundRecipes["match_count"] = matchCount;
        recipes.add(foundRecipes);
      }
    }

    // Sort recipes based on the match count
    recipes.sort((a, b) => b["match_count"].compareTo(a["match_count"]));

    // Remove the match count to the final recipe list
    recipes = recipes.map((recipe) {
      recipe.remove("match_count");
      return recipe;
    }).toList();

    return recipes;
  }
}
