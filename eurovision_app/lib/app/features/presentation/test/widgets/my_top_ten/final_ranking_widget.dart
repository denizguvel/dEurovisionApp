import 'package:eurovision_app/app/features/presentation/test/provider/country/country_name_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';

import 'package:eurovision_app/app/features/presentation/test/provider/frame_theme_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/selected_top_ten_provider.dart';

class FinalRankingView extends StatelessWidget {
  final ScreenshotController screenshotController;

  const FinalRankingView({super.key, required this.screenshotController});

  @override
  Widget build(BuildContext context) {
    final selectedTop10 = context.watch<SelectedTop10Provider>().selected;
    final theme = context.watch<FrameThemeProvider>();
    final countryMap = context.read<CountryScoreProvider>().countryCodeNameMap;

    return Screenshot(
      controller: screenshotController,
      child: Container(
        color: theme.backgroundColor,
        padding: const EdgeInsets.all(16),
        child: ReorderableListView(
          shrinkWrap: true,
          onReorder: context.read<SelectedTop10Provider>().reorder,
          children: [
            for (int i = 0; i < selectedTop10.length; i++)
              ListTile(
                key: ValueKey(selectedTop10[i].id),
                leading: Text('${i + 1}', style: theme.titleFontStyle),
                title: Text(selectedTop10[i].artist, style: theme.titleFontStyle),
                subtitle: Text(selectedTop10[i].song, style: theme.subTitleFontStyle),
                trailing: Text(
                  countryMap[selectedTop10[i].country] ?? selectedTop10[i].country,
                  style: theme.trailingFontStyle, 
                ),
              ),
          ],
        ),
      ),
    );
  }
}