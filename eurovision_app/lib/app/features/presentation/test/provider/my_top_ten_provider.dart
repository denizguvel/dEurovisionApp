import 'dart:io';
import 'package:eurovision_app/app/features/presentation/test/provider/contest/contest_provider.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/contestant/allcontestant_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/selected_top_ten_provider.dart';

class MyTop10Utils extends ChangeNotifier {
  int _selectedYear = 2024;
  bool _showSecondPage = false;
  final ScreenshotController screenshotController = ScreenshotController();
  OverlayEntry? _overlayEntry;
  bool _initialized = false;

  int get selectedYear => _selectedYear;
  bool get showSecondPage => _showSecondPage;

   void init(BuildContext context) {
    if (_initialized) return;
    context.read<ContestProvider>().fetchAvailableYears();
    fetchYearData(context, _selectedYear);
    _initialized = true;
  }

  void setShowSecondPage(bool value) {
    _showSecondPage = value;
    notifyListeners();
  }

  void onYearChanged(BuildContext context,int? newYear) {
    if (newYear == null) return;
    _selectedYear = newYear;
    context.read<SelectedTop10Provider>().clear();
    final provider = context.read<AllContestantsProvider>();
    provider.fetchAllContestants(newYear);
    provider.fetchContestDetail(newYear);
    notifyListeners();
  }

  void onLongPressStart(BuildContext context, ContestantModel contestant, LongPressStartDetails details) {
    final overlay = Overlay.of(context);
    final entry = OverlayEntry(
      builder: (_) => Positioned(
        top: details.globalPosition.dy - 60,
        left: 20,
        right: 20,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contestant.artist, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(contestant.song, style: const TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 4),
                Text(contestant.country, style: const TextStyle(color: Colors.white60)),
              ],
            ),
          ),
        ),
      ),
    );
    overlay.insert(entry);
    _overlayEntry = entry;
  }

  void onLongPressEnd() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  Future<void> shareAsImage() async {
    final image = await screenshotController.capture();
    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/top10.png').create();
      await imagePath.writeAsBytes(image);

      await Share.shareXFiles(
        [XFile(imagePath.path)],
        text: 'My Eurovision Top 10 ($_selectedYear)!',
      );
    }
  }

  void fetchYearData(BuildContext context, int year) {
    final provider = context.read<AllContestantsProvider>();
    provider.fetchAllContestants(year);
    provider.fetchContestDetail(year);
  }

  void clearAndFetchNewYear(BuildContext context, int year) {
    context.read<SelectedTop10Provider>().clear();
    fetchYearData(context, year);
  }
}