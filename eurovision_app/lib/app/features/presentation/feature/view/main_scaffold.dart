import 'package:eurovision_app/app/features/presentation/feature/provider/gradient_provider.dart';
import 'package:eurovision_app/app/features/presentation/home_detail/view/contestant_detail_view.dart';
import 'package:eurovision_app/app/common/widgets/appbar/bottom_nav.dart';
import 'package:flutter/material.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/bottom_nav_provider.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/core/constants/page_type_enum.dart';
import 'package:eurovision_app/app/features/presentation/home/view/home_view.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/view/my_top_ten_view.dart.dart';
import 'package:eurovision_app/app/features/presentation/about/view/about_view.dart';
import 'package:eurovision_app/app/features/presentation/home_detail/view/winner_view.dart';
import 'package:eurovision_app/app/common/widgets/appbar/common_appbar.dart';
import 'package:eurovision_app/app/common/widgets/appbar/custom_logo_appbar.dart';

class MainScaffold extends StatelessWidget {
  const MainScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomNavProvider>(context);
    final gradientProvider = Provider.of<GradientProvider>(context);
    final gradient = gradientProvider.gradient;

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: switch (bottomProvider.pageType) {
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
              gradient: LinearGradient(
                begin: gradient.begin,
                end: gradient.end,
                colors: gradient.colors,
              ),
            ),
          ),
      
        switch (bottomProvider.pageType) {
          PageType.main => IndexedStack(
            index: bottomProvider.currentIndex,
            children: [
              const HomeView(),
              MyTop10View(),
              const AboutView(),
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
      bottomNavigationBar: const ShinyBottomNavBar(),
    );
  }
}