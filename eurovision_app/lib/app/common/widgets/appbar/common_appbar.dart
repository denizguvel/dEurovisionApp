import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/feature/bottom_nav_provider.dart';
import 'package:eurovision_app/core/constants/page_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final PageType pageType;

  const CommonAppBar({super.key, required this.pageType});

  String _getAppBarTitle(PageType pageType) {
    switch (pageType) {
      case PageType.winner:
        return AppStrings.winner;
      case PageType.deneme:
        return 'Deneme';
      case PageType.contestantDetail:
        return 'Contestant Detail';
      default:
        return AppStrings.mainPage;
    }
  }
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(_getAppBarTitle(pageType), style: TextStyle(color: AppColors.ghostWhite)),
      centerTitle: true,
      backgroundColor: AppColors.crimson,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: AppColors.ghostWhite,),
        onPressed: () {
          if (Navigator.of(context).canPop()) {
            Navigator.of(context).pop();
          } else {
            context.read<BottomNavProvider>().goBackToMain();
          }        
        },
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}