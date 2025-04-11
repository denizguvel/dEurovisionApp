// import 'package:flutter/foundation.dart';
// import 'package:eurovision_app/app/features/data/datasources/remote/eurovision_remote_datasource.dart';
// import 'package:eurovision_app/app/features/data/models/country_score_model.dart';

// class CountryScoreProvider extends ChangeNotifier {
//   final EurovisionRemoteDatasource _remoteDatasource;
//   List<CountryScoreModel> _countryWins = [];

//   List<CountryScoreModel> get countryWins => _countryWins;

//   CountryScoreProvider(this._remoteDatasource);

//   Future<void> getCountryWins() async {
//     final allContests = await _remoteDatasource.fetchAllContests();
//     Map<String, int> countryWins = {};

//     for (var contest in allContests) {
//       final winner = await _remoteDatasource.fetchWinnerByYear(contest.year);
//       if (winner != null) {
//         countryWins[winner.country] = (countryWins[winner.country] ?? 0) + 1;
//       }
//     }

//     _countryWins = countryWins.entries
//         .map((entry) => CountryScoreModel(countryCode: entry.key, wins: entry.value, countryName: entry.key))
//         .toList();
//     notifyListeners();
//   }
// }
