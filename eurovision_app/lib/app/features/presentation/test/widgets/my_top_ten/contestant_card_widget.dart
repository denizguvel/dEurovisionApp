import 'package:flutter/material.dart';
import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';

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
        color: isSelected ? AppColors.crimson : Colors.white,
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
                        color: isSelected ? Colors.white : Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      contestant.song,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isSelected ? Colors.white70 : Colors.grey[700],
                      ),
                    ),
                  ],
                ),
              ),
              if (isSelected)
                const Icon(Icons.check_circle, color: Colors.white),
            ],
          ),
        ),
      ),
    );
  }
}