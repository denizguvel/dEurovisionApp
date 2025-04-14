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
    return DropdownButton<int>(
      iconEnabledColor: Colors.red,
      iconDisabledColor: Colors.grey,
      dropdownColor: AppColors.palePink,
      value: selectedYear,
      isExpanded: true,
      icon: const Icon(Icons.arrow_drop_down),
      items: yearList
          .map((year) => DropdownMenuItem(
                value: year,
                child: Text('$year'),
              ))
          .toList(),
      onChanged: onChanged,
    );
  }
}