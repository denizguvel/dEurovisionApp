import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:eurovision_app/core/constants/page_type_enum.dart';
import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_icons.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/core/network_control/network_control.dart';
import 'package:eurovision_app/app/features/data/domain/usecases/get_gradient_use_case.dart';
import 'package:eurovision_app/app/features/data/domain/entities/gradient_entity.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/eurovision_remote_datasource.dart';
import 'package:eurovision_app/app/features/data/models/country_score_model.dart';
import 'package:eurovision_app/core/providers/base_list_provider.dart';

// AppBar Provider
class AppBarProvider extends ChangeNotifier {
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
}

// Bottom Navigation Provider
class BottomNavProvider extends ChangeNotifier {
  int _currentIndex = 0;
  PageType _pageType = PageType.main;
  final Map<int, PageType> _lastViewedPages = {};
  int? selectedContestantId;
  int? selectedYear;

  int get currentIndex => _currentIndex;
  PageType get pageType => _pageType;
  List<int>? _selectedContestantIds;

  List<int>? get selectedContestantIds => _selectedContestantIds;

  set selectedContestantIds(List<int>? ids) {
    _selectedContestantIds = ids;
    notifyListeners();
  }

  void goToContestantDetail(PageType type, int id, int year) {
    selectedContestantId = id;
    selectedYear = year;
    _pageType = type;
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
    if (_pageType != type) {
      _pageType = type;
      _lastViewedPages[_currentIndex] = type;
      notifyListeners();
    }
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
}

// Country Icon Provider
class CountryIconProvider {
  static const Map<String, String> countryIcons = {
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
    return countryIcons[countryCode] ?? AppIcons.euHeart;
  }
}

// Country Score Provider
class CountryScoreProvider extends BaseListProvider<CountryScoreModel> {
  final EurovisionRemoteDatasource _remoteDatasource;

  Map<String, String> get countryCodeNameMap => _countryCodeNameMap;

  CountryScoreProvider(this._remoteDatasource);

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

  Future<void> getCountryWins() async {
    if (items.isNotEmpty) return;

    try {
      setLoading();

      final allContests = await _remoteDatasource.fetchAllContests();
      Map<String, int> winCountMap = {};

      for (var contest in allContests) {
        final winner = await _remoteDatasource.fetchWinnerByYear(contest.year);
        if (winner != null) {
          final code = winner.country;
          winCountMap[code] = (winCountMap[code] ?? 0) + 1;
        }
      }

      final list = winCountMap.entries
          .map((entry) {
            final code = entry.key;
            final name = _countryCodeNameMap[code] ?? code;
            final wins = entry.value;
            return CountryScoreModel(
              countryCode: code,
              countryName: name,
              wins: wins,
            );
          })
          .toList()
        ..sort((a, b) => b.wins.compareTo(a.wins));

      setLoaded(list);
    } catch (e) {
      setError(AppStrings.countryError);
    }
  }
}

// Gradient Provider
class GradientProvider extends ChangeNotifier {
  final GetGradientUseCase _getGradientUseCase = GetGradientUseCase();

  GradientEntity _gradient = GradientEntity(
    colors: [AppColors.black, AppColors.black, AppColors.black,   AppColors.crimson2, AppColors.crimson3, AppColors.black],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  GradientEntity get gradient => _gradient;

  void updateGradient() {
    _gradient = _getGradientUseCase();
    notifyListeners();
  }
}

// Theme Provider
class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  final String _boxName = "themeBox";

  ThemeProvider() {
    _loadTheme();
  }

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    _saveTheme(_themeMode);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    var box = await Hive.openBox(_boxName);
    bool isDark = box.get('isDarkMode', defaultValue: false);
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  Future<void> _saveTheme(ThemeMode mode) async {
    var box = await Hive.openBox(_boxName);
    await box.put('isDarkMode', mode == ThemeMode.dark);
  }
}

// Network Provider
class NetworkProvider extends ChangeNotifier {
  final INetworkControl networkControl;

  NetworkResult _status = NetworkResult.on;
  NetworkResult get status => _status;

  NetworkProvider({required this.networkControl}) {
    _init();
  }

  void _init() async {
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