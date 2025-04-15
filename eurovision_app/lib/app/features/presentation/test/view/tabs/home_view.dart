import 'package:eurovision_app/app/common/constants/app_animations.dart';
import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/core/providers/base_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/feature/bottom_nav_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/contestant/constestant_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/feature/gradient_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/contestant_list_widget.dart';
import 'package:eurovision_app/app/features/presentation/test/widgets/score_card_widget.dart';
import 'package:eurovision_app/app/features/utils/year_util.dart';
import 'package:eurovision_app/core/constants/page_type_enum.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    int contestYear = YearUtil.getLatestAvailableYear();
    final contestantProvider = Provider.of<ContestantProvider>(context, listen: false);

    Future.delayed(Duration.zero, () {
      contestantProvider.fetchContestants(contestYear);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    final gradientProvider = Provider.of<GradientProvider>(context);
    final gradient = gradientProvider.gradient;

    return Container(
        // width: double.infinity,
        // height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: gradient.begin,
            end: gradient.end,
            colors: gradient.colors,
          ),),
          child: Column(
            children: [
              Consumer<ContestantProvider>(
                builder: (context, contestantProvider, child) {
                  if (contestantProvider.state == ContestantState.loading) {
                    return Center(
                      child: Lottie.asset(AppAnimations.euheart_ani, width: 100, height: 100,),
                    );
                  }
                  if (contestantProvider.state == ContestantState.error) {
                    return Center(
                      child: Text(
                        AppStrings.errorMessage,
                        style: TextStyle(color: AppColors.coralRed)
                      ),
                    );
                  }
                  if (contestantProvider.state == ContestantState.loaded) {
                    return ContestantsList(contestants: contestantProvider.items);
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(height: 20,), 
              ScoreCardWidget(
                title: AppStrings.winning,
                subtitle: AppStrings.winningNumber,
                onTap: () {
                  Provider.of<BottomNavProvider>(context, listen: false)
                    .goToDetail(PageType.winner);
                },
              ),
            ],
          ),     
    );
  }
}