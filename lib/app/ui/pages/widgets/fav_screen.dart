import 'package:projetinho/app/ui/pages/widgets/navbar2.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetinho/app/data/model/checkbox_state.dart';
import '../../../../services/remote_services.dart';
import '../../../data/model/randon_recipe.dart';
import 'fav_card.dart';
import 'fav_recipe_screen.dart';
import 'load.dart';

class FavScreen extends StatefulWidget {
  const FavScreen({
    Key? key,
    this.savedRecipes,
  }) : super(key: key);
  final Recipe? savedRecipes;

  @override
  State<FavScreen> createState() => _FavScreenState();
}

class _FavScreenState extends State<FavScreen> {
  dynamic savedRecipes;
  dynamic randomRecipes;

  bool value = false;
  var isLoaded = false;
  Color c = const Color(0xFFF2994A);
  final notifications = [];
  var list = [];
  bool firstClick = false;
  var db;

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

    for (var i = 0; i < widget.savedRecipes!.extendedIngredients.length; i++) {
      notifications.add(CheckboxState(
        title: widget.savedRecipes!.extendedIngredients[i]['original'],
      ));
    }
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
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: savedRecipes == null || savedRecipes.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: SizedBox(
                        width: screenWidth * 0.55,
                        height: screenHeight * 0.04,
                        child: FittedBox(
                          fit: BoxFit.contain,
                          child: Text(
                            'No saved recipes',
                            style: GoogleFonts.inter(),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Back(),
                    ),
                  ],
                ),
              )
            : SizedBox(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    if (savedRecipes == null) ...{
                      const Text(''),
                    } else
                      for (var i = 0; i < savedRecipes!.length; i++)
                        GestureDetector(
                          onTap: () async {
                            var recipeNew = await RemoteService()
                                .getRecipeById(savedRecipes![i]['id']);

                            // ignore: use_build_context_synchronously
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    FavRecipeScreen(recipe: recipeNew),
                              ),
                            );
                          },
                          child: FavCard(
                            savedRecipes: savedRecipes![i],
                          ),
                        ),
                  ],
                ),
              ),
        bottomNavigationBar: const NavBar2(
          inHome: false,
          inScreen: true,
          inSurprise: false,
        ),
      ),
    );
  }

  Widget buildSingkeCheckBox(CheckboxState checkbox) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SizedBox(
      width: screenWidth * 0.8,
      child: CheckboxListTile(
        controlAffinity: ListTileControlAffinity.leading,
        activeColor: c,
        checkColor: Colors.white,
        value: checkbox.value,
        onChanged: (value) => setState(() => checkbox.value = value!),
        title: Text(
          checkbox.title,
          style: GoogleFonts.inter(
            fontSize: screenHeight * 0.025,
          ),
        ),
      ),
    );
  }
}
