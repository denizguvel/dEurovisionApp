import 'package:flutter/material.dart';

extension FadeInExtension on Widget {
  Widget fadeIn(TickerProvider vsync,
      {Duration duration = const Duration(milliseconds: 500)}) {
    final controller = AnimationController(duration: duration, vsync: vsync)
      ..forward();

    return FadeTransition(
      opacity: Tween(begin: 0.0, end: 1.0).animate(controller),
      child: this,
    );
  }
}
