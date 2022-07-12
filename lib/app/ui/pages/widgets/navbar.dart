import 'package:flutter/material.dart';
import 'package:projetinho/app/ui/pages/widgets/recipes_screen.dart';

import '../../../../services/remote_services.dart';
import '../../../data/model/randon_recipe.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  State<NavBar> createState() => NavBarState();
}

class NavBarState extends State<NavBar> {
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
    double screenHeight = MediaQuery.of(context).size.height;
    Color c = const Color(0xFFF2994A);
    if (isLoaded == false) {
      const Text("Error");
    } else {
      for (var i = 0; i < post!.recipes.length; i++) {
        return BottomNavigationBar(
          backgroundColor: c,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withOpacity(.60),
          selectedFontSize: screenHeight * 0.019,
          unselectedFontSize: screenHeight * 0.019,
          onTap: (value) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RecipesScreen(recipe: post!.recipes[i]),
              ),
            );
          },
          items: const [
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: "Saved recipe",
              icon: Icon(Icons.save),
            ),
            BottomNavigationBarItem(
              label: "Surprise Recipe",
              icon: Icon(Icons.shuffle),
            ),
          ],
        );
      }
    }
    return Text("");
  }
}
