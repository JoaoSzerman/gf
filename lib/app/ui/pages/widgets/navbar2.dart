import 'package:flutter/material.dart';
import 'package:projetinho/app/ui/pages/widgets/recipes_screen.dart';
import '../../../../main.dart';
import '../../../../services/remote_services.dart';
import '../../../data/model/randon_recipe.dart';
import 'fav_screen.dart';

class NavBar2 extends StatefulWidget {
  final bool inHome;
  final bool inSurprise;
  final bool inScreen;
  const NavBar2({
    Key? key,
    required this.inHome,
    required this.inScreen,
    required this.inSurprise,
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
            widget.inHome != true
                ? GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => MyApp()),
                      );
                    },
                    child: Column(
                      children: const [
                        Icon(
                          Icons.home_outlined,
                          color: Colors.white,
                        ),
                        Text(
                          "Home",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                : Column(
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
            widget.inScreen != true && post != null
                ? GestureDetector(
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
                          Icons.star_outline,
                          color: Colors.white,
                        ),
                        Text(
                          "Saved",
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )
                : Column(
                    children: const [
                      Icon(
                        Icons.star,
                        color: Colors.white,
                      ),
                      Text(
                        "Saved",
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
            if (isLoaded == false) ...{
              GestureDetector(
                onTap: () {},
                child: Column(
                  children: const [
                    Icon(
                      Icons.help_center_outlined,
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
                widget.inSurprise != true
                    ? GestureDetector(
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
                              Icons.help_center_outlined,
                              color: Colors.white,
                            ),
                            Text(
                              "Surprise",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: const [
                          Icon(
                            Icons.help_center,
                            color: Colors.white,
                          ),
                          Text(
                            "Surprise",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
          ],
        ),
      ),
    );
  }
}
