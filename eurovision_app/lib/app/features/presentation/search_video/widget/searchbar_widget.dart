import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/search_video/provider/video_provider.dart';

/// A reusable search bar widget used in the VideoView screen for artist search.
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VideoProvider>();
    final hasText = provider.searchController.text.isNotEmpty;

    return Expanded(
      child: TextField(
        controller: provider.searchController,
        style: const TextStyle(color: AppColors.white), 
        decoration: InputDecoration(
          hintText: AppStrings.searchArtist,
          hintStyle: const TextStyle(color: AppColors.gray),
          prefixIcon: const Icon(Icons.search, color: AppColors.gray),
          suffixIcon: hasText 
              ? IconButton(
                  icon: const Icon(Icons.clear, color: AppColors.gray),
                  onPressed: provider.clearSearch,
                )
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.gray),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.gray),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.pinkyPink, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        onChanged: (value) {
          provider.onSearchChanged(value);
        },
      ),
    );
  }
}