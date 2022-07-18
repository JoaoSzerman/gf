import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projetinho/app/ui/pages/widgets/search_input.dart';

import '../../../../services/remote_services.dart';
import '../../../data/model/search.dart';
import 'fav_recipe_screen.dart';
import 'find_input.dart';

class SearchScreen extends StatefulWidget {
  final List<SearchRecipe> searchRecipies;
  final VoidCallback function;

  const SearchScreen({
    Key? key,
    required this.searchRecipies,
    required this.function,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    Color c = const Color(0xFFF2994A);
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Column(
              children: [
                SearchInput(
                    searchRecipies: widget.searchRecipies,
                    function: () => setState(() {})),
                for (var i = 0; i < widget.searchRecipies.length; i++)
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: ListTile(
                      onTap: () async {
                        var recipeNew = await RemoteService()
                            .getRecipeById(widget.searchRecipies[i].id);

                        // ignore: use_build_context_synchronously
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                FavRecipeScreen(recipe: recipeNew),
                          ),
                        );
                      },
                      title: Center(
                        child: Text(
                          widget.searchRecipies[i].title,
                          style: GoogleFonts.inter(
                            fontSize: screenWidth * 0.045,
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
