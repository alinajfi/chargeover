import 'package:flutter/material.dart';

extension SpaceExtension on double {
  SizedBox get spaceH => SizedBox(width: this);
  SizedBox get spaceV => SizedBox(height: this);
}
