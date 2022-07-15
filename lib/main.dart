import 'package:flutter/material.dart';
import 'package:projetinho/app/ui/pages/widgets/fav_card.dart';
import 'package:projetinho/app/ui/pages/widgets/menu_joaozin.dart';
import 'package:projetinho/services/remote_services.dart';
import 'app/data/model/randon_recipe.dart';
import 'app/data/model/search.dart';
import 'app/ui/pages/widgets/card2.dart';
import 'app/ui/pages/widgets/fav_recipe_screen.dart';
import 'app/ui/pages/widgets/load.dart';
import 'app/ui/pages/widgets/main_title.dart';
import 'app/ui/pages/widgets/navbar.dart';
import 'app/ui/pages/widgets/navbar2.dart';
import 'app/ui/pages/widgets/recipes_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        unselectedWidgetColor: const Color(0xFFD6A155),
        primarySwatch: Colors.blue,
      ),
      home: const FoodAPP(),
    );
  }
}

class FoodAPP extends StatefulWidget {
  const FoodAPP({Key? key}) : super(key: key);

  @override
  State<FoodAPP> createState() => _IFoodAPPState();
}

class _IFoodAPPState extends State<FoodAPP> {
  List<Recipe> randomRecipes = [];
  var isLoaded = false;
  var v = 5;
  final list = [];
  final List<SearchRecipe> searchRecipies = [];
  late ScrollController _controller;
  _scrollListener() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    if (_controller.offset >= _controller.position.maxScrollExtent &&
        !_controller.position.outOfRange) {
      getData();
      if (isLoaded == false) {
        Center(
          child: SizedBox(
            width: screenWidth * 0.8,
            height: screenHeight * 0.36,
            child: const DecoratedBox(
              decoration: BoxDecoration(shape: BoxShape.rectangle),
              child: SpinKitPulse(
                color: Colors.grey,
                size: 2000,
              ),
            ),
          ),
        );
      } else if (randomRecipes == null) {
        const Text('');
      }
      {
        for (var i = 0; i < randomRecipes.length; i++) {
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RecipesScreen(recipe: randomRecipes[i]),
                ),
              );
            },
            child: MainCard(
              recipe: randomRecipes[i],
            ),
          );
        }
      }
    }
  }

  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);

    super.initState();
    getData();
  }

  getData() async {
    var post = await RemoteService().getRandomRecipes();
    if (post != null) {
      setState(() {
        randomRecipes.addAll(post.recipes);
        isLoaded = true;
      });
    }
    print(randomRecipes.length);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Color c = const Color(0xFFF2994A);

    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            controller: _controller,
            child: Column(
              children: [
                if (randomRecipes == null) ...{
                  const Text(''),
                } else
                  MenuJoaozin(
                      recipe: randomRecipes[0],
                      searchRecipies: searchRecipies,
                      function: () => setState(() {})),
                if (searchRecipies.isNotEmpty) ...{
                  for (var i = 0; i < searchRecipies.length; i++)
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () async {
                          var recipeNew = await RemoteService()
                              .getRecipeById(searchRecipies[i].id);

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  FavRecipeScreen(recipe: recipeNew),
                            ),
                          );
                        },
                        tileColor: Colors.blue,
                        title: Center(
                          child: Text(searchRecipies[i].title),
                        ),
                      ),
                    )
                } else if (randomRecipes == null) ...{
                  const Text(''),
                } else
                  const MainTitle(),
                if (isLoaded == false) ...{
                  Center(
                    child: SizedBox(
                      width: screenWidth * 0.8,
                      height: screenHeight * 0.36,
                      child: const DecoratedBox(
                        decoration: BoxDecoration(shape: BoxShape.rectangle),
                        child: SpinKitPulse(
                          color: Colors.grey,
                          size: 2000,
                        ),
                      ),
                    ),
                  ),
                } else if (randomRecipes == null) ...{
                  const Text(''),
                } else
                  for (var i = 0; i < randomRecipes.length; i++)
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                RecipesScreen(recipe: randomRecipes[i]),
                          ),
                        );
                      },
                      child: MainCard(
                        recipe: randomRecipes[i],
                      ),
                    ),
                if (randomRecipes == null) ...{
                  const Text(''),
                } else
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyApp(),
                        ),
                      );
                    },
                    child: const Load(),
                  ),
              ],
            ),
          ),
          bottomNavigationBar: const NavBar2(),
        ),
      ),
    );
  }
}
