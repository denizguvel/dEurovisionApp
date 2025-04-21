import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/feature_provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/mytopten_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SharePreviewModal extends StatelessWidget {
  final GlobalKey repaintKey;

  const SharePreviewModal({super.key, required this.repaintKey});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyTop10Provider>();
    final selectedTop10 = viewModel.selectedTop10;
    final countryMap = context.read<CountryScoreProvider>().countryCodeNameMap;

    return Container(
      color: viewModel.backgroundColor,
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RepaintBoundary(
            key: repaintKey,
            child: Container(
              width: double.infinity,
              color: viewModel.backgroundColor,
              padding: const EdgeInsets.all(16),
              child: SingleChildScrollView(
                child: Column(
                  children: selectedTop10.asMap().entries.map((entry) {
                    final i = entry.key;
                    final contestant = entry.value;
                    return ListTile(
                      leading: Text('${i + 1}', style: viewModel.titleFontStyle),
                      title: Text(contestant.artist, style: viewModel.titleFontStyle),
                      subtitle: Text(contestant.song, style: viewModel.subTitleFontStyle),
                      trailing: Text(
                        countryMap[contestant.country] ?? contestant.country,
                        style: viewModel.trailingFontStyle,
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton.icon(
            onPressed: viewModel.captureAndShare,
            icon: const Icon(Icons.share, color: AppColors.white),
            label: const Text(AppStrings.share),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.pinkyPink,
              foregroundColor: AppColors.white,
            ),
          )
        ],
      ),
    );
  }
}
