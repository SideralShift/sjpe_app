import 'package:flutter/material.dart';

class ImageConfig {
  double height;
  double width;
  double generalRadius;
  double topLeftRadius;
  double bottomLeftRadius;
  double topRightRadius;
  double bottomRightRadius;

  ImageConfig(
      {this.height = 0,
      this.width = 0,
      this.generalRadius = 0,
      this.topLeftRadius = 0,
      this.bottomLeftRadius = 0,
      this.topRightRadius = 0,
      this.bottomRightRadius = 0});
}
