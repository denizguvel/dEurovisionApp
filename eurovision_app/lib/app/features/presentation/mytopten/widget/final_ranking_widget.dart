import 'package:eurovision_app/app/features/presentation/feature/provider/country_name_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/mytopten_provider.dart';

class FinalRankingView extends StatelessWidget {
  final ScreenshotController screenshotController;

  const FinalRankingView({super.key, required this.screenshotController});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyTop10Provider>();
    final selectedTop10 = viewModel.selectedTop10;
    final countryMap = context.read<CountryScoreProvider>().countryCodeNameMap;

    return Screenshot(
      controller: screenshotController,
      child: Container(
        color: viewModel.backgroundColor,
        padding: const EdgeInsets.all(16),
        child: ReorderableListView(
          shrinkWrap: true,
          onReorder: viewModel.reorder,
          children: [
            for (int i = 0; i < selectedTop10.length; i++)
              ListTile(
                key: ValueKey(selectedTop10[i].id),
                leading: Text('${i + 1}', style: viewModel.titleFontStyle),
                title: Text(selectedTop10[i].artist, style: viewModel.titleFontStyle),
                subtitle: Text(selectedTop10[i].song, style: viewModel.subTitleFontStyle),
                trailing: Text(
                  countryMap[selectedTop10[i].country] ?? selectedTop10[i].country,
                  style: viewModel.trailingFontStyle,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
