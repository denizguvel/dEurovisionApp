import 'package:flutter/material.dart';
import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';

/// Card widget that displays contestant information.
/// Highlights selection state and supports tap and long-press interactions.
class ContestantCard extends StatelessWidget {
  final ContestantModel contestant;
  final bool isSelected;
  final VoidCallback onTap;
  final void Function(LongPressStartDetails) onLongPressStart;
  final VoidCallback onLongPressEnd;

  const ContestantCard({
    super.key,
    required this.contestant,
    required this.isSelected,
    required this.onTap,
    required this.onLongPressStart,
    required this.onLongPressEnd,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onLongPressStart: onLongPressStart,
      onLongPressEnd: (_) => onLongPressEnd(),
      child: Card(
        elevation: 2,
        color: isSelected ? AppColors.pinkyPink : AppColors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      contestant.artist,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isSelected ? AppColors.white : AppColors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      contestant.song,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isSelected ? AppColors.white70 : AppColors.gray700,
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(Icons.check_circle, color: AppColors.white),
            ],
          ),
        ),
      ),
    );
  }
}