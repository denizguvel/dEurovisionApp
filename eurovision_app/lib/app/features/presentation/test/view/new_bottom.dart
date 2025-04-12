import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_icons.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/bottom_nav_provider.dart';
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
      (icon: '', label: AppStrings.contests),
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
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Sahne ışığı efekti
          // AnimatedAlign(
          //   alignment: Alignment(
          //     (bottomProvider.currentIndex - 1) * 0.7, 0,
          //   ),
          //   duration: const Duration(milliseconds: 300),
          //   curve: Curves.easeOut,
          //   child: Container(
          //     margin: const EdgeInsets.only(bottom: 12),
          //     width: 60,
          //     height: 60,
          //     decoration: BoxDecoration(
          //       shape: BoxShape.circle,
          //       color: Colors.white.withOpacity(0.2),
          //       boxShadow: [
          //         BoxShadow(
          //           color: Colors.white.withOpacity(0.5),
          //           blurRadius: 30,
          //           spreadRadius: 3,
          //         ),
          //       ],
          //     ),
          //   ),
          // ),
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
                      if (index != 1)
                        SvgPicture.asset(
                          items[index].icon,
                          width: selected ? 30 : 24,
                          height: selected ? 30 : 24,
                          color: selected ? AppColors.white : AppColors.gray300,
                        )
                      else
                        Icon(
                          Icons.music_note,
                          size: selected ? 30 : 24,
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