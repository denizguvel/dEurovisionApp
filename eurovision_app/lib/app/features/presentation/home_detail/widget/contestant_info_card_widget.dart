import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/feature_provider.dart';
import 'package:eurovision_app/app/features/presentation/home_detail/widget/info_row_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContestantInfoCardWidget extends StatelessWidget {
  final String artist;
  final String song;
  final String country;
  final int year;
  final List<String> writers;
  const ContestantInfoCardWidget({super.key,required this.artist,
    required this.song,
    required this.country,
    required this.year,
    required this.writers,});

  @override
  Widget build(BuildContext context) {
    final countryNameMap = context.read<CountryScoreProvider>().countryCodeNameMap;
    return Card(
      color: Colors.transparent,
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16),side: BorderSide(color: Colors.grey, width: 1.0,),),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.artistCardTitle,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.pinkyPink,
              ),
            ),
            const Divider(),
            InfoRow(label: AppStrings.artist, value: artist, labelStyle: const TextStyle(color: Colors.white), valueStyle: const TextStyle(color: Colors.white),),
            InfoRow(label: AppStrings.song, value: song),
            InfoRow(label: AppStrings.country, value:  countryNameMap[country] ?? country,),
            InfoRow(label: AppStrings.year, value: year.toString()),
            InfoRow(label: AppStrings.writers, value: writers.join(", ")),
          ],
        ),
      ),
    );
  }
}