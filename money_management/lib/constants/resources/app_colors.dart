import 'package:flutter/material.dart';

import 'gen/colors.gen.dart';

class AppColors {
  const AppColors({
    required this.tint,
    required this.white,
    required this.disable,
    required this.background,
    required this.mainText,
    required this.cellBackground,
    required this.tabBarSelectedColor,
  });

  final Color tint;

  final Color white;

  final Color disable;

  final Color background;

  final Color mainText;

  final Color cellBackground;

  final Color tabBarSelectedColor;

  static const light = AppColors(
    tint: ColorName.blue,
    white: Colors.white,
    disable: Colors.grey,
    background: ColorName.grey2,
    mainText: Colors.black,
    cellBackground: Colors.white,
    tabBarSelectedColor: ColorName.blue,
  );

  static const dark = AppColors(
    tint: ColorName.black,
    white: Colors.white,
    disable: Colors.grey,
    background: ColorName.grey,
    mainText: Colors.white,
    cellBackground: ColorName.grey1,
    tabBarSelectedColor: Colors.white,
  );
}
