import 'package:eurovision_app/app/features/presentation/test/provider/my_top_ten_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/view/details/selection_view.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/my_top_ten/final_ranking_widget.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/theme_picker_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyTop10View extends StatelessWidget {
  const MyTop10View({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyTop10Utils>();
    viewModel.init(context);

    return Scaffold(
      appBar: AppBar(
        leading: viewModel.showSecondPage
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => viewModel.setShowSecondPage(false),
              )
            : null,
        title: const Text("My Top 10"),
      ),
      body: viewModel.showSecondPage
          ? FinalRankingView(screenshotController: viewModel.screenshotController)
          : SelectionView(
              selectedYear: viewModel.selectedYear,
              onYearChanged: (year) => viewModel.onYearChanged(context, year),
              onLongPressStart: viewModel.onLongPressStart,
              onLongPressEnd: viewModel.onLongPressEnd,
              onNext: () => viewModel.setShowSecondPage(true),
            ),
      floatingActionButton: viewModel.showSecondPage
          ? Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FloatingActionButton(
                  heroTag: 'themeBtn',
                  onPressed: () => showModalBottomSheet(
                    context: context,
                    builder: (_) => const ThemePickerBottomSheet(),
                  ),
                  child: const Icon(Icons.palette),
                ),
                const SizedBox(height: 12),
                FloatingActionButton(
                  heroTag: 'shareBtn',
                  onPressed: viewModel.shareAsImage,
                  child: const Icon(Icons.share),
                ),
              ],
            )
          : null,
    );
  }
}