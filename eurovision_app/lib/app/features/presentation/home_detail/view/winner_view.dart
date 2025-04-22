import 'package:eurovision_app/app/features/presentation/feature/provider/feature_provider.dart';
import 'package:eurovision_app/app/features/presentation/home_detail/view/home_detail_imports.dart';

/// A widget that displays a table of country wins in the Eurovision contest.
/// It fetches the data from the [FeatureProvider] and displays it in a [DataTable].
class WinnerView extends StatelessWidget {
  const WinnerView({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<FeatureProvider>().getCountryWins();
        });
        final featureProvider = context.watch<FeatureProvider>();

        if (featureProvider.isLoading) {
          return const GradientLoadingScreen();
        }
        final countryScores = featureProvider.items;

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
                                        featureProvider.getIconPath(score.countryCode),
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
      },
    );
  }
}