// To parse this JSON data, do
//
//     final post = postFromJson(jsonString);

import 'dart:convert';

Post postFromJson(String str) => Post.fromJson(json.decode(str));

String postToJson(Post data) => json.encode(data.toJson());

class Post {
  Post({
    required this.recipes,
  });

  List<Recipe> recipes;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        recipes:
            List<Recipe>.from(json["recipes"].map((x) => Recipe.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "recipes": List<dynamic>.from(recipes.map((x) => x.toJson())),
      };
}

class Recipe {
  Recipe({
    this.vegetarian,
    this.vegan,
    this.glutenFree,
    this.dairyFree,
    this.veryHealthy,
    this.cheap,
    this.veryPopular,
    this.sustainable,
    this.lowFodmap,
    this.weightWatcherSmartPoints,
    this.gaps,
    this.preparationMinutes,
    this.cookingMinutes,
    this.aggregateLikes,
    this.healthScore,
    this.creditsText,
    this.license,
    this.sourceName,
    this.pricePerServing,
    required this.extendedIngredients,
    this.id,
    this.title,
    this.readyInMinutes,
    this.servings,
    this.sourceUrl,
    this.openLicense,
    this.image,
    this.imageType,
    this.summary,
    this.cuisines,
    required this.dishTypes,
    this.diets,
    this.occasions,
    this.instructions,
    required this.analyzedInstructions,
    this.originalId,
    this.spoonacularSourceUrl,
  });

  bool? vegetarian;
  bool? vegan;
  bool? glutenFree;
  bool? dairyFree;
  bool? veryHealthy;
  bool? cheap;
  bool? veryPopular;
  bool? sustainable;
  bool? lowFodmap;
  int? weightWatcherSmartPoints;
  String? gaps;
  int? preparationMinutes;
  int? cookingMinutes;
  int? aggregateLikes;
  int? healthScore;
  String? creditsText;
  String? license;
  String? sourceName;
  double? pricePerServing;
  List<dynamic> extendedIngredients;
  int? id;
  String? title;
  int? readyInMinutes;
  int? servings;
  String? sourceUrl;
  int? openLicense;
  String? image;
  String? imageType;
  String? summary;
  List<dynamic>? cuisines;
  List<dynamic> dishTypes;
  List<String?>? diets;
  List<dynamic>? occasions;
  String? instructions;
  List<AnalyzedInstruction> analyzedInstructions;
  dynamic originalId;
  String? spoonacularSourceUrl;

  factory Recipe.fromJson(Map<String, dynamic> json) => Recipe(
        vegetarian: json["vegetarian"],
        vegan: json["vegan"],
        glutenFree: json["glutenFree"],
        dairyFree: json["dairyFree"],
        veryHealthy: json["veryHealthy"],
        cheap: json["cheap"],
        veryPopular: json["veryPopular"],
        sustainable: json["sustainable"],
        lowFodmap: json["lowFodmap"],
        weightWatcherSmartPoints: json["weightWatcherSmartPoints"],
        gaps: json["gaps"],
        preparationMinutes: json["preparationMinutes"],
        cookingMinutes: json["cookingMinutes"],
        aggregateLikes: json["aggregateLikes"],
        healthScore: json["healthScore"],
        creditsText: json["creditsText"],
        license: json["license"],
        sourceName: json["sourceName"],
        pricePerServing: json["pricePerServing"].toDouble(),
        extendedIngredients:
            List<dynamic>.from(json["extendedIngredients"].map((x) => x)),
        id: json["id"],
        title: json["title"],
        readyInMinutes: json["readyInMinutes"],
        servings: json["servings"],
        sourceUrl: json["sourceUrl"],
        openLicense: json["openLicense"],
        image: json["image"],
        imageType: json["imageType"],
        summary: json["summary"],
        cuisines: List<dynamic>.from(json["cuisines"].map((x) => x)),
        dishTypes: List<dynamic>.from(json["dishTypes"].map((x) => x)),
        diets: List<String>.from(json["diets"].map((x) => x)),
        occasions: List<dynamic>.from(json["occasions"].map((x) => x)),
        instructions: json["instructions"],
        analyzedInstructions: List<AnalyzedInstruction>.from(
            json["analyzedInstructions"]
                .map((x) => AnalyzedInstruction.fromJson(x))),
        originalId: json["originalId"],
        spoonacularSourceUrl: json["spoonacularSourceUrl"],
      );

  Map<String, dynamic> toJson() => {
        "vegetarian": vegetarian,
        "vegan": vegan,
        "glutenFree": glutenFree,
        "dairyFree": dairyFree,
        "veryHealthy": veryHealthy,
        "cheap": cheap,
        "veryPopular": veryPopular,
        "sustainable": sustainable,
        "lowFodmap": lowFodmap,
        "weightWatcherSmartPoints": weightWatcherSmartPoints,
        "gaps": gaps,
        "preparationMinutes": preparationMinutes,
        "cookingMinutes": cookingMinutes,
        "aggregateLikes": aggregateLikes,
        "healthScore": healthScore,
        "creditsText": creditsText,
        "license": license,
        "sourceName": sourceName,
        "pricePerServing": pricePerServing,
        "extendedIngredients":
            List<dynamic>.from(extendedIngredients.map((x) => x.toJson())),
        "id": id,
        "title": title,
        "readyInMinutes": readyInMinutes,
        "servings": servings,
        "sourceUrl": sourceUrl,
        "openLicense": openLicense,
        "image": image,
        "imageType": imageType,
        "summary": summary,
        "cuisines": List<dynamic>.from(cuisines!.map((x) => x)),
        "dishTypes": List<dynamic>.from(dishTypes.map((x) => x)),
        "diets": List<dynamic>.from(diets!.map((x) => x)),
        "occasions": List<dynamic>.from(occasions!.map((x) => x)),
        "instructions": instructions,
        "analyzedInstructions":
            List<dynamic>.from(analyzedInstructions.map((x) => x.toJson())),
        "originalId": originalId,
        "spoonacularSourceUrl": spoonacularSourceUrl,
      };
}

class AnalyzedInstruction {
  AnalyzedInstruction({
    this.name,
    required this.steps,
  });

  String? name;
  List<Step> steps;

  factory AnalyzedInstruction.fromJson(Map<String, dynamic> json) =>
      AnalyzedInstruction(
        name: json["name"],
        steps: List<Step>.from(json["steps"].map((x) => Step.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "steps": List<dynamic>.from(steps.map((x) => x.toJson())),
      };
}

class Step {
  Step({
    this.number,
    this.step,
    this.ingredients,
    this.equipment,
    this.length,
  });

  int? number;
  String? step;
  List<Ent>? ingredients;
  List<Ent>? equipment;
  Length? length;

  factory Step.fromJson(Map<String, dynamic> json) => Step(
        number: json["number"],
        step: json["step"],
        ingredients:
            List<Ent>.from(json["ingredients"].map((x) => Ent.fromJson(x))),
        equipment:
            List<Ent>.from(json["equipment"].map((x) => Ent.fromJson(x))),
        length: json["length"] == null ? null : Length.fromJson(json["length"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "step": step,
        "ingredients": List<dynamic>.from(ingredients!.map((x) => x.toJson())),
        "equipment": List<dynamic>.from(equipment!.map((x) => x.toJson())),
        "length": length == null ? null : length!.toJson(),
      };
}

class Ent {
  Ent({
    this.id,
    this.name,
    this.localizedName,
    this.image,
  });

  int? id;
  String? name;
  String? localizedName;
  String? image;

  factory Ent.fromJson(Map<String, dynamic> json) => Ent(
        id: json["id"],
        name: json["name"],
        localizedName: json["localizedName"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "localizedName": localizedName,
        "image": image,
      };
}

class Length {
  Length({
    this.number,
    this.unit,
  });

  int? number;
  String? unit;

  factory Length.fromJson(Map<String, dynamic> json) => Length(
        number: json["number"],
        unit: json["unit"],
      );

  Map<String, dynamic> toJson() => {
        "number": number,
        "unit": unit,
      };
}

class ExtendedIngredient {
  ExtendedIngredient({
    this.id,
    this.aisle,
    this.image,
    this.consistency,
    this.name,
    this.nameClean,
    required this.original,
    this.originalName,
    this.amount,
    this.unit,
    this.meta,
    this.measures,
  });

  int? id;
  String? aisle;
  String? image;
  Consistency? consistency;
  String? name;
  String? nameClean;
  String original;
  String? originalName;
  double? amount;
  String? unit;
  List<String>? meta;
  Measures? measures;

  factory ExtendedIngredient.fromJson(Map<String, dynamic> json) =>
      ExtendedIngredient(
        id: json["id"],
        aisle: json["aisle"],
        image: json["image"],
        consistency: consistencyValues.map[json["consistency"]],
        name: json["name"],
        nameClean: json["nameClean"],
        original: json["original"],
        originalName: json["originalName"],
        amount: json["amount"].toDouble(),
        unit: json["unit"],
        meta: List<String>.from(json["meta"].map((x) => x)),
        measures: Measures.fromJson(json["measures"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "aisle": aisle,
        "image": image,
        "consistency": consistencyValues.reverse[consistency],
        "name": name,
        "nameClean": nameClean,
        "original": original,
        "originalName": originalName,
        "amount": amount,
        "unit": unit,
        "meta": List<dynamic>.from(meta!.map((x) => x)),
        "measures": measures?.toJson(),
      };
}

enum Consistency { solid, liquid }

final consistencyValues =
    EnumValues({"liquid": Consistency.liquid, "solid": Consistency.solid});

class Measures {
  Measures({
    this.us,
    this.metric,
  });

  Metric? us;
  Metric? metric;

  factory Measures.fromJson(Map<String, dynamic> json) => Measures(
        us: Metric.fromJson(json["us"]),
        metric: Metric.fromJson(json["metric"]),
      );

  Map<String, dynamic> toJson() => {
        "us": us?.toJson(),
        "metric": metric?.toJson(),
      };
}

class Metric {
  Metric({
    this.amount,
    this.unitShort,
    this.unitLong,
  });

  double? amount;
  String? unitShort;
  String? unitLong;

  factory Metric.fromJson(Map<String, dynamic> json) => Metric(
        amount: json["amount"].toDouble(),
        unitShort: json["unitShort"],
        unitLong: json["unitLong"],
      );

  Map<String, dynamic> toJson() => {
        "amount": amount,
        "unitShort": unitShort,
        "unitLong": unitLong,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
