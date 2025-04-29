import 'package:eurovision_app/app/features/presentation/mytopten/view/my_top_ten_imports.dart';
import 'package:eurovision_app/app/features/presentation/search_video/provider/video_provider.dart';
import 'package:eurovision_app/app/features/presentation/search_video/widget/videoplayer_widget.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/feature_provider.dart';

/// A widget that displays a list of all or favorite Eurovision videos 
/// based on the isFavorites flag. Uses YoutubePlayerController for video playback.
class VideoListWidget extends StatelessWidget {
  final bool isFavorites;

  const VideoListWidget({super.key, required this.isFavorites});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<VideoProvider>();
    final list = isFavorites ? provider.filteredFavoriteItems : provider.items;

    if (list.isEmpty && provider.isLoading) {
      return const Center(child: LoadingIndicator());
    }

    if (list.isEmpty) {
      return Center(
        child: Text(
          isFavorites ? AppStrings.noFavorites : AppStrings.noVideos,
          style: const TextStyle(color: AppColors.white),
        ),
      );
    }

    return ListView.builder(
      controller: isFavorites ? null : provider.scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: list.length + (provider.hasMore && !isFavorites ? 1 : 0),
      itemBuilder: (context, index) {
        if (!isFavorites && index == list.length) {
          return const Padding(
            padding: EdgeInsets.all(12),
            child: Center(child: LoadingIndicator()),
          );
        }

        final contestant = list[index];
        final key = '${contestant.year}-${contestant.id}';
        final controller = provider.controllers[key];

        return Card(
          color: AppColors.transparent,
          elevation: 12,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: AppColors.gray, width: 1.0),
          ),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text("${contestant.artist} - ${contestant.song}",
                          style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppColors.white)),
                    ),
                    IconButton(
                      icon: Icon(
                        provider.isFavorite(contestant.year, contestant.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: AppColors.pinkyPink,
                      ),
                      onPressed: () {
                        provider.toggleFavorite(contestant.year, contestant.id);
                      },
                    ),
                  ],
                ),
                Consumer<FeatureProvider>(
                  builder: (context, featureProvider, _) {
                    final countryName = featureProvider.countryCodeNameMap[contestant.country] ?? contestant.country;
                    return Text('${AppStrings.countryText} $countryName', style: const TextStyle(color: AppColors.white));
                  },
                ),
                SizedBox(height: 4),
                Text(
                "${AppStrings.yearText} ${contestant.year}",
                style: const TextStyle(
                  color: AppColors.gray,
                  fontSize: 12,
                ),),
                const SizedBox(height: 12),
                if (controller != null)
                  YoutubePlayerWidget(controller: controller)
                else
                  FutureBuilder(
                    future: provider.fetchContestantDetailAndInitController(contestant.year, contestant.id),
                    builder: (context, snapshot) {
                      final loaded = provider.controllers[key];
                      return loaded != null
                          ? YoutubePlayerWidget(controller: loaded)
                          : const SizedBox(height: 0);
                    },
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}