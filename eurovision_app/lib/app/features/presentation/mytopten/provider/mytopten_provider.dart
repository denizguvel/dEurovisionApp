import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';
import 'package:eurovision_app/app/features/presentation/feature/provider/feature_provider.dart';
import 'package:eurovision_app/app/features/presentation/home_detail/view/home_detail_imports.dart';
import 'package:eurovision_app/app/features/presentation/mytopten/widget/contestant_hover_card_widget.dart';
import 'package:flutter/rendering.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
import 'package:eurovision_app/app/features/data/models/contest_model.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/contestant_ten_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/eurovision_remote_datasource.dart';
import 'package:eurovision_app/app/features/utils/year_util.dart';

/// Provider class managing the state of the "My Top 10" feature.
/// Handles contestant selection, ranking, theming, year data fetching, and screenshot sharing.
class MyTop10Provider extends ChangeNotifier {
  // Theme
  Color _backgroundColor = AppColors.white;
  Color _iconColor = AppColors.gray;
  Color get iconColor => _iconColor;
  TextStyle _titleFontStyle = const TextStyle(fontSize: 18, color: AppColors.black, fontWeight: FontWeight.bold);
  TextStyle _subTitleFontStyle = const TextStyle(fontSize: 16, color: AppColors.black);
  TextStyle _trailingFontStyle = const TextStyle(fontSize: 16, color: AppColors.gray, fontWeight: FontWeight.w300);

  // Contest & Contestants
  EurovisionRemoteDatasourceImpl _eurovisionRemoteDatasource = EurovisionRemoteDatasourceImpl();
  ContestantTenRemoteDatasourceImpl _contestantDatasource = ContestantTenRemoteDatasourceImpl();
  List<int> _availableYears = [];
  List<ContestantModel> _allContestants = [];
  ContestModel? _contestDetails;

  // Top 10
  final List<ContestantModel> _selectedTop10 = [];

  // Page State
  bool _showSecondPage = false;
  int _selectedYear = YearUtil.getLatestAvailableYear();
  final ScreenshotController screenshotController = ScreenshotController();
  final GlobalKey repaintKey = GlobalKey();
  OverlayEntry? _overlayEntry;

  // Getters
  Color get backgroundColor => _backgroundColor;
  TextStyle get titleFontStyle => _titleFontStyle;
  TextStyle get subTitleFontStyle => _subTitleFontStyle;
  TextStyle get trailingFontStyle => _trailingFontStyle;

  List<int> get availableYears => _availableYears;
  List<ContestantModel> get allContestants => _allContestants;
  ContestModel? get contestDetails => _contestDetails;

  List<ContestantModel> get selectedTop10 => _selectedTop10;
  bool get showSecondPage => _showSecondPage;
  int get selectedYear => _selectedYear;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _hasSeenOnboarding = false;
  bool get hasSeenOnboarding => _hasSeenOnboarding;

  void setOnboardingSeen(bool value) {
    _hasSeenOnboarding = value;
    Hive.box('settings').put('hasSeenTop10Onboarding', value);
    notifyListeners();
  }

  bool _pendingOnboarding = false;
  bool get pendingOnboarding => _pendingOnboarding;

  void setPendingOnboarding(bool value) {
    _pendingOnboarding = value;
    notifyListeners();
  }


  // Functions
  Future<void> fetchAvailableYears() async {
    try {
      final response = await _eurovisionRemoteDatasource.fetchAllContests();
      _availableYears = response.map((e) => e.year).toList()..sort((a, b) => b.compareTo(a));
      notifyListeners();
    } catch (_) {}
  }

  Future<void> fetchYearData(int year) async {
    _isLoading = true;
    notifyListeners();

    final result = await _contestantDatasource.fetchTopContestants(year: year);
    if (result.data != null) {
      _allContestants = result.data!;
      _contestDetails = await _eurovisionRemoteDatasource.fetchContestDetail(year);
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<void> onYearChanged(int? year) async {
    if (year == null) return;
    _selectedYear = year;
    _selectedTop10.clear();
    await fetchYearData(year);
    notifyListeners();
  }

  void toggleShowSecondPage(bool value) {
    _showSecondPage = value;
    notifyListeners();
  }

  void selectContestant(ContestantModel contestant) {
    if (_selectedTop10.length < 10 && !_selectedTop10.contains(contestant)) {
      _selectedTop10.add(contestant);
      notifyListeners();
    }
  }

  void reorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) newIndex -= 1;
    final item = _selectedTop10.removeAt(oldIndex);
    _selectedTop10.insert(newIndex, item);
    notifyListeners();
  }

  void clearSelection() {
    _selectedTop10.clear();
    _backgroundColor = AppColors.white;
    _titleFontStyle = const TextStyle(fontSize: 18, color: AppColors.black, fontWeight: FontWeight.bold);
    _subTitleFontStyle = const TextStyle(fontSize: 16, color: AppColors.black);
    _trailingFontStyle = const TextStyle(fontSize: 16, color: AppColors.gray, fontWeight: FontWeight.w300);
    _showSecondPage = false;
    notifyListeners();
  }

  void setTheme({required Color color, required TextStyle title, required TextStyle subtitle, required TextStyle trailing, Color iconColor = AppColors.gray}) {
    _backgroundColor = color;
    _titleFontStyle = title;
    _subTitleFontStyle = subtitle;
    _trailingFontStyle = trailing;
    _iconColor = iconColor;
    notifyListeners();
  }

  void onLongPressStart(BuildContext context, ContestantModel contestant, LongPressStartDetails details) {
  if (_overlayEntry != null) return;

  final overlay = Overlay.of(context);
  final countryMap = Provider.of<FeatureProvider>(context, listen: false).countryCodeNameMap;
  final countryName = countryMap[contestant.country] ?? contestant.country;

  final entry = OverlayEntry(
    builder: (_) => Positioned(
      top: details.globalPosition.dy - 60,
      left: 20,
      right: 20,
      child: ContestantHoverCard(
        contestant: contestant,
        countryName: countryName,
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
      RenderRepaintBoundary boundary = repaintKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      var image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ImageByteFormat.png);
      if (byteData == null) return;

      final pngBytes = byteData.buffer.asUint8List();
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/my_top_10.png').create();
      await imagePath.writeAsBytes(pngBytes);

      await Share.shareXFiles([XFile(imagePath.path)],
          text: '${AppStrings.myEUTop10} ($_selectedYear)!');
    } catch (e) {
      debugPrint("${AppStrings.screenshotError} $e");
    }
  }

  void resetSelection() {
  _selectedTop10.clear();
  _backgroundColor = AppColors.white;
  _titleFontStyle = const TextStyle(fontSize: 18, color: AppColors.black, fontWeight: FontWeight.bold);
  _subTitleFontStyle = const TextStyle(fontSize: 16, color: AppColors.black);
  _trailingFontStyle = const TextStyle(fontSize: 16, color: AppColors.gray, fontWeight: FontWeight.w300);
  _showSecondPage = false;
  notifyListeners();
}
  
    void setShowSecondPage(bool value) {
      _showSecondPage = value;
      notifyListeners();
    }

bool _initialized = false;

void init() {
  if (_initialized) return;
  fetchAvailableYears();
  fetchYearData(_selectedYear);
  final box = Hive.box('settings');
  _hasSeenOnboarding = box.get('hasSeenTop10Onboarding', defaultValue: false);
  _initialized = true;
}


  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  void toggleContestant(ContestantModel contestant) {
  if (_selectedTop10.contains(contestant)) {
    _selectedTop10.remove(contestant);
  } else if (_selectedTop10.length < 10) {
    _selectedTop10.add(contestant);
  }
  notifyListeners();
}

  void setSelectedYear(int year) {
    _selectedYear = year;
    notifyListeners();
  }
  void setContestDetails(ContestModel contestDetails) {
    _contestDetails = contestDetails;
    notifyListeners();
  }
  void setAllContestants(List<ContestantModel> allContestants) {
    _allContestants = allContestants;
    notifyListeners();
  }
  void setAvailableYears(List<int> availableYears) {
    _availableYears = availableYears;
    notifyListeners();
  }
  void setContestantDatasource(ContestantTenRemoteDatasourceImpl contestantDatasource) {
    _contestantDatasource = contestantDatasource;
    notifyListeners();
  }
  void setEurovisionRemoteDatasource(EurovisionRemoteDatasourceImpl eurovisionRemoteDatasource) {
    _eurovisionRemoteDatasource = eurovisionRemoteDatasource;
    notifyListeners();
  }
}