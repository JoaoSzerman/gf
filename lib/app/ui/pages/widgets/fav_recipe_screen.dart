import 'package:projetinho/app/ui/pages/widgets/navbar2.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetinho/app/data/model/checkbox_state.dart';
import '../../../../main.dart';
import '../../../../services/remote_services.dart';
import '../../../data/model/randon_recipe.dart';
import '../../../data/model/recipe.dart';
import 'button_back.dart';
import 'fav_fav_star.dart';
import 'fav_img_cad.dart';
import 'fav_screen.dart';
import 'fav_text_card.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FavRecipeScreen extends StatefulWidget {
  const FavRecipeScreen({
    Key? key,
    required this.recipe,
  }) : super(key: key);
  final GetRecipeById recipe;

  @override
  State<FavRecipeScreen> createState() => _FavRecipeScreenState();
}

class _FavRecipeScreenState extends State<FavRecipeScreen> {
  bool value = false;
  Color c = const Color(0xFFF2994A);
  final notifications = [];
  Post? post;
  var isLoaded = false;
  var list = [];
  bool firstClick = false;
  var db;
  late FToast fToast;

  loadBank() async {
    db = await openDatabase('db.db', version: 1);

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
    getData();
    fToast = FToast();
    fToast.init(context);

    for (var i = 0; i < widget.recipe.extendedIngredients.length; i++) {
      notifications.add(CheckboxState(
        title: widget.recipe.extendedIngredients[i]['original'],
      ));
    }
  }

  _showSavedToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.greenAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Recipe saved successfully"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  _showDisavedToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: Colors.redAccent,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Recipe successfully deleted"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  getData() async {
    post = await RemoteService().getRandomRecipes();
    if (post != null) {
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
                      child: FavIMGCard(recipe: widget.recipe),
                    ),
                    Positioned(
                      left: screenWidth * 0.04,
                      top: screenHeight * 0.25,
                      child: Card(
                        elevation: 8,
                        child: FavTextCard(recipe: widget.recipe),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => FavScreen(
                              savedRecipes: post!.recipes[0],
                            ),
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
                          _showSavedToast();
                          await db.rawInsert(
                              'INSERT INTO receitas(id, name, image, type, prep_time, serving, ingredients, instructions) VALUES("${widget.recipe.id}", "${widget.recipe.title}", "${widget.recipe.image}", "${widget.recipe.dishTypes.toString()}", "${widget.recipe.preparationMinutes}","${widget.recipe.servings}","${widget.recipe.extendedIngredients.toString()}", "${widget.recipe.analyzedInstructions.toString()}")');
                        } else {
                          setState(() {
                            firstClick = false;
                          });
                          _showDisavedToast();
                          await db.rawDelete(
                              'DELETE from receitas WHERE id = ?',
                              [widget.recipe.id]);
                        }
                      },
                      child: FavFavStar(
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
                    i < widget.recipe.analyzedInstructions[0]["steps"].length;
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
                              widget.recipe
                                  .analyzedInstructions[0]["steps"][i]["step"]
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
        bottomNavigationBar: const NavBar2(
          inHome: false,
          inScreen: false,
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
