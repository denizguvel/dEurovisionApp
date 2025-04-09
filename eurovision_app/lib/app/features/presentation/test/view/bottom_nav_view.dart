import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/bottom_nav_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/view/cat_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/contest_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/home_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BottomNavigationScreen extends StatelessWidget {
  BottomNavigationScreen({super.key});

  final List<Widget> _screens =  [
    HomeView(),
    ContestView(),
    CatView(),
  ];

  @override
  Widget build(BuildContext context) {
    final bottomprovider = Provider.of<BottomNavProvider>(context);

    return Scaffold(
      body: _screens[bottomprovider.currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: bottomprovider.currentIndex,
        onTap: bottomprovider.changeIndex,
        backgroundColor: AppColors.crimson,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: AppStrings.homePage,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.music_note),
            label: AppStrings.contests,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: AppStrings.profilePage,
          ),
        ],
      ),
    );
  }
}