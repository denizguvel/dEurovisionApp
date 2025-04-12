import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/bottom_nav_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/contestant/constestant_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/country/country_icon_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/view/contestant_detail_view.dart';
import 'package:eurovision_app/core/constants/page_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';

class ContestantsList extends StatelessWidget {
  final List<ContestantModel> contestants;

  const ContestantsList({Key? key, required this.contestants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContestantProvider>(context);
    final countryIconProvider = CountryIconProvider();
    final screenWidth = MediaQuery.of(context).size.width;

    return Card(
      shadowColor: AppColors.cloudBlue,
      color: AppColors.palePink,
      elevation: 12,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.all(screenWidth * 0.04),
      child: Padding(
        padding: EdgeInsets.all(screenWidth * 0.04),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.titleTopTen,
              style: TextStyle(
                fontSize: screenWidth * 0.05,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            provider.state == ContestantState.loading
                ? Center(child: CircularProgressIndicator())
                : provider.state == ContestantState.error
                    ? Center(child: Text('${AppStrings.error} ${provider.errorMessage}'))
                    : SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: provider.contestants.length,
                          itemBuilder: (context, index) {
                            final contestant = provider.contestants[index];
                            final iconPath = countryIconProvider.getIconPath(contestant.country);
                            return InkWell(
                              onTap: () {
                                Provider.of<BottomNavProvider>(context, listen: false)
                                  .goToContestantDetail(PageType.contestantDetail, contestant.id, contestant.year);
                              },
                              child: Container(
                                padding: EdgeInsets.all(screenWidth * 0.02),
                                child: Row(
                                  children: [
                                    Container(
                                      width: screenWidth * 0.12, 
                                      height: screenWidth * 0.12,
                                      child: Text(
                                        '${index + 1}.', 
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.06,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: screenWidth * 0.12, 
                                      height: screenWidth * 0.12,
                                      margin: EdgeInsets.only(right: screenWidth * 0.04),
                                      child: SvgPicture.asset(
                                        iconPath, 
                                        width: screenWidth * 0.12, 
                                        height: screenWidth * 0.12, 
                                      ),
                                    ),
                                    SizedBox(width: 10,),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(height: screenWidth * 0.01),
                                          Text(
                                            contestant.artist,
                                            style: TextStyle(fontSize: screenWidth * 0.04),
                                          ),
                                          SizedBox(height: screenWidth * 0.01),
                                          Text(
                                            contestant.song,
                                            style: TextStyle(fontSize: screenWidth * 0.03),
                                          ),
                                          Divider()
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
          ],
        ),
      ),
    );
  }
}


