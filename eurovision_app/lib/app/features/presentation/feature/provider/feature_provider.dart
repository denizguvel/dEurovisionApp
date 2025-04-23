import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_icons.dart';
import 'package:eurovision_app/core/constants/page_type_enum.dart';
import 'package:eurovision_app/core/network_control/network_control.dart';
import 'package:eurovision_app/app/features/data/domain/usecases/get_gradient_use_case.dart';
import 'package:eurovision_app/app/features/data/domain/entities/gradient_entity.dart';
import 'package:eurovision_app/app/features/data/models/country_score_model.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/eurovision_remote_datasource.dart';

/// Comprehensive provider managing overall app state.
/// Controls AppBar, theme, navigation, network, country data, and background gradients.
class FeatureProvider extends ChangeNotifier {
  // ----------------------------- AppBar -----------------------------
  String _title = AppStrings.appName;
  Widget _leadingIcon = const Icon(Icons.menu);
  List<Widget> _actions = [];

  String get title => _title;
  Widget get leadingIcon => _leadingIcon;
  List<Widget> get actions => _actions;

  void setTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  void setLeadingIcon(Widget newIcon) {
    _leadingIcon = newIcon;
    notifyListeners();
  }

  void setActions(List<Widget> newActions) {
    _actions = newActions;
    notifyListeners();
  }

  // ----------------------------- Bottom Navigation -----------------------------
  int _currentIndex = 0;
  PageType _pageType = PageType.main;
  final Map<int, PageType> _lastViewedPages = {};
  int? selectedContestantId;
  int? selectedYear;
  List<int>? _selectedContestantIds;

  int get currentIndex => _currentIndex;
  PageType get pageType => _pageType;
  List<int>? get selectedContestantIds => _selectedContestantIds;

  set selectedContestantIds(List<int>? ids) {
    _selectedContestantIds = ids;
    notifyListeners();
  }

  void changeIndex(int index) {
    if (_currentIndex != index) {
      _currentIndex = index;
      _pageType = _lastViewedPages[index] ?? PageType.main;
      notifyListeners();
    }
  }

  void changePageType(PageType type) {
    _pageType = type;
    _lastViewedPages[_currentIndex] = type;
    notifyListeners();
  }

  void goToDetail(PageType type) {
    _pageType = type;
    _lastViewedPages[_currentIndex] = type;
    notifyListeners();
  }

  void goBackToMain() {
    _pageType = PageType.main;
    _lastViewedPages[_currentIndex] = PageType.main;
    notifyListeners();
  }

  void goToContestantDetail(PageType type, int id, int year) {
    selectedContestantId = id;
    selectedYear = year;
    _pageType = type;
    notifyListeners();
  }

 // ----------------------------- Country Icon -----------------------------
  static const Map<String, String> _countryIcons = {
    "AL": AppIcons.alFlag, "AD": AppIcons.adFlag, "AM": AppIcons.amFlag, "AU": AppIcons.auFlag,
    "AT": AppIcons.atFlag, "AZ": AppIcons.azFlag, "BY": AppIcons.byFlag, "BE": AppIcons.beFlag,
    "BA": AppIcons.baFlag, "BG": AppIcons.bgFlag, "HR": AppIcons.hrFlag, "CY": AppIcons.cyFlag,
    "CZ": AppIcons.czFlag, "DK": AppIcons.dkFlag, "EE": AppIcons.eeFlag, "FI": AppIcons.fiFlag,
    "FR": AppIcons.frFlag, "GE": AppIcons.geFlag, "DE": AppIcons.deFlag, "GR": AppIcons.grFlag,
    "HU": AppIcons.huFlag, "IS": AppIcons.isFlag, "IE": AppIcons.ieFlag, "IL": AppIcons.ilFlag,
    "IT": AppIcons.itFlag, "KZ": AppIcons.kzFlag, "LV": AppIcons.lvFlag, "LT": AppIcons.ltFlag,
    "LU": AppIcons.luFlag, "MT": AppIcons.mtFlag, "MD": AppIcons.mdFlag, "MC": AppIcons.mcFlag,
    "ME": AppIcons.meFlag, "MA": AppIcons.maFlag, "NL": AppIcons.nlFlag, "MK": AppIcons.mkFlag,
    "NO": AppIcons.noFlag, "PL": AppIcons.plFlag, "PT": AppIcons.ptFlag, "RO": AppIcons.roFlag,
    "RU": AppIcons.ruFlag, "SM": AppIcons.smFlag, "RS": AppIcons.rsFlag, "CS": AppIcons.csFlag,
    "SK": AppIcons.skFlag, "SI": AppIcons.siFlag, "ES": AppIcons.esFlag, "SE": AppIcons.seFlag,
    "CH": AppIcons.chFlag, "TR": AppIcons.trFlag, "UA": AppIcons.uaFlag, "GB": AppIcons.gbFlag,
    "GB-WLS": AppIcons.gbWlsFlag, "YU": AppIcons.yuFlag
  };

  String getIconPath(String countryCode) {
    return _countryIcons[countryCode] ?? AppIcons.euHeart;
  }


  // ----------------------------- Country Score (BaseListProvider-like) -----------------------------
final EurovisionRemoteDatasource _remoteDatasource = EurovisionRemoteDatasourceImpl();

List<CountryScoreModel> _items = [];
bool _isLoading = false;
String? _error;

List<CountryScoreModel> get items => _items;
bool get isLoading => _isLoading;
String? get error => _error;

final Map<String, String> _countryCodeNameMap = {
  "AL": "Albania", "AD": "Andorra", "AM": "Armenia", "AU": "Australia", "AT": "Austria",
  "AZ": "Azerbaijan", "BY": "Belarus", "BE": "Belgium", "BA": "Bosnia and Herzegovina",
  "BG": "Bulgaria", "HR": "Croatia", "CY": "Cyprus", "CZ": "Czech Republic", "DK": "Denmark",
  "EE": "Estonia", "FI": "Finland", "FR": "France", "GE": "Georgia", "DE": "Germany",
  "GR": "Greece", "HU": "Hungary", "IS": "Iceland", "IE": "Ireland", "IL": "Israel",
  "IT": "Italy", "LV": "Latvia", "LT": "Lithuania", "LU": "Luxembourg", "MT": "Malta",
  "MD": "Moldova", "MC": "Monaco", "ME": "Montenegro", "NL": "Netherlands", "MK": "North Macedonia",
  "NO": "Norway", "PL": "Poland", "PT": "Portugal", "RO": "Romania", "RU": "Russia",
  "SM": "San Marino", "RS": "Serbia", "SK": "Slovakia", "SI": "Slovenia", "ES": "Spain",
  "SE": "Sweden", "CH": "Switzerland", "TR": "Turkey", "UA": "Ukraine", "GB": "United Kingdom",
  "YU": "Yugoslavia"
};

Map<String, String> get countryCodeNameMap => _countryCodeNameMap;

void setLoading() {
  _isLoading = true;
  _error = null;
  notifyListeners();
}

void setLoaded(List<CountryScoreModel> list) {
  _isLoading = false;
  _items = list;
  _error = null;
  notifyListeners();
}

void setError(String message) {
  _isLoading = false;
  _error = message;
  notifyListeners();
}

bool _countryScoreInitialized = false;

Future<void> getCountryWins() async {
  if (_countryScoreInitialized) return;
  _countryScoreInitialized = true;

  setLoading();

  try {
    final allContests = await _remoteDatasource.fetchAllContests();
    final Map<String, int> winCountMap = {};

    for (var contest in allContests) {
      final winner = await _remoteDatasource.fetchWinnerByYear(contest.year);
      if (winner != null) {
        winCountMap[winner.country] = (winCountMap[winner.country] ?? 0) + 1;
      }
    }

    final list = winCountMap.entries
        .map((e) => CountryScoreModel(
              countryCode: e.key,
              countryName: _countryCodeNameMap[e.key] ?? e.key,
              wins: e.value,
            ))
        .toList()
      ..sort((a, b) => b.wins.compareTo(a.wins));

    setLoaded(list);
  } catch (e) {
    setError(AppStrings.countryError);
  }
}

  // ----------------------------- Theme Mode -----------------------------
  ThemeMode _themeMode = ThemeMode.light;
  final String _boxName = "themeBox";

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveTheme(_themeMode);
    notifyListeners();
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    final box = await Hive.openBox(_boxName);
    await box.put('isDarkMode', mode == ThemeMode.dark);
  }

  Future<void> loadTheme() async {
    final box = await Hive.openBox(_boxName);
    final isDark = box.get('isDarkMode', defaultValue: false);
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  // ----------------------------- Gradient -----------------------------
  final GetGradientUseCase _getGradientUseCase = GetGradientUseCase();
  GradientEntity _gradient = GradientEntity(
    colors: [AppColors.black, AppColors.pinkyPink, AppColors.black],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  GradientEntity get gradient => _gradient;

  void updateGradient() {
    _gradient = _getGradientUseCase();
    notifyListeners();
  }

  // ----------------------------- Network -----------------------------
  final INetworkControl networkControl;

  FeatureProvider({required this.networkControl}) : assert(networkControl != null) {
    _initNetwork();
  }

  NetworkResult _status = NetworkResult.on;
  NetworkResult get status => _status;

  void _initNetwork() async {
    _status = await networkControl.checkNetworkFirstTime();
    notifyListeners();

    networkControl.handleNetworkChange((result) {
      _status = result;
      notifyListeners();
    });
  }

  Future<void> checkConnectionManually() async {
    final result = await networkControl.checkNetworkFirstTime();
    _status = result;
    notifyListeners();
  }

  @override
  void dispose() {
    networkControl.dispose();
    super.dispose();
  }
}