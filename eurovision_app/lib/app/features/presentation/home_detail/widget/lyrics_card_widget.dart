import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:eurovision_app/app/features/data/models/contestant_detail_model.dart';
import 'package:eurovision_app/app/common/constants/app_colors.dart';

class LyricsCardWidget extends StatelessWidget {
  final ContestantDetailModel data;

  const LyricsCardWidget({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final englishLyrics = data.lyrics
        .where((lyric) => lyric.languages.contains("English"))
        .map((lyric) => "${lyric.title.isNotEmpty ? "${lyric.title}\n" : ""}${lyric.content}")
        .join("\n\n");

    if (englishLyrics.trim().isEmpty) {
      return const SizedBox();
    }
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.lyrics,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.crimson,
              ),
            ),
            const Divider(),
            Text(
              englishLyrics,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}