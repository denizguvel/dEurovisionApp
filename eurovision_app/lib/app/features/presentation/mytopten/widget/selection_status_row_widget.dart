import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/widget/counter_box_widget.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/mytopten_provider.dart';

/// Status row displaying the selected year and contestant count.
/// Includes a button to reset the selection.
class SelectionStatusRow extends StatelessWidget {
  final int selectedYear;
  final int selectedCount;

  const SelectionStatusRow({
    super.key,
    required this.selectedYear,
    required this.selectedCount,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CounterBox(
          icon: Icons.calendar_today,
          text: selectedYear.toString(),
        ),
        const SizedBox(width: 8),
        CounterBox(
          icon: Icons.star,
          text: "$selectedCount/10",
        ),
        const SizedBox(width: 8),
        IconButton(
          icon: const Icon(Icons.delete, color: Colors.white),
          tooltip: 'Reset',
          onPressed: () {
            context.read<MyTop10Provider>().resetSelection();
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text(AppStrings.refreshMyTop10)),
            );
          },
        ),
      ],
    );
  }
}