class GetRecipeById {
  final int id;
  final String title;
  String? image;
  final int servings;
  List<dynamic> dishTypes;
  final int preparationMinutes;
  List<dynamic> extendedIngredients;
  List<dynamic> analyzedInstructions;
  int readyInMinutes;

  GetRecipeById({
    required this.id,
    required this.title,
    this.image,
    required this.dishTypes,
    required this.servings,
    required this.preparationMinutes,
    required this.extendedIngredients,
    required this.analyzedInstructions,
    required this.readyInMinutes,
  });

  static List<GetRecipeById> makeList(json) {
    List<GetRecipeById> list = [];
    json.forEach((data) {
      list.add(GetRecipeById(
        id: data['id'],
        title: data['title'],
        image: data["image"],
        dishTypes: data['dishTypes'],
        servings: data['servings'],
        preparationMinutes: data['preparationMinutes'],
        extendedIngredients: data['extendedIngredients'],
        analyzedInstructions: data['analyzedInstructions'],
        readyInMinutes: data['readyInMinutes'],
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
      readyInMinutes: data['readyInMinutes'],
    );
  }

  static Map<String, dynamic> toJson(GetRecipeById getRecipeById) => {
        'id': getRecipeById.id,
        'title': getRecipeById.title,
        'image': getRecipeById.image,
        'dishTypes': getRecipeById.dishTypes,
        'servings': getRecipeById.servings,
        'preparationMinutes': getRecipeById.preparationMinutes,
        'extendedIngredients': getRecipeById.extendedIngredients,
        'analyzedInstructions': getRecipeById.analyzedInstructions,
        'readyInMinutes': getRecipeById.readyInMinutes,
      };
}
