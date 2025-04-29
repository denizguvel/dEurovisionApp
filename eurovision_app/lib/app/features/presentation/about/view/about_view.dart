import 'package:eurovision_app/app/features/presentation/about/widget/about_description_section.dart';
import 'package:eurovision_app/app/features/presentation/about/widget/about_header_section.dart';
import 'package:eurovision_app/app/features/presentation/about/widget/about_social_links_section.dart';
import 'package:eurovision_app/app/features/presentation/feature/provider/feature_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
/// A widget that represents the About view of the app.
/// It displays information about the app, its description, and social links.
class AboutView extends StatelessWidget {
  const AboutView({super.key});

  @override
  Widget build(BuildContext context) {
    final gradientProvider = Provider.of<FeatureProvider>(context);
    final gradient = gradientProvider.gradient;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: gradient.begin,
          end: gradient.end,
          colors: gradient.colors,
        ),
      ),
      child: CustomScrollView(
        slivers: const [
          AboutHeaderSection(),
          AboutDescriptionSection(),
          AboutSocialLinksSection(),
        ],
      ),
    );
  }
}