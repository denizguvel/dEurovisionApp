import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/country/country_name_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/frame_theme_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/my_top_ten_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/selected_top_ten_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SharePreviewModal extends StatelessWidget {
  final GlobalKey repaintKey;

  const SharePreviewModal({super.key, required this.repaintKey});

  @override
  Widget build(BuildContext context) {
    final selectedTop10 = context.watch<SelectedTop10Provider>().selected;
    final theme = context.watch<FrameThemeProvider>();
    final countryMap = context.read<CountryScoreProvider>().countryCodeNameMap;

    return Container(
      color: theme.backgroundColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RepaintBoundary(
            key: repaintKey,
            child: Container(
              width: double.infinity,
            color: theme.backgroundColor,
            padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: selectedTop10.asMap().entries.map((entry) {
                    final i = entry.key;
                    final contestant = entry.value;
                    return ListTile(
                      leading: Text('${i + 1}', style: theme.titleFontStyle),
                      title: Text(contestant.artist, style: theme.titleFontStyle),
                      subtitle: Text(contestant.song, style: theme.subTitleFontStyle),
                      trailing: Text(
                        countryMap[contestant.country] ?? contestant.country,
                        style: theme.trailingFontStyle,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: () => context.read<MyTop10Utils>().captureAndShare(),
            icon: const Icon(Icons.share, color: AppColors.white,),
            label: const Text(AppStrings.share),
            style:ElevatedButton.styleFrom(
                  backgroundColor: AppColors.crimson1,
                  foregroundColor: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}