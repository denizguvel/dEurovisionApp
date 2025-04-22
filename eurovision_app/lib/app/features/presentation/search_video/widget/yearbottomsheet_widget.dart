import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Bottom sheet widget for year selection by the user.
/// Highlights the selected year and closes upon selection.
class YearBottomSheet extends StatelessWidget {
  final int selectedYear;
  final List<int> availableYears;
  final Function(int year) onYearSelected;

  const YearBottomSheet({
    super.key,
    required this.selectedYear,
    required this.availableYears,
    required this.onYearSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: ListView(
        shrinkWrap: true,
        children: availableYears.map((year) {
          final isSelected = year == selectedYear;
          return ListTile(
            title: Text(
              year.toString(),
              style: TextStyle(
                color: isSelected ? AppColors.pinkyPink : Colors.white,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
            trailing: isSelected ? const Icon(Icons.check, color: AppColors.pinkyPink ) : null,
            onTap: () {
              onYearSelected(year);
              Navigator.pop(context);
            },
          );
        }).toList(),
      ),
    );
  }
}