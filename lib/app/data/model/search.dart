class SearchRecipe {
  final int id;
  final String title;

  SearchRecipe({
    required this.id,
    required this.title,
  });

  static List<SearchRecipe> makeList(json) {
    List<SearchRecipe> list = [];
    json.forEach((data) {
      list.add(SearchRecipe(
        id: data['id'],
        title: data['title'],
      ));
    });
    return list;
  }

  static SearchRecipe fromJson(Map data) {
    return SearchRecipe(
      id: data['id'],
      title: data['title'],
    );
  }

  static Map<String, dynamic> toJson(SearchRecipe searchRecipe) => {
        'id': searchRecipe.id,
        'title': searchRecipe.title,
      };
}
