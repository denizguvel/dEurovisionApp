import 'package:eurovision_app/app/common/constants/app_colors.dart';
import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/common/constants/app_url.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

/// A section of the About page that displays social media icons (Facebook, Instagram, TikTok, etc.)
/// and opens external links when tapped using the url_launcher package.
class AboutSocialLinksSection extends StatelessWidget {
  const AboutSocialLinksSection({super.key});

Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        color: AppColors.gray300,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              AppStrings.contactUs,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                IconButton(
                  icon: const Icon(FontAwesomeIcons.facebook, color: AppColors.blueberry),
                  onPressed: () => _launchUrl(AppUrl.facebook),
                ),
                const SizedBox(height: 12),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.instagram, color: AppColors.crimson),
                  onPressed: () => _launchUrl(AppUrl.instagram),
                ),
                const SizedBox(height: 12),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.chrome, color: AppColors.burntSienna),
                  onPressed: () => _launchUrl(AppUrl.website),
                ),
                const SizedBox(height: 12),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.tiktok, color: AppColors.cloudBlue),
                  onPressed: () => _launchUrl(AppUrl.tiktok),
                ),
              ],
            ),
            
          ],
        ),
      ),
    );
  }
}