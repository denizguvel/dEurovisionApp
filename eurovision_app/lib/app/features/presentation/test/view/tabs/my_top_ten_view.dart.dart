import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/common/widgets/loading_indicator/loading_indicator.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/my_top_ten_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/view/details/selection_view.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/my_top_ten/final_ranking_widget.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/my_top_ten/share_preview_modal_widget.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/theme_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTop10View extends StatefulWidget {
  const MyTop10View({super.key});

  @override
  State<MyTop10View> createState() => _MyTop10ViewState();
}

class _MyTop10ViewState extends State<MyTop10View> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final viewModel = context.read<MyTopTenProvider>();
      viewModel.init(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyTopTenProvider>();
  
    return Stack(
      children: [
        viewModel.showSecondPage
        ? Padding(
            padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 55),
            child: FinalRankingView(
                screenshotController: viewModel.screenshotController,
              ),
          )
            : SelectionView(
                selectedYear: viewModel.selectedYear,
                onYearChanged: (year) =>
                    viewModel.onYearChanged(context, year),
                onLongPressStart: viewModel.onLongPressStart,
                onLongPressEnd: viewModel.onLongPressEnd,
                onNext: () => viewModel.setShowSecondPage(true),
              ),
        if (viewModel.showSecondPage)
        Positioned(
          top: 3,
          left: 16,
          child: FloatingActionButton.small(
            heroTag: 'backBtn',
            backgroundColor: AppColors.white70,
            onPressed: () => viewModel.setShowSecondPage(false),
            child: const Icon(Icons.arrow_back, color: AppColors.crimson1,),
          ),
        ),
        if (viewModel.showSecondPage)
          Positioned(
            bottom: 20,
            right: 20,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: 'themeBtn',
                  backgroundColor: AppColors.white70,
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (_) => const ThemePickerBottomSheet(),
                  ),
                  child: const Icon(Icons.palette, color: AppColors.crimson1,),
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
                        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top + 40),
                        child: SharePreviewModal(
                          repaintKey: context.read<MyTopTenProvider>().repaintKey,
                        ),
                      ),
                    ),
                  ),
                  child: const Icon(Icons.share, color: AppColors.crimson1,),
                ),
              ],
            ),
          ),
          if (!viewModel.showSecondPage)
          Positioned(
            top: 45,
            left: 20,
            child: FloatingActionButton.small(
              heroTag: 'resetFAB',
              backgroundColor: AppColors.white70,
              onPressed: () {
                viewModel.resetSelection(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text(AppStrings.refreshMyTop10)),
                );
              },
              child: const Icon(Icons.refresh, color: AppColors.crimson1),
            ),
          ),
        if (viewModel.isLoading)
        Positioned.fill(
          child: Container(
            color: Colors.black.withOpacity(0.3),
            child: const Center(
              child: LoadingIndicator(),
            ),
          ),
        ),
      ],
    );
  }
}