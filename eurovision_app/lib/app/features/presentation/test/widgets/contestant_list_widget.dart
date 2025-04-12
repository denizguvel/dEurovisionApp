// import 'package:eurovision_app/app/features/data/models/contestant_model.dart';
// import 'package:flutter/material.dart';

// class ContestantsList extends StatelessWidget {
//   final List<ContestantModel> contestants;

//   const ContestantsList({Key? key, required this.contestants}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return ListView.builder(
//       itemCount: contestants.length,
//       itemBuilder: (context, index) {
//       final contestant = contestants[index];
//         return Container(
//           margin: EdgeInsets.symmetric(vertical: 8),
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(10),
//             boxShadow: [
//               BoxShadow(
//                 color: Colors.grey.withOpacity(0.2),
//                 spreadRadius: 2,
//                 blurRadius: 5,
//               ),
//             ],
//           ),
//           child: ListTile(
//             // leading: Image.network(
//             //   contestant.flagUrl,
//             //   width: 40,
//             //   height: 40,
//             //   fit: BoxFit.cover,
//             // ),
//             title: Text(
//               contestant.artist,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             subtitle: Text(
//               contestant.song,
//               style: TextStyle(fontSize: 16),
//             ),
//             trailing: Text(
//               '${index + 1}',
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             onTap: () {
//             },
//           ),
//         );
//       },
//     );
//   }
// }

// import 'package:eurovision_app/app/common/constants/app_colors.dart';
// import 'package:eurovision_app/app/common/constants/app_strings.dart';
// import 'package:eurovision_app/app/features/presentation/test/provider/constestant_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:eurovision_app/app/features/data/models/contestant_model.dart';

// class ContestantsList extends StatelessWidget {
//     final List<ContestantModel> contestants;

//   const ContestantsList({Key? key, required this.contestants}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<ContestantProvider>(context);

//     return Card(
//       color: AppColors.grayNew,
//       elevation: 8,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       margin: EdgeInsets.all(16),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               AppStrings.titleTopTen,
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//             ),
//             SizedBox(height: 10),
//             provider.state == ContestantState.loading
//               ? Center(child: CircularProgressIndicator())
//               : provider.state == ContestantState.error
//                   ? Center(child: Text("Error: ${provider.errorMessage}"))
//                   : SizedBox(
//                       height: 200,
//                       child: ListView.builder(
//                         itemCount: provider.contestants.length,
//                         itemBuilder: (context, index) {
//                           final contestant = provider.contestants[index];
//                           return ListTile(
//                             contentPadding: EdgeInsets.zero,
//                             title: Row(
//                               children: [
//                                 Text(
//                                   '${index + 1}',
//                                   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//                                 ),
//                                 SizedBox(width: 10,),
//                                 Text(
//                                   contestant.artist,
//                                   style: TextStyle(fontSize: 14),
//                                 ),
//                               ],
//                             ),
//                             subtitle: Text(
//                               contestant.song,
//                               style: TextStyle(fontSize: 12),
//                             ),
                            
//                           );
//                         },
//                       ),
//                     ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/constestant_provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/country_icon_provider.dart';
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
      //color: AppColors.grayNew,
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
                            return Container(
                              //margin: EdgeInsets.symmetric(vertical: screenWidth * 0.02),
                              padding: EdgeInsets.all(screenWidth * 0.02),
                              // decoration: BoxDecoration(
                              //   color: Colors.white,
                              //   borderRadius: BorderRadius.circular(10),
                              //   boxShadow: [
                              //     BoxShadow(
                              //       color: Colors.grey.withOpacity(0.2),
                              //       spreadRadius: 2,
                              //       blurRadius: 5,
                              //     ),
                              //   ],
                              // ),
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
                                  // const Icon(
                                  //   Icons.arrow_forward_ios,
                                  //   size: 20,
                                  //   color: AppColors.davysGray,
                                  // ),
                                ],
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


