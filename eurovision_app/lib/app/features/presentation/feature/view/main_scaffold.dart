import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_icons.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/common/constants/my_flutter_app_icons.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/feature_provider.dart';
import 'package:eurovision_app/app/features/presentation/home_detail/view/contestant_detail_view.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/mytopten_provider.dart';
import 'package:eurovision_app/app/features/presentation/search_video/view/video_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/core/constants/page_type_enum.dart';
import 'package:eurovision_app/app/features/presentation/home/view/home_view.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/view/my_top_ten_view.dart.dart';
import 'package:eurovision_app/app/features/presentation/about/view/about_view.dart';
import 'package:eurovision_app/app/features/presentation/home_detail/view/winner_view.dart';
import 'package:eurovision_app/app/common/widgets/appbar/common_appbar.dart';
import 'package:eurovision_app/app/common/widgets/appbar/custom_logo_appbar.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

/// Main scaffold widget managing app layout and navigation.
/// Handles AppBar, page routing, and bottom navigation bar.
class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  Widget build(BuildContext context) {
    final featureProvider = Provider.of<FeatureProvider>(context);
    final gradient = featureProvider.gradient;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar:(featureProvider.pageType == PageType.main &&
         featureProvider.currentIndex == 1 &&
         context.watch<MyTop10Provider>().showSecondPage)
        ? null
        : switch (featureProvider.pageType) {
            PageType.main => CustomLogoAppBar(
              backgroundGradient: LinearGradient(
                  begin: gradient.begin,
                  end: gradient.end,
                  colors: gradient.colors,
                ),
            ),
        _ => CommonAppBar(pageType: featureProvider.pageType),
      },
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
            color: AppColors.black),
          ),
        switch (featureProvider.pageType) {
          PageType.main => IndexedStack(
            index: featureProvider.currentIndex,
            children: [
              const HomeView(),
              MyTop10View(),
              
              VideoView(),
              const AboutView(),
            ],
          ),
          PageType.winner => const WinnerView(),
          PageType.contestantDetail => ContestantDetailView(
            id: featureProvider.selectedContestantId!,
            year: featureProvider.selectedYear!,
          ), 
        },
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
         currentIndex: featureProvider.currentIndex,
        onTap: (index) {
          featureProvider.changeIndex(index);
        },
        selectedItemColor: AppColors.crimson,
        unselectedItemColor: AppColors.white70,
        items: [
          SalomonBottomBarItem(
            icon: Icon(MyFlutterApp.home_outline),
            title: Text(AppStrings.homePage),
            selectedColor: AppColors.pinkyPink,
          ),
          SalomonBottomBarItem(
            icon: Icon(MyFlutterApp.star),
            title: Text(AppStrings.mytop10),
            selectedColor: AppColors.pinkyPink,
          ),
          SalomonBottomBarItem(
            icon: Icon(MyFlutterApp.video_1),
            title: Text(AppStrings.channel),
            selectedColor: AppColors.pinkyPink,
          ),
          SalomonBottomBarItem(
            icon: SvgPicture.asset(AppIcons.euHeart, height: 23, color: featureProvider.currentIndex == 3
                ? AppColors.pinkyPink
                : AppColors.white70), 
            title: Text(AppStrings.about),
            selectedColor: AppColors.pinkyPink,
          ),
        ],
      ),
    );
  }
}