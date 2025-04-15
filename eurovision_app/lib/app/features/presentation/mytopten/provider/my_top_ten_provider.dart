import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/contest_provider.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/country_name_provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/frame_theme_provider.dart';
import 'package:eurovision_app/core/providers/base_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/allcontestant_provider.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/provider/selected_top_ten_provider.dart';

class MyTopTenProvider extends BaseListProvider<ContestantModel> {
  int _selectedYear = 2024;
  bool _showSecondPage = false;
  final ScreenshotController screenshotController = ScreenshotController();
  final GlobalKey repaintKey = GlobalKey();
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

  Future<void> onYearChanged(BuildContext context, int? year) async {
    if (year == null) return;

    setLoading();
    await fetchYearData(context, year);
    _selectedYear = year;

    context.read<SelectedTop10Provider>().clear();
    notifyListeners(); 
  }

  Future<void> fetchYearData(BuildContext context, int year) async {
    final provider = context.read<AllContestantsProvider>();
    await provider.fetchAllContestants(year);
    await provider.fetchContestDetail(year);
    setLoaded([]);
  }

  void clearAndFetchNewYear(BuildContext context, int year) {
    context.read<SelectedTop10Provider>().clear();
    fetchYearData(context, year);
  }

  void onLongPressStart(BuildContext context, ContestantModel contestant, LongPressStartDetails details) {
    if (_overlayEntry != null) return;
    final overlay = Overlay.of(context);
    final countryMap = context.read<CountryScoreProvider>().countryCodeNameMap;
    final countryName = countryMap[contestant.country] ?? contestant.country;

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
              color: AppColors.rainyBlue,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(contestant.artist,
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(contestant.song,
                    style: const TextStyle(color: Colors.white70, fontSize: 14)),
                const SizedBox(height: 4),
                Text(countryName, style: const TextStyle(color: Colors.white60)),
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

  Future<void> captureAndShare() async {
    try {
      RenderRepaintBoundary boundary =
          repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData == null) return;

      final pngBytes = byteData.buffer.asUint8List();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/my_top_10.png').create();
      await imagePath.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(imagePath.path)],
          text: 'My Eurovision Top 10 ($_selectedYear)!');
    } catch (e) {
      debugPrint("Screenshot error: $e");
    }
  }

  void resetSelection(BuildContext context) {
    context.read<SelectedTop10Provider>().clear();
    context.read<FrameThemeProvider>().setTheme(
    Colors.white,
    const TextStyle(fontSize: 18, color: Colors.black, fontWeight: FontWeight.bold),
    const TextStyle(fontSize: 16, color: Colors.black87),
    const TextStyle(fontSize: 16, color: Colors.grey, fontWeight: FontWeight.w300),
  );
  _showSecondPage = false;
  notifyListeners();
  }
}
