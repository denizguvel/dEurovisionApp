import 'package:eurovision_app/app/features/presentation/mytopten/view/my_top_ten_imports.dart';

class SelectionView extends StatelessWidget {
  final int selectedYear;
  final ValueChanged<int?> onYearChanged;
  final void Function(BuildContext context, ContestantModel contestant, LongPressStartDetails details) onLongPressStart;
  final VoidCallback onLongPressEnd;
  final VoidCallback onNext;

  const SelectionView({
    super.key,
    required this.selectedYear,
    required this.onYearChanged,
    required this.onLongPressStart,
    required this.onLongPressEnd,
    required this.onNext,
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
        Positioned(
          top: 5,
          left: 20,
          right: 20,
          child: SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(AppStrings.selectYear,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    YearSelector(
                      selectedYear: selectedYear,
                      onChanged: onYearChanged,
                      yearList: years,
                    ),
                    const SizedBox(height: 6),
                  ],
                ),
              ],
            ),
          ),
        ),
        const Top10Counter(),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: ContestantGrid(
            onLongPressStart: onLongPressStart,
            onLongPressEnd: onLongPressEnd,
          ),
        ),
        if (selectedTop10.length == 10)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              focusElevation: 10,
              hoverColor: AppColors.pinkyPink,
              backgroundColor: AppColors.crimson,
              onPressed: onNext,
              child: const Icon(Icons.arrow_forward, color: AppColors.white),
            ),
          ),
      ],
    );
  }
}