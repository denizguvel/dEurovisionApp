import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/bottom_nav_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/contestant/contestant_detail_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/gradient_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/contestant_video_widget.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/lyrics_card_widget.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/videos_card_widget.dart';
import 'package:eurovision_app/core/constants/page_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ContestantDetailView extends StatefulWidget {
  final int id;
  final int year;

  const ContestantDetailView({super.key, required this.id, required this.year});

  @override
  State<ContestantDetailView> createState() => _ContestantDetailViewState();
}

class _ContestantDetailViewState extends State<ContestantDetailView> {
   bool _isLoaded = false;
   

  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      final provider = Provider.of<ContestantDetailProvider>(context, listen: false);
      final bottomProvider = Provider.of<BottomNavProvider>(context, listen: false);

      provider.fetchDetail(widget.year, widget.id);
      bottomProvider.goToDetail(PageType.contestantDetail);
    });
  }

  @override
  Widget build(BuildContext context) {
    
    final provider = Provider.of<ContestantDetailProvider>(context);

    if (provider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (provider.error != null) {
      return Center(child: Text(provider.error!));
    }

    return _buildContent(provider);
  }

  Widget _buildContent(ContestantDetailProvider provider) {
    final gradientProvider = Provider.of<GradientProvider>(context);
    final gradient = gradientProvider.gradient;
    final data = provider.detail;
    if (data == null) return const SizedBox();

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
        begin: gradient.begin,
        end: gradient.end,
        colors: gradient.colors,
      ),
  ),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VideosCardWidget(data: data),
            const SizedBox(height: 16),
            _buildInfoCard(
              title: "Artist Information",
              children: [
                _buildInfoRow("🎤 Artist", data.artist),
                _buildInfoRow("🎵 Song", data.song),
                _buildInfoRow("🌍 Country", data.country),
                _buildInfoRow("📅 Year", data.year.toString()),
                _buildInfoRow("✍️ Writers", data.writers.join(", ")),
              ],
            ),
            const SizedBox(height: 16),
            LyricsCardWidget(data: data),
            const SizedBox(height: 16),
           // _buildVideosCard(data),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard({required String title, required List<Widget> children}) {
    return Card(
       color: Colors.white.withOpacity(0.9),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: AppColors.crimson,
              ),
            ),
            const Divider(),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
