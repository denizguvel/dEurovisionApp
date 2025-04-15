import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/selected_top_ten_provider.dart';

class Top10Counter extends StatelessWidget {
  const Top10Counter({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCount = context.watch<SelectedTop10Provider>().selected.length;

    return Positioned(
      top: 50,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '$selectedCount/10',
          style: const TextStyle(color: AppColors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}