import 'package:flutter/material.dart';
import 'package:projetinho/app/ui/pages/widgets/fav_card.dart';
import 'package:projetinho/app/ui/pages/widgets/menu_joaozin.dart';
import 'package:projetinho/services/remote_services.dart';
import 'app/data/model/randon_recipe.dart';
import 'app/data/model/search.dart';
import 'app/ui/pages/widgets/card2.dart';
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
  Post? randomRecipes;
  var isLoaded = false;
  final list = [];
  final List<SearchRecipe> searchRecipies = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    randomRecipes = await RemoteService().getRandomRecipes();
    if (randomRecipes != null) {
      setState(() {
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
            child: Column(
              children: [
                if (randomRecipes == null) ...{
                  const Text(''),
                } else
                  MenuJoaozin(
                      recipe: randomRecipes!.recipes[0],
                      searchRecipies: searchRecipies,
                      function: () => setState(() {})),
                if (searchRecipies.isNotEmpty) ...{
                  Container(
                    color: Colors.blue,
                    height: 55,
                    width: 50,
                  )
                } else if (randomRecipes == null) ...{
                  const Text(''),
                } else
                  const MainTitle(),
                // if (randomRecipes == null) ...{
                //   const Text(''),
                // } else
                //   Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                //     children: [
                //       FavCard(recipe: randomRecipes!.recipes[0]),
                //       FavCard(recipe: randomRecipes!.recipes[0]),
                //     ],
                //   ),
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
                  for (var i = 0; i < randomRecipes!.recipes.length; i++) ...{
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RecipesScreen(
                                recipe: randomRecipes!.recipes[i]),
                          ),
                        );
                      },
                      child: MainCard(
                        recipe: randomRecipes!.recipes[i],
                      ),
                    ),
                  },
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

// class RecipieSearch extends SearchDelegate<String> {
//   @override
//   List<Widget>? buildActions(BuildContext context) => [
//         IconButton(
//           icon: const Icon(Icons.clear),
//           onPressed: () {},
//         )
//       ];

//   @override
//   Widget? buildLeading(BuildContext context) => IconButton(
//         icon: const Icon(Icons.arrow_back),
//         onPressed: () {},
//       );

//   @override
//   Widget buildResults(BuildContext context) {
//     // TODO: implement buildResults
//     throw UnimplementedError();
//   }

//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // TODO: implement buildSuggestions
//     throw UnimplementedError();
//   }
// }
