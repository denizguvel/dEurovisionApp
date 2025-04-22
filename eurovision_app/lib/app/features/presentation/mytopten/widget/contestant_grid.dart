import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/mytopten_provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/widget/contestant_card_widget.dart';

/// Widget that displays contestants in a grid layout.
/// Supports selection and long-press interactions.
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
    final viewModel = context.watch<MyTop10Provider>();
    final allContestants = viewModel.allContestants;
    final selectedTop10 = viewModel.selectedTop10;

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
              onTap: () => context.read<MyTop10Provider>().toggleContestant(contestant),
              onLongPressStart: (details) => onLongPressStart(context, contestant, details),
              onLongPressEnd: onLongPressEnd,
            );
          },
        );
      },
    );
  }
}