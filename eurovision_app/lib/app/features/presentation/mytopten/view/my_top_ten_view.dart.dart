import 'package:eurovision_app/app/features/presentation/mytopten/view/my_top_ten_imports.dart';

class MyTop10View extends StatefulWidget {
  const MyTop10View({super.key});

  @override
  State<MyTop10View> createState() => _MyTop10ViewState();
}

class _MyTop10ViewState extends State<MyTop10View> {
  final GlobalKey _yearButtonKey = GlobalKey();
  final GlobalKey _counterKey = GlobalKey();
  final GlobalKey _nextButtonKey = GlobalKey();
  late BuildContext showcaseContext;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyTop10Provider>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyTop10Provider>();

    return ShowCaseWidget(
      builder: (context) {
        showcaseContext = context;
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (viewModel.pendingOnboarding && !viewModel.hasSeenOnboarding) {
            final showcase = ShowCaseWidget.of(showcaseContext);
            showcase.startShowCase([
              _yearButtonKey,
              _counterKey,
              _nextButtonKey,
            ]);
            viewModel.setOnboardingSeen(true);
            viewModel.setPendingOnboarding(false);
          }
        });
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
                    onYearChanged: (year) => viewModel.onYearChanged(year),
                    onLongPressStart: viewModel.onLongPressStart,
                    onLongPressEnd: viewModel.onLongPressEnd,
                    onNext: () => viewModel.setShowSecondPage(true),
                    yearButtonKey: _yearButtonKey,
                    counterKey: _counterKey,
                    nextButtonKey: _nextButtonKey,
                  ),
            if (viewModel.showSecondPage)
              Positioned(
                top: 25,
                left: 16,
                child: FloatingActionButton.small(
                  heroTag: 'backBtn',
                  backgroundColor: AppColors.pinkyPink,
                  onPressed: () => viewModel.setShowSecondPage(false),
                  child: const Icon(Icons.arrow_back, color: AppColors.white),
                ),
              ),
            if (viewModel.showSecondPage)
              const Positioned(
                bottom: 20,
                right: 20,
                child: ShareThemeColumn(),
              ),
            if (viewModel.isLoading)
              Positioned.fill(
                child: Container(
                  color: AppColors.black.withOpacity(0.3),
                  child: const Center(child: LoadingIndicator()),
                ),
              ),
          ],
        );
      },
    );
  }
}