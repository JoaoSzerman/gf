import 'package:flutter/material.dart';
import 'package:projetinho/app/data/model/randon_recipe.dart';
import 'package:projetinho/app/ui/pages/widgets/star.dart';
import 'package:projetinho/app/ui/pages/widgets/text_card.dart';
import 'img_card.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sqflite/sqflite.dart';

class MainCard extends StatefulWidget {
  final Recipe recipe;

  const MainCard({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  State<MainCard> createState() => _MainCardState();
}

var db;

loadBank() async {
  db = await openDatabase('db.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE receitas (id INTEGER PRIMARY KEY, name TEXT, image TEXT, type TEXT, prep_time INTEGER, serving INTEGER, ingredients TEXT, instructions TEXT)');
  });
}

class _MainCardState extends State<MainCard> {
  bool firstClick = false;
  late FToast fToast;
  @override
  void initState() {
    super.initState();
    loadBank();
    fToast = FToast();
    fToast.init(context);
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * 0.03),
      child: Card(
        elevation: 8,
        child: SizedBox(
          width: screenWidth * 0.8,
          height: screenHeight * 0.37,
          child: Stack(
            children: [
              Column(
                children: [
                  IMGCard(recipe: widget.recipe),
                  TextCard(recipe: widget.recipe),
                ],
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
                  } else if (firstClick == true) {
                    setState(() {
                      firstClick = false;
                    });
                    _showDisavedToast();
                    await db.rawDelete('DELETE from receitas WHERE id = ?',
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
      ),
    );
  }
}
