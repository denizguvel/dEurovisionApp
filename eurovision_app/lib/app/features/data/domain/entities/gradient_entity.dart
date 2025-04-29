import 'package:flutter/material.dart';

/// A model representing a custom gradient configuration with a list of colors,
/// and alignment directions for start and end points.
class GradientEntity {
  final List<Color> colors;
  final Alignment begin;
  final Alignment end;

  GradientEntity({
    required this.colors,
    required this.begin,
    required this.end,
  });
}