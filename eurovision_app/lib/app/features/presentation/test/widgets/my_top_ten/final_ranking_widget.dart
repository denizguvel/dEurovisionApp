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

    return Screenshot(
      controller: screenshotController,
      child: Container(
        color: theme.backgroundColor,
        padding: const EdgeInsets.all(16),
        child: ReorderableListView(
          onReorder: context.read<SelectedTop10Provider>().reorder,
          children: [
            for (int i = 0; i < selectedTop10.length; i++)
              ListTile(
                key: ValueKey(selectedTop10[i].id),
                leading: Text('${i + 1}', style: theme.fontStyle),
                title: Text(selectedTop10[i].artist, style: theme.fontStyle),
                subtitle: Text(selectedTop10[i].song, style: theme.fontStyle),
                trailing: Text(selectedTop10[i].country, style: theme.fontStyle),
              ),
          ],
        ),
      ),
    );
  }
}