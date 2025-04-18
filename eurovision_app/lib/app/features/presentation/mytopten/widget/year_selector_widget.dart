import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

class YearSelector extends StatelessWidget {
  final int selectedYear;
  final ValueChanged<int?> onChanged;
  final List<int> yearList;

  const YearSelector({
    super.key,
    required this.selectedYear,
    required this.onChanged,
    required this.yearList,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.coralRed,
        elevation: 6,
        shadowColor: Colors.black.withOpacity(0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      ),
      onPressed: () {
        showModalBottomSheet(
          context: context,
          backgroundColor: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (BuildContext context) {
            return ListView(
              padding: const EdgeInsets.symmetric(vertical: 12),
              children: yearList.map((year) {
                final isSelected = year == selectedYear;
                return ListTile(
                  title: Text(
                    '$year',
                    style: TextStyle(
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? AppColors.coralRed : Colors.black,
                    ),
                  ),
                  trailing: isSelected
                      ? const Icon(Icons.check, color: AppColors.coralRed)
                      : null,
                  onTap: () {
                    onChanged(year);
                    Navigator.pop(context);
                  },
                );
              }).toList(),
            );
          },
        );
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            '$selectedYear',
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
          const SizedBox(width: 8),
          const Icon(Icons.expand_more, color: Colors.white),
        ],
      ),
    );
  }
}