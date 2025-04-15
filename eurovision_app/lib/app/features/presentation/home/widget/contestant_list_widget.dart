import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/common/widgets/loading_indicator/loading_indicator.dart';
import 'package:eurovision_app/core/providers/base_provider.dart';
import 'package:eurovision_app/app/features/presentation/home/provider/constestant_provider.dart';
import 'package:eurovision_app/app/features/presentation/home/widget/contestant_list_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';

class ContestantsList extends StatelessWidget {
  final List<ContestantModel> contestants;

  const ContestantsList({super.key, required this.contestants});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<ContestantProvider>();
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
                ? Center(child: LoadingIndicator())
                : provider.state == ContestantState.error
                    ? Center(child: Text('${AppStrings.error} ${provider.errorMessage}'))
                    : SizedBox(
                        height: 300,
                        child: ListView.builder(
                          itemCount: provider.items.length,
                          itemBuilder: (context, index) {
                            return ContestantListItem(
                              contestant: provider.items[index],
                              index: index,
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