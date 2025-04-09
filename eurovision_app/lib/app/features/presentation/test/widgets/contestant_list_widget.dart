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

import 'package:eurovision_app/app/features/presentation/test/provider/constestant_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/features/data/models/contestant_model.dart';

class ContestantsList extends StatelessWidget {
    final List<ContestantModel> contestants;

  const ContestantsList({Key? key, required this.contestants}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ContestantProvider>(context);

    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Top 10 Contestants",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            provider.state == ContestantState.loading
              ? Center(child: CircularProgressIndicator())
              : provider.state == ContestantState.error
                  ? Center(child: Text("Error: ${provider.errorMessage}"))
                  : SizedBox(
                      height: 200,
                      child: ListView.builder(
                        itemCount: provider.contestants.length,
                        itemBuilder: (context, index) {
                          final contestant = provider.contestants[index];
                          return ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              contestant.artist,
                              style: TextStyle(fontSize: 14),
                            ),
                            subtitle: Text(
                              contestant.song,
                              style: TextStyle(fontSize: 12),
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

