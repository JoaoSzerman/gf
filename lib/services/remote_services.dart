import 'dart:convert';
import 'dart:io';
import '../app/data/model/recipe.dart';
import 'package:http/http.dart' as http;

import '../app/data/model/search.dart';

var url = "https://api.spoonacular.com";
// String token = "9cbc1b350cd447b19561c12c27dabc6d";
String token = "fde37335550d4d8db57a7f049210e0d6";

var client = http.Client();

class RemoteService {
  Future<Post?> getRandomRecipes() async {
    var json;

    var randon = Uri.parse('$url/recipes/random?number=10&apiKey=$token');
    var respose = await client.get(randon, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    if (respose.statusCode == 200) {
      json = respose.body;
    }
    return postFromJson(json);
  }

  Future<List<SearchRecipe>> getRecipe(String searchText) async {
    var json;

    var search = Uri.parse(
        '$url/recipes/autocomplete?number=10&query=$searchText&apiKey=$token');
    var respose = await client.get(search, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    if (respose.statusCode == 200) {
      json = jsonDecode(respose.body);
    }
    print(json);
    return SearchRecipe.makeList(json);
  }
}
