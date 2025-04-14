import 'package:eurovision_app/app/common/widgets/loading_indicator/gradient_loading_screen.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/feature/bottom_nav_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/contestant/contestant_detail_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/feature/gradient_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/contestant_detail/contestant_info_card_widget.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/contestant_detail/lyrics_card_widget.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/contestant_detail/videos_card_widget.dart';
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
      return const GradientLoadingScreen();
    }
    if (provider.error != null) {
      return Center(child: Text(provider.error!));
    }
    return _buildContent(provider);
  }

  Widget _buildContent(ContestantDetailProvider provider) {
    final gradientProvider = Provider.of<GradientProvider>(context);
    final gradient = gradientProvider.gradient;
    final data = provider.item;
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
            SafeArea(
              child: VideosCardWidget(
                data: data,
              ),
            ),
            const SizedBox(height: 16),
            ContestantInfoCardWidget(
              artist: data.artist,
              song: data.song,
              country: data.country,
              year: data.year,
              writers: data.writers,
            ),
            const SizedBox(height: 16),
            LyricsCardWidget(data: data),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  } 
}