import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_icons.dart';
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

class MainScaffold extends StatefulWidget {
  const MainScaffold({super.key});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomNavProvider>(context);
    final gradientProvider = Provider.of<GradientProvider>(context);
    final gradient = gradientProvider.gradient;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar:(bottomProvider.pageType == PageType.main &&
         bottomProvider.currentIndex == 1 &&
         context.watch<MyTop10Provider>().showSecondPage)
        ? null
        : switch (bottomProvider.pageType) {
            PageType.main => CustomLogoAppBar(
              backgroundGradient: LinearGradient(
                  begin: gradient.begin,
                  end: gradient.end,
                  colors: gradient.colors,
                ),
            ),
        _ => CommonAppBar(pageType: bottomProvider.pageType),
      },
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
            color: AppColors.black),
          ),
        switch (bottomProvider.pageType) {
          PageType.main => IndexedStack(
            index: bottomProvider.currentIndex,
            children: [
              const HomeView(),
              MyTop10View(),
              const AboutView(),
              VideoView(),
            ],
          ),
          PageType.winner => const WinnerView(),
          PageType.contestantDetail => ContestantDetailView(
            id: bottomProvider.selectedContestantId!,
            year: bottomProvider.selectedYear!,
          ), 
        },
        ],
      ),
      bottomNavigationBar: SalomonBottomBar(
         currentIndex: bottomProvider.currentIndex,
        onTap: (index) {
          bottomProvider.changeIndex(index);
        },
        selectedItemColor: AppColors.crimson,
        unselectedItemColor: AppColors.white70,
        items: [
          SalomonBottomBarItem(
            icon: SvgPicture.asset(AppIcons.euHeart, height: 20, color: AppColors.white70,),
            title: Text("Home"),
            selectedColor: AppColors.pinkyPink,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.star_border),
            title: Text("My Top 10"),
            selectedColor: Colors.amber,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.home_filled),
            title: Text("About"),
            selectedColor: Colors.red,
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.play_arrow),
            title: Text("Channel"),
            selectedColor: Colors.red,
          ),
        ],
      ),
    );
  }
}