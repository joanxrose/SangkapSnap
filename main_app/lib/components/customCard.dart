import 'package:flutter/material.dart';
import 'package:main_app/screens/recipePage.dart';
import 'package:main_app/themes/colorConstants.dart';

// TODO: Change image when image from the internet cannot be fetched
class CustomCard extends StatelessWidget {
  final String recipeID;
  final String recipeName;
  final String imageUrl;
  final String calories;

  const CustomCard(
      {super.key,
      required this.recipeID,
      required this.recipeName,
      required this.imageUrl,
      required this.calories});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.gray.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(
              0, // horizontally
              8.0, // vertically
            ),
          )
        ],
      ),
      child: Card(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        color: AppColors.mainWhite,
        child: InkWell(
          onTap: () {
            // debugPrint("Clicked card!");
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    RecipePage(recipeID: recipeID),
                transitionsBuilder:
                    (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: Tween<Offset>(
                      begin: const Offset(1.0, 0.0),
                      end: Offset.zero,
                    ).animate(animation),
                    child: child,
                  );
                },
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 180,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(imageUrl),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 12, horizontal: 16)
                        .copyWith(bottom: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      recipeName,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Chip(
                        visualDensity:
                            const VisualDensity(horizontal: 0, vertical: -4),
                        shape: const RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        side: BorderSide.none,
                        backgroundColor: AppColors.mainGreen,
                        label: calories != ""
                            ? Text(
                                "$calories",
                                style: const TextStyle(
                                    color: AppColors.mainWhite,
                                    fontWeight: FontWeight.w600),
                              )
                            : const Text(
                                "No data available",
                                style: TextStyle(
                                    color: AppColors.mainWhite,
                                    fontWeight: FontWeight.w600),
                              ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
