import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/common/widgets/loading_indicator/gradient_loading_screen.dart';
import 'package:eurovision_app/app/common/widgets/loading_indicator/loading_indicator.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/country/country_icon_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/country/country_name_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/gradient_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class WinnerView extends StatefulWidget {
  const WinnerView({super.key});

  @override
  _WinnerViewState createState() => _WinnerViewState();
}

class _WinnerViewState extends State<WinnerView> {
   @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<CountryScoreProvider>().getCountryWins();
    });
  }

  @override
  Widget build(BuildContext context) {
    final countryScoreProvider = context.watch<CountryScoreProvider>();

    if (countryScoreProvider.isLoading) {
      return const GradientLoadingScreen();
    }

    final countryScores = countryScoreProvider.countryWins;

    return Container(
      color: AppColors.white,
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
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
          },
        ),
      ),
    );
  }
}