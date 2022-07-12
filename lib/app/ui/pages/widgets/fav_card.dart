import 'package:flutter/material.dart';
import 'package:projetinho/app/data/model/randon_recipe.dart';
import 'package:projetinho/app/ui/pages/widgets/text_fav_card.dart';
import 'package:sqflite/sqflite.dart';
import 'img_fav_card.dart';

class FavCard extends StatefulWidget {
  final dynamic savedRecipes;

  const FavCard({
    Key? key,
    required this.savedRecipes,
  }) : super(key: key);

  @override
  State<FavCard> createState() => _FavCardState();
}

bool firstClick = false;
var db;

loadBank() async {
  db = await openDatabase('db.db', version: 1);
}

class _FavCardState extends State<FavCard> {
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
    return Padding(
      padding: EdgeInsets.fromLTRB(0, 0, 0, screenHeight * 0.03),
      child: Card(
        elevation: 8,
        child: SizedBox(
          width: screenWidth * 0.37,
          height: screenWidth * 0.4,
          child: Column(
            children: [
              IMGFavCard(savedRecipes: widget.savedRecipes),
              TextFavCard(savedRecipes: widget.savedRecipes),
            ],
          ),
        ),
      ),
    );
  }
}
