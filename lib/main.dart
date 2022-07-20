import 'package:flutter/material.dart';
import 'package:projetinho/app/ui/pages/widgets/menu_joaozin.dart';
import 'package:projetinho/services/remote_services.dart';
import 'app/data/model/randon_recipe.dart';
import 'app/data/model/search.dart';
import 'app/ui/pages/widgets/card2.dart';
import 'app/ui/pages/widgets/main_title.dart';
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
                      searchRecipies: searchRecipies,
                      function: () => setState(() {})),
                if (randomRecipes == null) ...{
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
              ],
            ),
          ),
          bottomNavigationBar: const NavBar2(
            inHome: true,
            inScreen: false,
            inSurprise: false,
          ),
        ),
      ),
    );
  }
}
