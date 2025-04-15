import 'package:eurovision_app/app/features/presentation/test/provider/contest/contest_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/my_top_ten/contestant_card_widget.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/my_top_ten/top_ten_counter.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/my_top_ten/year_selector_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/contestant/allcontestant_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/selected_top_ten_provider.dart';

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
    final allContestants = context.watch<AllContestantsProvider>().items;
    final selectedTop10 = context.watch<SelectedTop10Provider>().selected;
    final years = context.watch<ContestProvider>().availableYears;

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.topCenter,
      children: [
        Positioned(
          top: -10,
          left: 20,
          right: 20,
          child: SizedBox(
            width: 160,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6),
                YearSelector(
                  selectedYear: selectedYear,
                  onChanged: onYearChanged,
                  yearList: years,
                ),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
        const Top10Counter(),
        Padding(
          padding: const EdgeInsets.only(top: 100),
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 600;
              return GridView.builder(
                padding: const EdgeInsets.all(12),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: isWide ? 3.5 : 2.6,
                ),
                itemCount: allContestants.length,
                itemBuilder: (context, index) {
                  final contestant = allContestants[index];
                  final isSelected = selectedTop10.contains(contestant);
                  return ContestantCard(
                    contestant: contestant,
                    isSelected: isSelected,
                    onTap: () => context.read<SelectedTop10Provider>().toggle(contestant),
                    onLongPressStart: (details) => onLongPressStart(context, contestant, details),
                    onLongPressEnd: onLongPressEnd,
                  );
                },
              );
            },
          ),
        ),
        if (selectedTop10.length == 10)
          Positioned(
            bottom: 16,
            right: 16,
            child: FloatingActionButton(
              onPressed: onNext,
              child: const Icon(Icons.arrow_forward),
            ),
          ),
      ],
    );
  }
}