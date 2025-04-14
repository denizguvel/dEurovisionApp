import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/contestant/allcontestant_provider.dart';

class ContestLocationText extends StatelessWidget {
  const ContestLocationText({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AllContestantsProvider>(
      builder: (context, provider, _) {
        final detail = provider.contestDetails;
        if (detail == null) return const SizedBox();
        return Text(
          '${detail.city}, ${detail.country} - ${detail.arena}',
          style: const TextStyle(fontSize: 12, color: AppColors.gray),
        );
      },
    );
  }
}