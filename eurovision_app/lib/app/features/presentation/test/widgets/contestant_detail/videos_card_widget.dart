import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/contestant_detail/contestant_video_widget.dart';
import 'package:flutter/material.dart';
import 'package:eurovision_app/app/features/data/models/contestant_detail_model.dart';
import 'package:eurovision_app/app/common/constants/app_colors.dart';

class VideosCardWidget extends StatelessWidget {
  final ContestantDetailModel data;

  const VideosCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.videoUrls.isEmpty || data.videoUrls[0].isEmpty) {
      return const SizedBox();
    }

    final videoUrl = data.videoUrls[0];

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            AppStrings.officialVideo,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.crimson,
            ),
          ),
          const Divider(),
          ClipRRect(
              borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: ContestantVideoPlayer(videoUrl: videoUrl),
            ),
          ),
        ],
      ),
    );
  }
}