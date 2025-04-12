import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AboutSocialLinksSection extends StatelessWidget {
  const AboutSocialLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: Colors.grey.shade100,
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.contactUs,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: const [
                Icon(FontAwesomeIcons.instagram, color: Colors.purple),
                SizedBox(width: 12),
                Text('@eurovisionapp'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Icon(FontAwesomeIcons.linkedin, color: Colors.blue),
                SizedBox(width: 12),
                Text('/in/eurovisionapp'),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: const [
                Icon(FontAwesomeIcons.envelope, color: Colors.redAccent),
                SizedBox(width: 12),
                Text('info@eurovisionapp.com'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}