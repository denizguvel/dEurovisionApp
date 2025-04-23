import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/view/my_top_ten_imports.dart';
import 'package:eurovision_app/app/features/presentation/search_video/widget/videoplayer_widget.dart';
import 'package:eurovision_app/app/features/presentation/search_video/widget/yearbottomsheet_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/video_provider.dart';

/// A widget that represents the Video view of the app.
/// It displays a list of videos for a selected year and allows the user to pick a year.
class VideoView extends StatelessWidget {
  const VideoView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VideoProvider>();

    return Column(
      children: [
        // Search bar
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            controller: provider.searchController,
            style: const TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search artist...',
              hintStyle: const TextStyle(color: Colors.grey),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              suffixIcon: IconButton(
                icon: const Icon(Icons.clear, color: Colors.grey),
                onPressed: provider.clearSearch,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
            onChanged: provider.onSearchChanged,
          ),
        ),

        // Year Picker
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: GestureDetector(
            onTap: () async {
              if (provider.availableYears.isEmpty) {
                await provider.loadAvailableYears();
              }
              _showYearPicker(context, provider);
            },
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(provider.selectedYear.toString(),
                      style: const TextStyle(color: Colors.white)),
                  const Icon(Icons.arrow_drop_down, color: Colors.white),
                ],
              ),
            ),
          ),
        ),

        // Video List
        Expanded(
          child: provider.items.isEmpty && provider.isLoading
              ? const Center(child: LoadingIndicator())
              : provider.items.isEmpty
                  ? const Center(
                      child: Text("No videos found for this artist.",
                          style: TextStyle(color: Colors.white)))
                  : ListView.builder(
                      controller: provider.scrollController,
                      padding: const EdgeInsets.all(16),
                      itemCount: provider.items.length +
                          (provider.hasMore ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == provider.items.length) {
                          return const Padding(
                            padding: EdgeInsets.all(12),
                            child: Center(child: LoadingIndicator()),
                          );
                        }

                        final contestant = provider.items[index];
                        final controller =
                            provider.controllers[contestant.id];

                        return Card(
                          shadowColor: AppColors.black,
                          color: Colors.transparent,
                          elevation: 12,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: const BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("${contestant.artist} - ${contestant.song}",
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.white)),
                                Text("Country: ${contestant.country}",
                                    style:
                                        const TextStyle(color: AppColors.white)),
                                const SizedBox(height: 12),
                                if (controller != null)
                                  YoutubePlayerWidget(controller: controller),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
        ),
      ],
    );
  }

  void _showYearPicker(BuildContext context, VideoProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => YearBottomSheet(
        selectedYear: provider.selectedYear,
        availableYears: provider.availableYears,
        onYearSelected: provider.updateYear,
      ),
    );
  }
}