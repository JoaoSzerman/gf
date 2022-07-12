import 'package:flutter/material.dart';
import 'package:projetinho/app/ui/pages/widgets/card2.dart';
import 'package:sqflite/sqflite.dart';
import '../../../data/model/randon_recipe.dart';

class IMGFavCard extends StatefulWidget {
  final dynamic savedRecipes;

  const IMGFavCard({Key? key, required this.savedRecipes}) : super(key: key);

  @override
  State<IMGFavCard> createState() => _IMGFavCardState();
}

var list = db.query('receitas', columns: ["image"]);

bool firstClick = false;
var db;
loadBank() async {
  db = await openDatabase('db.db', version: 1);
}

class _IMGFavCardState extends State<IMGFavCard> {
  @override
  void initState() {
    super.initState();
    loadBank();
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

    return widget.savedRecipes["image"] == "null" ||
            widget.savedRecipes["image"] != null
        ? SizedBox(
            width: screenWidth,
            height: screenWidth * 0.28,
            child: Image(
              fit: BoxFit.cover,
              image: NetworkImage(
                widget.savedRecipes["image"],
              ),
            ),
          )
        : SizedBox(
            width: screenWidth,
            height: screenWidth * 0.28,
            child: const Center(
              child: Text("NO IMAGE"),
            ),
          );
  }
}
