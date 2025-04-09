import 'package:flutter/material.dart';

extension SingleChildScrollViewExtensions on Widget {
  Widget scroll(bool isScroll) {
    if (!isScroll) {
      return SizedBox(
        child: this,
      );
    }
    return SingleChildScrollView(
      child: ColoredBox(color: Colors.transparent, child: this),
    );
  }
}
