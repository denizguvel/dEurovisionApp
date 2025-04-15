import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/core/providers/base_list_provider.dart';
import 'package:eurovision_app/app/features/data/models/country_score_model.dart';
import 'package:eurovision_app/app/features/data/datasources/remote/eurovision_remote_datasource.dart';

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
