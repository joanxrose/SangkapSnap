import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:main_app/themes/colorConstants.dart';

class RecommendedPage extends StatelessWidget {
  RecommendedPage({super.key, required this.detectedList});

  final List<String?> detectedList;

  @override
  Widget build(BuildContext context) {
    final card = Container(
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
            debugPrint("Clicked card!");
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    height: 180,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://takestwoeggs.com/wp-content/uploads/2024/04/Filipino-Chicken-Adobo-adobong-manok-4-500x500.jpg",
                        ),
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
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Adobong Manok",
                      style:
                          TextStyle(fontWeight: FontWeight.w800, fontSize: 20),
                    ),
                    SizedBox(
                      height: 4,
                    ),
                    Chip(
                        visualDensity:
                            VisualDensity(horizontal: 0, vertical: -4),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(20))),
                        side: BorderSide.none,
                        backgroundColor: AppColors.mainGreen,
                        label: Text(
                          "217 kcal",
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

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainWhite,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Recommended Recipes",
                style: TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 32,
                    height: 1.2,
                    color: AppColors.mainGreen),
              ),
              const SizedBox(
                height: 30,
              ),
              card,
              const SizedBox(
                height: 16,
              ),
              card,
              const SizedBox(
                height: 16,
              ),
              card,
            ],
          ),
        ),
      ),
    );
  }
}
