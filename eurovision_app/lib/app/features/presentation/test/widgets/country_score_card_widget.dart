import 'package:flutter/material.dart';

class CountryScoreCard extends StatelessWidget {
  final String countryCode;
  final int winCount;
  final String flagPath;

  const CountryScoreCard({
    Key? key,
    required this.countryCode,
    required this.winCount,
    required this.flagPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 4.0,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.asset(
              flagPath,
              width: 40,
              height: 30,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  countryCode, 
                  style: TextStyle(
                    fontSize: 18.0, 
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4.0),
                Text(
                  '$winCount Wins', 
                  style: TextStyle(
                    fontSize: 14.0, 
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
