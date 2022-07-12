import 'package:flutter/material.dart';
import 'package:projetinho/app/ui/pages/widgets/find_input.dart';
import 'package:projetinho/app/ui/pages/widgets/scroll_menu.dart';

import '../../../data/model/randon_recipe.dart';
import '../../../data/model/search.dart';

class MenuJoaozin extends StatefulWidget {
  final Recipe recipe;
  final List<SearchRecipe> searchRecipies;
  final VoidCallback function;

  const MenuJoaozin({
    Key? key,
    required this.recipe,
    required this.searchRecipies,
    required this.function,
  }) : super(key: key);

  @override
  State<MenuJoaozin> createState() => _MenuJoaozinState();
}

class _MenuJoaozinState extends State<MenuJoaozin> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color c = const Color(0xFFD6A255);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Stack(
      children: [
        Column(
          children: [
            Container(
              height: screenHeight * 0.1,
              width: MediaQuery.of(context).size.width,
              color: c,
            ),
            ScrollMenu(
              recipe: widget.recipe,
            ),
          ],
        ),
        Positioned(
          left: screenWidth * 0.1,
          top: screenHeight * 0.07,
          child: FindInput(
            searchRecipies: widget.searchRecipies,
            function: widget.function,
          ),
        ),
      ],
    );
  }
}
