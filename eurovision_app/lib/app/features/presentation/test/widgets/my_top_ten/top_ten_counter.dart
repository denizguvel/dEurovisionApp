import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/selected_top_ten_provider.dart';

class Top10Counter extends StatelessWidget {
  const Top10Counter({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCount = context.watch<SelectedTop10Provider>().selected.length;

    return Positioned(
      top: 12,
      right: 20,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.7),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          '$selectedCount/10',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}