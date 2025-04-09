import 'package:flutter/material.dart';

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