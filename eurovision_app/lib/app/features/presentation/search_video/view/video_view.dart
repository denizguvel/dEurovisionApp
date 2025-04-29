import 'package:eurovision_app/app/features/presentation/mytopten/view/my_top_ten_imports.dart';
import 'package:eurovision_app/app/features/presentation/search_video/provider/video_provider.dart';
import 'package:eurovision_app/app/features/presentation/search_video/widget/searchbar_widget.dart';
import 'package:eurovision_app/app/features/presentation/search_video/widget/videolist_widget.dart';
import 'package:eurovision_app/app/features/presentation/search_video/widget/yearbottomsheet_widget.dart';

/// VideoView is the main screen for displaying Eurovision videos.
/// It contains a search bar, year picker, and a tab-based layout for all videos and favorites.
class VideoView extends StatelessWidget {
  const VideoView({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VideoProvider>();

    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                const SearchBarWidget(),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () async {
                    if (provider.availableYears.isEmpty) {
                      await provider.loadAvailableYears();
                    }
                    _showYearPicker(context, provider);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.gray),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Text(
                          provider.selectedYear.toString(),
                          style: const TextStyle(color: AppColors.white),
                        ),
                        const Icon(Icons.arrow_drop_down, color: AppColors.white),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const TabBar(
            labelColor: AppColors.pinkyPink,
            unselectedLabelColor: AppColors.white,
            indicatorColor: AppColors.pinkyPink,
            tabs: [
              Tab(text: AppStrings.allVideos),
              Tab(text: AppStrings.favorites),
            ],
          ),
          const Expanded(
            child: TabBarView(
              children: [
                VideoListWidget(isFavorites: false),
                VideoListWidget(isFavorites: true),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showYearPicker(BuildContext context, VideoProvider provider) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.transparent,
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