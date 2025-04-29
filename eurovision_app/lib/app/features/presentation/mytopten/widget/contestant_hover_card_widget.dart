import 'package:flutter/material.dart';
import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';

/// A compact hover card shown on long press.
/// Displays artist, song, and country name.
class ContestantHoverCard extends StatelessWidget {
  final ContestantModel contestant;
  final String countryName;

  const ContestantHoverCard({
    super.key,
    required this.contestant,
    required this.countryName,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColors.black,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.white.withOpacity(0.2)),
          boxShadow: [
            BoxShadow(
              color: AppColors.black.withOpacity(0.5),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              contestant.artist,
              style: const TextStyle(color: AppColors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              contestant.song,
              style: const TextStyle(color: AppColors.white70, fontSize: 14),
            ),
            const SizedBox(height: 4),
            Text(
              countryName,
              style: const TextStyle(color: AppColors.white60),
            ),
          ],
        ),
      ),
    );
  }
}