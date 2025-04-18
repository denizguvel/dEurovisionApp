import 'package:flutter/material.dart';

class OrientationBuilderWidget extends StatelessWidget {
  final Widget portraitLayout;
  final Widget landscapeLayout;

  const OrientationBuilderWidget({
    super.key,
    required this.portraitLayout,
    required this.landscapeLayout,
  });

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return portraitLayout;
        } else {
          return landscapeLayout;
        }
      },
    );
  }
}