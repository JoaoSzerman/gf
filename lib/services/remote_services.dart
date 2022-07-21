import 'dart:convert';
import 'dart:io';
import 'package:projetinho/app/data/model/recipe.dart';
import 'package:sqflite/sqflite.dart';
import '../app/data/model/randon_recipe.dart';
import 'package:http/http.dart' as http;
import '../app/data/model/search.dart';

var url = "https://api.spoonacular.com";
// String token = "098fb19936bf42e6a9fd9c0f42d2bb44";
// String token = "9cbc1b350cd447b19561c12c27dabc6d";
// String token = "b2e4e5ccaafe4a39be0c4f8f061d41d6";
// String token = "fde37335550d4d8db57a7f049210e0d6";
// String token = "a707daea423444938a6624eaa75a2c74";

String token = "e0eff240b1c94a049347236a7dd06e25";

var client = http.Client();

class RemoteService {
  Future<Post?> getRandomRecipes() async {
    var json;

    var randon = Uri.parse('$url/recipes/random?number=25&apiKey=$token');
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
        '$url/recipes/autocomplete?number=5&query=$searchText&apiKey=$token');
    var respose = await client.get(search, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    if (respose.statusCode == 200) {
      json = jsonDecode(respose.body);
    }
    print(json);
    return SearchRecipe.makeList(json);
  }

  savedRecipes() async {
    var db = await openDatabase('db.db', version: 1);
    List<Map> listFav = await db.rawQuery("SELECT * FROM receitas");

    // listFav.forEach((element) => print(element));

    return listFav;
  }

  Future<GetRecipeById> getRecipeById(id) async {
    var json;

    var saved = Uri.parse('$url/recipes/$id/information?apiKey=$token');
    var respose = await client.get(saved, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    if (respose.statusCode == 200) {
      json = respose.body;
    }

    return GetRecipeById.fromJson(jsonDecode(json));
  }

  Future<List<SearchRecipe>> getRecipeType(recipeType) async {
    var json;

    var randon = Uri.parse(
        '$url/recipes/complexSearch?number=50&type=$recipeType&apiKey=$token');
    var respose = await client.get(randon, headers: {
      HttpHeaders.contentTypeHeader: "application/json",
    });
    if (respose.statusCode == 200) {
      json = respose.body;
    }
    return SearchRecipe.makeList(jsonDecode(json)["results"]);
  }
}

/**
 * 
 */