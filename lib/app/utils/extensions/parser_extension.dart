extension StringExtension on String {
  // Get recipeId from url
  String uriToID() {
    String id = this.split('recipe_')[1];

    return id;
  }
}
