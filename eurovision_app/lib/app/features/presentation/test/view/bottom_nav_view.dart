import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_icons.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/common/widgets/appbar/common_appbar.dart';
import 'package:eurovision_app/app/common/widgets/appbar/custom_logo_appbar.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/bottom_nav_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/gradient_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/view/about_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/contest_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/deneme.dart';
import 'package:eurovision_app/app/features/presentation/test/view/home_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/new_bottom.dart';
import 'package:eurovision_app/app/features/presentation/test/view/winner_view.dart';
import 'package:eurovision_app/core/constants/page_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});
@override
Widget build(BuildContext context) {
  final bottomProvider = Provider.of<BottomNavProvider>(context);
  final gradientProvider = Provider.of<GradientProvider>(context);
  final gradient = gradientProvider.gradient;

  return Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        begin: gradient.begin,
        end: gradient.end,
        colors: gradient.colors,
      ),
    ),
    child: Scaffold(
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
      body: switch (bottomProvider.pageType) {
        PageType.main => IndexedStack(
          index: bottomProvider.currentIndex,
          children: [
            const HomeView(),
            const ContestView(),
            const AboutView(),
          ],
        ),
        PageType.winner => const WinnerView(),
        PageType.deneme => const Deneme(),
      },
      bottomNavigationBar: const ShinyBottomNavBar(),
      // bottomNavigationBar: BottomNavigationBar(
      //   currentIndex: bottomProvider.currentIndex,
      //   onTap: bottomProvider.changeIndex,
      //   backgroundColor: AppColors.crimson,
      //   selectedItemColor: Colors.white,
      //   unselectedItemColor: Colors.grey,
      //   type: BottomNavigationBarType.fixed,
      //   items: [
      //     BottomNavigationBarItem(
      //       icon: SvgPicture.asset(AppIcons.euHeart, width: 24, height: 24, color: bottomProvider.currentIndex == 0 ? Colors.white : Colors.grey,),
      //       label: AppStrings.homePage,
      //     ),
      //     const BottomNavigationBarItem(
      //       icon: Icon(Icons.music_note),
      //       label: AppStrings.contests,
      //     ),
      //      BottomNavigationBarItem(
      //       icon: SvgPicture.asset(AppIcons.worldIcon, width: 24, height: 24, color: bottomProvider.currentIndex == 2 ? Colors.white : Colors.grey,),
      //       label: AppStrings.moreBottomItem,
      //     ),
      //   ],
      // ),
    ),
  );
}}
