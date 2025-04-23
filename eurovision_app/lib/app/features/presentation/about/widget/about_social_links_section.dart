import 'package:eurovision_app/app/common/constants/app_strings.dart';
import 'package:eurovision_app/app/common/constants/app_url.dart';
import 'package:eurovision_app/app/features/presentation/feature/view/M.DART';
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
        color: Colors.grey.shade100,
        padding: PaddingHelper.medium.all,
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
                  icon: const Icon(FontAwesomeIcons.facebook, color: Colors.blue),
                  onPressed: () => _launchUrl(AppUrl.facebook),
                ),
                const SizedBox(height: 12),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.instagram, color: Colors.redAccent),
                  onPressed: () => _launchUrl(AppUrl.instagram),
                ),
                const SizedBox(height: 12),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.chrome, color: Colors.deepOrange),
                  onPressed: () => _launchUrl(AppUrl.website),
                ),
                const SizedBox(height: 12),
                IconButton(
                  icon: const Icon(FontAwesomeIcons.tiktok, color: Colors.greenAccent),
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