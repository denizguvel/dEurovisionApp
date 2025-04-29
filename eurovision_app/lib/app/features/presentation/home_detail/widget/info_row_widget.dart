import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';

/// A row widget that displays a label-value pair.
/// Useful for presenting data in profile or info cards.
class InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final TextStyle? labelStyle;
  final TextStyle? valueStyle;

  const InfoRow({
    super.key,
    required this.label,
    required this.value,
    this.labelStyle,
    this.valueStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.white)
                  .merge(labelStyle),
            ),
          ),
          Expanded(
            child: Text(value, style: TextStyle(color: AppColors.white),),
          ),
        ],
      ),
    );
  }
}