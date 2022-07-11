import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetinho/app/ui/pages/widgets/recipes_screen.dart';

import '../../../../main.dart';
import '../../../../services/remote_services.dart';
import '../../../data/model/recipe.dart';
import 'fav_screen.dart';

class NavBar2 extends StatefulWidget {
  const NavBar2({
    Key? key,
  }) : super(key: key);

  @override
  State<NavBar2> createState() => _NavBar2State();
}

class _NavBar2State extends State<NavBar2> {
  Post? post;
  var isLoaded = false;
  @override
  void initState() {
    super.initState();
    getData();
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
    Color c = const Color(0xFFF2994A);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      color: c,
      width: screenWidth,
      height: screenWidth * 0.17,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, screenWidth * 0.03, 0, 0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
              child: Column(
                children: const [
                  Icon(
                    Icons.home,
                    color: Colors.white,
                  ),
                  Text(
                    "Home",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
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
              child: Column(
                children: const [
                  Icon(
                    Icons.book,
                    color: Colors.white,
                  ),
                  Text(
                    "Saved",
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
            if (isLoaded == false) ...{
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: const [
                    Icon(
                      Icons.star_rounded,
                      color: Colors.white,
                    ),
                    Text(
                      "Surprise",
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ),
            } else
              for (var i = 0; i < 1; i++)
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RecipesScreen(recipe: post!.recipes[i]),
                      ),
                    );
                  },
                  child: Column(
                    children: const [
                      Icon(
                        Icons.star_rounded,
                        color: Colors.white,
                      ),
                      Text(
                        "Surprise",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),
          ],
        ),
      ),
    );
  }
}
