import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sqflite/sqflite.dart';
import '../../../../services/remote_services.dart';
import '../../../data/model/randon_recipe.dart';
import '../../../data/model/search.dart';
import 'fav_recipe_screen.dart';
import 'dart:math';

class ScrollMenu extends StatefulWidget {
  const ScrollMenu({
    Key? key,
  }) : super(key: key);

  @override
  State<ScrollMenu> createState() => _ScrollMenuState();
}

class _ScrollMenuState extends State<ScrollMenu> {
  List<Recipe> randomRecipes = [];
  Post? post;
  final notifications = [];
  dynamic savedRecipes;
  var db;
  var isLoaded = false;

  loadBank() async {
    db = await openDatabase('db.db', version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE receitas (id INTEGER PRIMARY KEY, name TEXT, image TEXT, type TEXT, prep_time INTEGER, serving INTEGER, ingredients TEXT, instructions TEXT)');
    });
  }

  @override
  void initState() {
    super.initState();
    loadBank();
    getData();

    // for (var i = 0; i < savedRecipes!.extendedIngredients.length; i++) {
    // notifications.add(CheckboxState(
    //   title: savedRecipes!.extendedIngredients[i]['original'],
    // ));
    // }
  }

  getData() async {
    savedRecipes = await RemoteService().savedRecipes();
    savedRecipes.forEach((e) {
      var teste = e;
    });
    if (savedRecipes != null) {
      setState(() {
        isLoaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List listOfImages = [
      "https://cdn.pixabay.com/photo/2018/06/27/21/37/goulash-3502645_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/01/15/06/57/vegetarian-1141242_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/10/31/18/14/dessert-1786311_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/09/15/19/24/salad-1672505_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/08/09/10/30/tomatoes-1580273_960_720.jpg",
      "https://cdn.pixabay.com/photo/2019/05/06/14/24/bread-4183225_960_720.jpg",
      "https://cdn.pixabay.com/photo/2016/11/06/23/31/breakfast-1804457_960_720.jpg",
      "https://cdn.pixabay.com/photo/2018/08/31/19/13/pumpkin-soup-3645375_960_720.jpg",
      "https://cdn.pixabay.com/photo/2013/02/21/19/06/drink-84533_960_720.jpg",
      "https://cdn.pixabay.com/photo/2017/09/08/18/43/tomato-sauce-2729689_960_720.jpg",
      "https://cdn.pixabay.com/photo/2021/12/28/14/43/fingerfood-6899483_960_720.jpg",
      "https://cdn.pixabay.com/photo/2014/10/19/20/59/hamburger-494706_960_720.jpg",
      "https://cdn.pixabay.com/photo/2020/06/14/14/44/drink-5298126_960_720.jpg",
    ];
    List listOfTypeDishes = [
      "main course",
      "Side Dish",
      "dessert",
      "appetizer",
      "salad",
      "bread",
      "breakfast",
      "soup",
      "beverage",
      "sauce",
      "fingerfood",
      "snack",
      "drink",
    ];
    int randomNum(min, max) {
      return min + Random().nextInt(max - min);
    }

    Color c2 = const Color(0xFFFFF2DF);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.2,
      width: MediaQuery.of(context).size.width,
      color: c2,
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(
            screenWidth * 0.1, screenHeight * 0.05, screenWidth * 0.05, 0),
        scrollDirection: Axis.horizontal,
        itemCount: listOfImages.length,
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(15),
          );
        },
        itemBuilder: (context, index) {
          return Column(
            children: [
              Visibility(
                replacement: Center(
                  child: Container(
                    height: screenWidth * 0.16,
                    width: screenWidth * 0.16,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const SpinKitPulse(
                      color: Colors.grey,
                      size: 200,
                    ),
                  ),
                ),
                visible: isLoaded,
                child: listOfImages.isNotEmpty
                    ? GestureDetector(
                        onTap: () async {
                          var recipeNew = await RemoteService()
                              .getRecipeType(listOfTypeDishes[index]);
                          var asasa = await RemoteService()
                              .getRecipeById(recipeNew[randomNum(0, 49)].id);
                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FavRecipeScreen(recipe: asasa),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: NetworkImage(
                                  listOfImages[index],
                                ),
                                fit: BoxFit.cover),
                            shape: BoxShape.circle,
                          ),
                          height: screenWidth * 0.16,
                          width: screenWidth * 0.16,
                        ),
                      )
                    : Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        height: screenWidth * 0.16,
                        width: screenWidth * 0.16,
                        child: const Center(
                          child: Text("NO IMAGE"),
                        ),
                      ),
              ),
              listOfTypeDishes.isNotEmpty
                  ? SizedBox(
                      height: screenHeight * 0.02,
                      width: screenWidth * 0.16,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            listOfTypeDishes[index],
                            style: GoogleFonts.inter(
                              fontSize: screenHeight * 0.015,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: screenHeight * 0.02,
                      width: screenWidth * 0.16,
                    ),
            ],
          );
        },
      ),
    );
  }
}
