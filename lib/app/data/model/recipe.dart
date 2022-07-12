class GetRecipeById {
  final int id;
  final String title;
  final String image;
  final int servings;
  List<dynamic> dishTypes;
  final int preparationMinutes;
  List<dynamic> extendedIngredients;
  List<dynamic> analyzedInstructions;

  GetRecipeById({
    required this.id,
    required this.title,
    required this.image,
    required this.dishTypes,
    required this.servings,
    required this.preparationMinutes,
    required this.extendedIngredients,
    required this.analyzedInstructions,
  });

  static List<GetRecipeById> makeList(json) {
    List<GetRecipeById> list = [];
    json.forEach((data) {
      list.add(GetRecipeById(
        id: data['id'],
        title: data['title'],
        image: data['image'],
        dishTypes: data['dishTypes'],
        servings: data['servings'],
        preparationMinutes: data['preparationMinutes'],
        extendedIngredients: data['extendedIngredients'],
        analyzedInstructions: data['analyzedInstructions'],
      ));
    });
    return list;
  }

  static GetRecipeById fromJson(Map data) {
    return GetRecipeById(
      id: data['id'],
      title: data['title'],
      image: data['image'],
      dishTypes: data['dishTypes'],
      servings: data['servings'],
      preparationMinutes: data['preparationMinutes'],
      extendedIngredients: data['extendedIngredients'],
      analyzedInstructions: data['analyzedInstructions'],
    );
  }

  static Map<String, dynamic> toJson(GetRecipeById getRecipeById) => {
        'id': getRecipeById.id,
        'title': getRecipeById.title,
        'image': getRecipeById.title,
        'dishTypes': getRecipeById.title,
        'servings': getRecipeById.title,
        'preparationMinutes': getRecipeById.title,
        'extendedIngredients': getRecipeById.title,
        'analyzedInstructions': getRecipeById.title,
      };
}
