// import 'package:eurovision_app/app/common/constants/app_colors.dart';
// import 'package:eurovision_app/app/common/constants/app_icons.dart';
// import 'package:eurovision_app/app/common/constants/app_strings.dart';
// import 'package:eurovision_app/app/common/widgets/appbar/custom_logo_appbar.dart';
// import 'package:eurovision_app/app/features/presentation/test/provider/bottom_nav_provider.dart';
// import 'package:eurovision_app/app/features/presentation/test/provider/gradient_provider.dart';
// import 'package:eurovision_app/app/features/presentation/test/view/cat_view.dart';
// import 'package:eurovision_app/app/features/presentation/test/view/contest_view.dart';
// import 'package:eurovision_app/app/features/presentation/test/view/home_view.dart';
// import 'package:eurovision_app/app/features/presentation/test/view/winner_view.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class BottomNavigationScreen extends StatelessWidget {
//   const BottomNavigationScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final bottomProvider = Provider.of<BottomNavProvider>(context);
//     final gradientProvider = Provider.of<GradientProvider>(context);
//     final gradient = gradientProvider.gradient;

//     return Scaffold(
//       appBar: CustomLogoAppBar(backgroundGradient: LinearGradient(
//         begin: gradient.begin,
//         end: gradient.end,
//         colors: gradient.colors,
//       )),
//       body: Container(
//         //color: Theme.of(context).scaffoldBackgroundColor,
//         child: IndexedStack(
//           index: bottomProvider.currentIndex,
//           children: [
//             HomeView(),
//             ContestView(),
//             CatView(),
//             WinnerView()
//           ],
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: bottomProvider.currentIndex,
//         onTap: bottomProvider.changeIndex,
//         backgroundColor: AppColors.crimson,
//         selectedItemColor: Colors.white,
//         unselectedItemColor: Colors.grey,
//         type: BottomNavigationBarType.fixed,
//         items: [
//           BottomNavigationBarItem(
//             icon: Image.asset(AppIcons.euHeart, width: 24, height: 24),
//             label: AppStrings.homePage,
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.music_note),
//             label: AppStrings.contests,
//           ),
//           const BottomNavigationBarItem(
//             icon: Icon(Icons.pets),
//             label: 'Cats',
//           ),
//         ],
//       ),
//     );
//   }

//   String _getAppBarTitle(int index) {
//     switch (index) {
//       case 0:
//         return AppStrings.homePage;
//       case 1:
//         return AppStrings.contests;
//       case 2:
//         return 'Cats';
//       default:
//         return '';
//     }
//   }
// }

import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/common/widgets/appbar/custom_logo_appbar.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/bottom_nav_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/gradient_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/view/cat_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/contest_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/home_view.dart';
import 'package:eurovision_app/app/features/presentation/test/view/winner_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class BottomNavigationScreen extends StatelessWidget {
  const BottomNavigationScreen({super.key});
@override
Widget build(BuildContext context) {
  final bottomProvider = Provider.of<BottomNavProvider>(context);
  final gradientProvider = Provider.of<GradientProvider>(context);
  final gradient = gradientProvider.gradient;

  return Scaffold(
    appBar: CustomLogoAppBar(
      backgroundGradient: LinearGradient(
        begin: gradient.begin,
        end: gradient.end,
        colors: gradient.colors,
      ),
    ),
    body: bottomProvider.isDetailView
        ? WinnerView()
        : IndexedStack(
            index: bottomProvider.currentIndex,
            children: [
              const HomeView(),
              const ContestView(),
              CatView(),
            ],
          ),
    bottomNavigationBar: BottomNavigationBar(
      currentIndex: bottomProvider.currentIndex,
      onTap: bottomProvider.changeIndex,
      backgroundColor: AppColors.crimson,
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      type: BottomNavigationBarType.fixed,
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
          icon: Icon(Icons.pets),
          label: 'Cats',
        ),
      ],
    ),
  );
}}
