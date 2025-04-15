import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_icons.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/feature/bottom_nav_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ShinyBottomNavBar extends StatelessWidget {
  const ShinyBottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final bottomProvider = Provider.of<BottomNavProvider>(context);

    final items = [
      (icon: AppIcons.euHeart, label: AppStrings.homePage),
      (icon: AppIcons.rank1, label: AppStrings.mytop10),
      (icon: AppIcons.worldIcon, label: AppStrings.moreBottomItem),
    ];

    return Container(
      height: 80,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.crimson4, AppColors.crimson5],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        //borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: List.generate(items.length, (index) {
              final selected = index == bottomProvider.currentIndex;
              return GestureDetector(
                onTap: () => bottomProvider.changeIndex(index),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOut,
                  padding: const EdgeInsets.all(8),
                  transform: selected
                      ? Matrix4.translationValues(0, -8, 0)
                      : Matrix4.identity(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        items[index].icon,
                        width: selected ? 30 : 24,
                        height: selected ? 30 : 24,
                        color: selected ? AppColors.white : AppColors.gray300,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        items[index].label,
                        style: TextStyle(
                          color: selected ? AppColors.white : AppColors.gray300,
                          fontWeight: selected ? FontWeight.bold : FontWeight.normal,
                          fontSize: 12,
                        ),
                      )
                    ],
                  ),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}