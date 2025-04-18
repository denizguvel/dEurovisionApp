import 'package:eurovision_app/app/features/presentation/mytopten/view/my_top_ten_imports.dart';

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
      final viewModel = context.read<MyTop10Provider>();
      viewModel.init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyTop10Provider>();
  
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
                    viewModel.onYearChanged(year),
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
            child: ShareThemeColumn(),
          ),
          if (!viewModel.showSecondPage)
          Positioned(
            top: 45,
            left: 20,
            child: FloatingActionButton.small(
              heroTag: 'resetFAB',
              backgroundColor: AppColors.white,
              onPressed: () {
                viewModel.resetSelection();
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