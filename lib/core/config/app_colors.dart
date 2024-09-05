import 'package:flutter/material.dart';

class AppColors {
  static const Color main = Color(0xff779F9C);
  static const Color bg = Color(0xff49454F);
  static const Color white = Color(0xffFFFFFF);
  static const Color black = Color(0xff000000);
  static const Color text1 = Color(0xffA0E7E1);
  static const Color text2 = Color(0xff466361);

  static Color main40 = main.withOpacity(0.4);
  static Color white40 = white.withOpacity(0.4);
}

class Fonts {
  static const String regular = 'SFR';
  static const String medium = 'SFM';
  static const String bold = 'SFB';
}

Color getCategoryColor(String cat) {
  if (cat == 'Shopping') return const Color(0xff59E890);
  if (cat == 'Medicine') return const Color(0xffE85959);
  if (cat == 'Sport') return const Color(0xff597AE8);
  if (cat == 'Travel') return const Color(0xffE88B59);
  return const Color(0xff597AE8);
}
