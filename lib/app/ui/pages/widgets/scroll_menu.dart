import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../services/remote_services.dart';
import '../../../data/model/randon_recipe.dart';
import 'icon_img.dart';

class ScrollMenu extends StatefulWidget {
  final Recipe recipe;

  const ScrollMenu({
    Key? key,
    required this.recipe,
  }) : super(key: key);

  @override
  State<ScrollMenu> createState() => _ScrollMenuState();
}

class _ScrollMenuState extends State<ScrollMenu> {
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
    Color c2 = const Color(0xFFFFF2DF);
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.2,
      width: MediaQuery.of(context).size.width,
      color: c2,
      child: ListView.separated(
        padding: EdgeInsets.fromLTRB(
            screenWidth * 0.1, screenHeight * 0.05, screenWidth * 0.05, 0),
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        separatorBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.all(15),
          );
        },
        itemBuilder: (context, index) {
          return Column(
            children: [
              Visibility(
                replacement: Center(
                  child: Container(
                    height: screenWidth * 0.16,
                    width: screenWidth * 0.16,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: const SpinKitPulse(
                      color: Colors.grey,
                      size: 200,
                    ),
                  ),
                ),
                visible: isLoaded,
                child: IconIMG(recipe: widget.recipe),
              ),
              widget.recipe.dishTypes.isNotEmpty
                  ? SizedBox(
                      height: screenHeight * 0.02,
                      width: screenWidth * 0.16,
                      child: Center(
                        child: FittedBox(
                          fit: BoxFit.cover,
                          child: Text(
                            widget.recipe.dishTypes[0],
                            style: GoogleFonts.inter(
                              fontSize: screenHeight * 0.015,
                            ),
                          ),
                        ),
                      ),
                    )
                  : SizedBox(
                      height: screenHeight * 0.02,
                      width: screenWidth * 0.16,
                    ),
            ],
          );
        },
      ),
    );
  }
}
