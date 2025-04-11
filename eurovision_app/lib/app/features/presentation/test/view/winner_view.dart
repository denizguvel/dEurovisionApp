import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/country_name_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/country_icon_provider.dart';

class WinnerView extends StatefulWidget {
  const WinnerView({super.key});

  @override
  State<WinnerView> createState() => _WinnerViewState();
}

class _WinnerViewState extends State<WinnerView> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final provider = Provider.of<CountryScoreProvider>(context, listen: false);
    await provider.getCountryWins();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final countryScores = context.watch<CountryScoreProvider>().countryWins;

    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double tableWidth = constraints.maxWidth > 600 ? 600 : constraints.maxWidth;
                  return Container(
                    width: tableWidth,
                    padding: const EdgeInsets.all(8.0),
                    child: DataTable(
                      columns: const [
                        DataColumn(label: Text(AppStrings.dataRowCountry)),
                        DataColumn(label: Text(AppStrings.dataRowWins)),
                      ],
                      rows: countryScores
                          .map((score) => DataRow(
                                cells: [
                                  DataCell(
                                    Row(
                                      children: [
                                        SvgPicture.asset(
                                          CountryIconProvider().getIconPath(score.countryCode),
                                          height: 24,
                                          width: 32,
                                        ),
                                        const SizedBox(width: 8),
                                        Flexible(
                                          child: Text(score.countryName),
                                        ),
                                      ],
                                    ),
                                  ),
                                  DataCell(Text(score.wins.toString())),
                                ],
                              ))
                          .toList(),
                    ),
                  );
                }
              ),
            ),
    );
  }
}