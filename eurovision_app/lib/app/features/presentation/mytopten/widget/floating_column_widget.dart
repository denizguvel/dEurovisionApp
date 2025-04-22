import 'package:eurovision_app/app/features/presentation/mytopten/provider/mytopten_provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/widget/share_preview_modal_widget.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/widget/theme_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/common/constants/app_colors.dart';

/// A vertical menu with floating buttons for theme selection and sharing.
/// Provides actions for customization and sharing in the My Top 10 screen.
class ShareThemeColumn extends StatelessWidget {
  const ShareThemeColumn({super.key});

  @override
  Widget build(BuildContext context) {
    final repaintKey = context.read<MyTop10Provider>().repaintKey;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        FloatingActionButton(
          heroTag: 'themeBtn',
          backgroundColor: AppColors.white70,
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (_) => const ThemePickerBottomSheet(),
          ),
          child: const Icon(Icons.palette, color: AppColors.pinkyPink),
        ),
        const SizedBox(height: 12),
        FloatingActionButton(
          heroTag: 'shareBtn',
          backgroundColor: AppColors.white70,
          onPressed: () => showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).padding.top + 40),
                child: SharePreviewModal(repaintKey: repaintKey),
              ),
            ),
          ),
          child: const Icon(Icons.share, color: AppColors.pinkyPink),
        ),
      ],
    );
  }
}