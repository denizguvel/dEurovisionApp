import 'package:eurovision_app/app/features/presentation/feature/provider/feature_provider.dart';
import 'package:eurovision_app/app/features/presentation/home_detail/view/home_detail_imports.dart';

/// A widget that displays a table of country wins last top ten in the Eurovision contest.
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
      final bottomProvider = Provider.of<FeatureProvider>(context, listen: false);

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
    final data = provider.item;
    if (data == null) return const SizedBox();

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
            color: AppColors.black),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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