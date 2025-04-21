import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/app/features/presentation/search_video/widget/videoplayer_widget.dart';
import 'package:eurovision_app/app/features/presentation/search_video/widget/yearbottomsheet_widget.dart';
import 'package:eurovision_app/app/features/utils/year_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/video_provider.dart';

class VideoView extends StatefulWidget {
  const VideoView({super.key});

  @override
  State<VideoView> createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  late final VideoProvider _provider;

  @override
  void initState() {
    super.initState();
    _provider = VideoProvider();
    _loadInitialYear();
  }

  Future<void> _loadInitialYear() async {
    final year = YearUtil.getLatestAvailableYear();
    await _provider.updateYear(year);

    if (!mounted) return;
    setState(() {});
  }

  @override
  void dispose() {
    _provider.dispose();
    super.dispose();
  }

  void _showYearPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return YearBottomSheet(
          selectedYear: _provider.selectedYear,
          availableYears: List.generate(10, (i) => 2024 - i),
          onYearSelected: _provider.updateYear,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _provider,
      child: Consumer<VideoProvider>(
        builder: (context, provider, _) {
          final selectedYear = provider.selectedYear;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: InkWell(
                  onTap: () => _showYearPicker(context),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          selectedYear.toString(),
                          style: const TextStyle(color: Colors.white),
                        ),
                        const Icon(Icons.arrow_drop_down, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: provider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : provider.items.isEmpty
                        ? const Center(child: Text("No videos found.", style: TextStyle(color: Colors.white)))
                        : ListView.builder(
                            key: ValueKey(provider.selectedYear),
                            padding: const EdgeInsets.all(16),
                            itemCount: provider.items.length,
                            itemBuilder: (context, index) {
                              final contestant = provider.items[index];
                              final controller = provider.controllers[contestant.id];

                              return Card(
                                shadowColor: AppColors.black,
                                color: Colors.transparent,
                                elevation: 12,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                  side: const BorderSide(color: Colors.grey, width: 1.0),
                                ),
                                margin: const EdgeInsets.symmetric(vertical: 8),
                                child: Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${contestant.artist} - ${contestant.song}",
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.white,
                                        ),
                                      ),
                                      Text(
                                        "Country: ${contestant.country}",
                                        style: const TextStyle(color: AppColors.white),
                                      ),
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
        },
      ),
    );
  }
}
