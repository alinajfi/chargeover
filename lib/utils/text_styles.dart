import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextStyles {
  static TextStyle inter({double? size, FontWeight? fontWeight, Color? color}) {
    return GoogleFonts.inter(
        fontSize: size, fontWeight: fontWeight, color: color);
  }

  static TextStyle poppins(FontWeight weight, double size, {Color? color}) {
    return GoogleFonts.poppins(
        fontWeight: weight, fontSize: size, color: color);
  }
}
