import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/feature_provider.dart';
import 'package:eurovision_app/core/constants/page_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';

/// Widget for displaying a contestant in a list item format.
/// Shows rank, flag, artist, and song; navigates to detail page on tap.
class ContestantListItem extends StatelessWidget {
  final ContestantModel contestant;
  final int index;

  const ContestantListItem({
    super.key,
    required this.contestant,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final iconPath = context.read<FeatureProvider>().getIconPath(contestant.country);

    return GestureDetector(
      onTap: () {
        Provider.of<FeatureProvider>(context, listen: false).goToContestantDetail(
          PageType.contestantDetail,
          contestant.id,
          contestant.year,
        );
      },
      child: Container(
        padding: EdgeInsets.all(screenWidth * 0.02),
        child: Row(
          children: [
            SizedBox(
              width: screenWidth * 0.12,
              height: screenWidth * 0.12,
              child: Text(
                '${index + 1}.',
                style: TextStyle(
                  color: AppColors.white,
                  fontSize: screenWidth * 0.04,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: screenWidth * 0.12,
              height: screenWidth * 0.12,
              margin: EdgeInsets.only(right: screenWidth * 0.04),
              child: SvgPicture.asset(
                iconPath,
                width: screenWidth * 0.12,
                height: screenWidth * 0.12,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: screenWidth * 0.01),
                  Text(
                    contestant.artist,
                    style: TextStyle(fontSize: screenWidth * 0.04, color: AppColors.white),
                  ),
                  SizedBox(height: screenWidth * 0.01),
                  Text(
                    contestant.song,
                    style: TextStyle(fontSize: screenWidth * 0.03, color: AppColors.white70),
                  ),
                  const Divider()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}