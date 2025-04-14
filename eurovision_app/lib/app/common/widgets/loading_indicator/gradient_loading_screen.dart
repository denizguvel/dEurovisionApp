import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:eurovision_app/app/features/presentation/test/provider/feature/gradient_provider.dart';
import 'package:eurovision_app/app/common/widgets/loading_indicator/loading_indicator.dart';

class GradientLoadingScreen extends StatelessWidget {
  const GradientLoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final gradient = context.watch<GradientProvider>().gradient;

    return Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: gradient.begin,
          end: gradient.end,
          colors: gradient.colors,
        ),
      ),
      child: const Center(
        child: LoadingIndicator(),
      ),
    );
  }
}