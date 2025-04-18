import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/allcontestant_provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/selected_top_ten_provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/widget/contestant_card_widget.dart';

class ContestantGrid extends StatelessWidget {
  final void Function(BuildContext context, ContestantModel contestant, LongPressStartDetails details) onLongPressStart;
  final VoidCallback onLongPressEnd;

  const ContestantGrid({
    super.key,
    required this.onLongPressStart,
    required this.onLongPressEnd,
  });

  @override
  Widget build(BuildContext context) {
    final allContestants = context.watch<AllContestantsProvider>().items;
    final selectedTop10 = context.watch<SelectedTop10Provider>().selected;

    return LayoutBuilder(
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
    );
  }
}