import 'package:eurovision_app/app/features/presentation/mytopten/view/my_top_ten_imports.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/widget/selection_status_row_widget.dart';

/// A widget that represents the selection view of the app.
/// It displays a grid of contestants and allows the user to select a year.
class SelectionView extends StatelessWidget {
  final int selectedYear;
  final ValueChanged<int?> onYearChanged;
  final void Function(BuildContext context, ContestantModel contestant, LongPressStartDetails details) onLongPressStart;
  final VoidCallback onLongPressEnd;
  final VoidCallback onNext;
  final GlobalKey yearButtonKey;
  final GlobalKey counterKey;
  final GlobalKey nextButtonKey;

  const SelectionView({
    super.key,
    required this.selectedYear,
    required this.onYearChanged,
    required this.onLongPressStart,
    required this.onLongPressEnd,
    required this.onNext,
    required this.yearButtonKey,
    required this.counterKey,
    required this.nextButtonKey,
  });

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<MyTop10Provider>();
    final selectedTop10 = viewModel.selectedTop10;
    final years = viewModel.availableYears;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        // Header and controls
        Positioned(
          top: 5,
          left: 0,
          right: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  children: [
                    const Icon(Icons.star, color: AppColors.pinkyPink),
                    const SizedBox(width: 8),
                    Text(
                      AppStrings.mytop10,
                      style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Counter + Controls
                Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 12,
                  runSpacing: 12,
                  children: [ Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Showcase(
                        key: yearButtonKey,
                        description: AppStrings.showCaseYear,
                        child: YearSelectButton(
                          years: years,
                          selectedYear: selectedYear,
                          onYearChanged: onYearChanged,
                        ),
                      ),
                     Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Showcase(
                              key: counterKey,
                              description: AppStrings.showCaseCounter,
                              child: SelectionStatusRow(
                                selectedYear: selectedYear,
                                selectedCount: selectedTop10.length,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  ]
                )
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 130),
          child: ContestantGrid(
            onLongPressStart: onLongPressStart,
            onLongPressEnd: onLongPressEnd,
          ),
        ),
        if (selectedTop10.length == 10)
          Positioned(
            bottom: 16,
            right: 16,
            child: Showcase(
              key: nextButtonKey,
              description: AppStrings.showCaseNext,
              child: FloatingActionButton(
                focusElevation: 10,
                hoverColor: AppColors.white,
                backgroundColor: AppColors.pinkyPink,
                onPressed: onNext,
                child: const Icon(Icons.arrow_forward, color: AppColors.white),
              ),
            ),
          ),
      ],
    );
  }
}