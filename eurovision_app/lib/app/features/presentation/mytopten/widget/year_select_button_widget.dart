import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// Button with a bottom sheet for selecting a year.
/// Allows the user to choose from available contest years.
class YearSelectButton extends StatelessWidget {
  final List<int> years;
  final int selectedYear;
  final ValueChanged<int?> onYearChanged;

  const YearSelectButton({
    super.key,
    required this.years,
    required this.selectedYear,
    required this.onYearChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      icon: const Icon(Icons.expand_more, color: AppColors.white, size: 18),
      label: const Text(
        'Select Year',
        style: TextStyle(fontSize: 14, color: AppColors.white),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.pinkyPink,
        elevation: 6,
        shadowColor: AppColors.black.withOpacity(0.3),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: AppColors.black,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) {
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: years.map((year) {
                final isSelected = year == selectedYear;
                return ListTile(
                  title: Text(
                    '$year',
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppColors.pinkyPink : AppColors.white,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: AppColors.pinkyPink)
                      : null,
                  onTap: () {
                    onYearChanged(year);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            );
          },
        );
      },
    );
  }
}