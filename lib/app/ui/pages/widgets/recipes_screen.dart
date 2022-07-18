import 'dart:convert';

import 'package:projetinho/app/ui/pages/widgets/navbar2.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetinho/app/data/model/checkbox_state.dart';
import 'package:projetinho/app/ui/pages/widgets/star.dart';
import 'package:projetinho/app/ui/pages/widgets/text_card.dart';
import '../../../../main.dart';
import '../../../data/model/randon_recipe.dart';
import '../../../data/model/search.dart';
import 'button_back.dart';
import 'img_card.dart';
import 'navbar.dart';

class RecipesScreen extends StatefulWidget {
  RecipesScreen({
    Key? key,
    required this.recipe,
  }) : super(key: key);
  final Recipe recipe;
  final List<SearchRecipe> searchRecipies = [];

  @override
  State<RecipesScreen> createState() => _RecipesScreenState();
}

class _RecipesScreenState extends State<RecipesScreen> {
  bool value = false;
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
    List<Map> list = await db
        .rawQuery("SELECT * FROM receitas WHERE id = ?", [widget.recipe.id]);
    if (list.isNotEmpty) {
      setState(() {
        firstClick = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    loadBank();

    for (var i = 0; i < widget.recipe.extendedIngredients.length; i++) {
      notifications.add(CheckboxState(
        title: widget.recipe.extendedIngredients[i]['original'],
      ));
    }
  }

  @override
  void dispose() async {
    super.dispose();
    await db.close();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.35,
                child: Stack(
                  children: [
                    SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.3,
                      child: IMGCard(recipe: widget.recipe),
                    ),
                    Positioned(
                      left: screenWidth * 0.04,
                      top: screenHeight * 0.25,
                      child: Card(
                        elevation: 8,
                        child: TextCard(recipe: widget.recipe),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const FoodAPP(),
                          ),
                        );
                      },
                      child: const ButtonBack(),
                    ),
                    GestureDetector(
                      onTap: () async {
                        if (firstClick == false) {
                          setState(() {
                            firstClick = true;
                          });
                          await db.rawInsert(
                              'INSERT INTO receitas(id, name, image, type, prep_time, serving, ingredients, instructions) VALUES("${widget.recipe.id}", "${widget.recipe.title}", "${widget.recipe.image}", "${widget.recipe.dishTypes.toString()}", "${widget.recipe.preparationMinutes}","${widget.recipe.servings}","${widget.recipe.extendedIngredients.toString()}", "${widget.recipe.analyzedInstructions.toString()}")');
                          print(await db.rawQuery('SELECT * FROM receitas'));
                        } else {
                          setState(() {
                            firstClick = false;
                          });
                          await db.rawDelete(
                              'DELETE from receitas WHERE id = ?',
                              [widget.recipe.id]);
                        }
                      },
                      child: FavStar(
                        recipe: widget.recipe,
                        isActive: firstClick,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(
                    0, screenHeight * 0.02, 0, screenHeight * 0.02),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: screenWidth * 0.55,
                    height: screenHeight * 0.04,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Ingredients',
                        style: GoogleFonts.inter(),
                      ),
                    ),
                  ),
                ),
              ),
              ...notifications.map((v) => buildSingkeCheckBox(v)).toList(),
              Padding(
                padding: EdgeInsets.fromLTRB(screenWidth * 0.085,
                    screenHeight * 0.02, 0, screenHeight * 0.02),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SizedBox(
                    width: screenWidth * 0.55,
                    height: screenHeight * 0.04,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Text(
                        'Preparation Mode',
                        style: GoogleFonts.inter(),
                      ),
                    ),
                  ),
                ),
              ),
              for (var i = 0;
                  i < widget.recipe.analyzedInstructions.length;
                  i++) ...{
                for (var i = 0;
                    i < widget.recipe.analyzedInstructions[0].steps.length;
                    i++) ...{
                  Padding(
                    padding: EdgeInsets.fromLTRB(screenHeight * 0.1,
                        screenHeight * 0.02, 0, screenHeight * 0.02),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                            screenHeight * 0.1, 0, 0, screenHeight * 0.02),
                        child: Container(
                          width: screenWidth * 0.025,
                          height: screenHeight * 0.03,
                          decoration: BoxDecoration(
                            color: c,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: screenWidth * 0.7,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(screenWidth * 0.05, 0,
                              screenWidth * 0.02, screenHeight * 0.02),
                          child: Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              widget
                                  .recipe.analyzedInstructions[0].steps[i].step
                                  .toString(),
                              style: GoogleFonts.inter(
                                fontSize: screenHeight * 0.025,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                }
              }
            ],
          ),
        ),
        bottomNavigationBar: const NavBar2(),
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
