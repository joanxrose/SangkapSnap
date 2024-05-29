import 'package:flutter/material.dart';
import 'package:main_app/screens/tabSections/ingredientsView.dart';
import 'package:main_app/screens/tabSections/nutriInfo.dart';
import 'package:main_app/screens/tabSections/preparationView.dart';
import 'package:main_app/themes/colorConstants.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 3, // Number of tabs
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 250,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  "https://takestwoeggs.com/wp-content/uploads/2024/04/Filipino-Chicken-Adobo-adobong-manok-4-500x500.jpg",
                  fit: BoxFit.cover,
                ),
              ),
              backgroundColor: Colors.transparent,
              foregroundColor: AppColors.mainWhite,
            ),
            const SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Adobong Manok",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    Chip(
                      visualDensity: VisualDensity(horizontal: 0, vertical: -3),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      side: BorderSide.none,
                      backgroundColor: AppColors.mainGreen,
                      label: Text(
                        "217 kcal",
                        style: TextStyle(
                          color: AppColors.mainWhite,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverPersistentHeader(
              delegate: SliverAppBarDelegate(
                const TabBar(
                  labelColor: AppColors.mainGreen,
                  indicatorColor: AppColors.mainGreen,
                  tabs: [
                    Tab(text: "Ingredients"),
                    Tab(text: "Preparation"),
                    Tab(text: "Nutritional Info"),
                  ],
                ),
              ),
              pinned: true,
            ),
            const SliverFillRemaining(
              child: TabBarView(
                children: [
                  IngredientsView(),
                  PreparationView(),
                  NutriInfoView(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  SliverAppBarDelegate(this.tabBar);

  final TabBar tabBar;

  @override
  double get minExtent => tabBar.preferredSize.height;

  @override
  double get maxExtent => tabBar.preferredSize.height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      color: AppColors.mainWhite,
      child: tabBar,
    );
  }

  @override
  bool shouldRebuild(SliverAppBarDelegate oldDelegate) {
    return false;
  }
}
