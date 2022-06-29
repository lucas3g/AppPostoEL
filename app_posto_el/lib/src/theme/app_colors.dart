import 'package:flutter/material.dart';

abstract class AppColors {
  Color get backgroundSecondary;
  Color get backgroundPrimary;
  Color get title;
  Color get button;
  Color get border;
  Color get labelInput;
  Color get primaryColor;
  Color get secondaryColor;
  Color get dropDownTextColor;
  Color get titleLogin;
  Color get backGroundSplash;

  MaterialColor get primary;

  final String hex = '0xff';
  final String colorFinal = '700391';
  final int hexFinal = 0;
}

class AppColorDefault implements AppColors {
  @override
  Color get backgroundSecondary => const Color(0xFF40B38C);

  @override
  Color get title => Colors.white;

  @override
  Color get button => const Color(0xFF666666);

  @override
  Color get backgroundPrimary => const Color(0xFFFFFFFF);

  @override
  Color get border => const Color(0xFFC2C2C2);

  @override
  Color get labelInput => const Color(0xFFFFFFFF);

  @override
  Color get primaryColor => const Color(0xFF96242d);

  @override
  Color get secondaryColor => const Color(0xffcf1f36);

  @override
  Color get dropDownTextColor => const Color(0xFF000000);

  @override
  Color get titleLogin => const Color(0xffcf1f36);

  @override
  Color get backGroundSplash => const Color(0xFFEB5757);

  Map<int, Color> color = {
    50: const Color.fromRGBO(136, 14, 79, .1),
    100: const Color.fromRGBO(136, 14, 79, .2),
    200: const Color.fromRGBO(136, 14, 79, .3),
    300: const Color.fromRGBO(136, 14, 79, .4),
    400: const Color.fromRGBO(136, 14, 79, .5),
    500: const Color.fromRGBO(136, 14, 79, .6),
    600: const Color.fromRGBO(136, 14, 79, .7),
    700: const Color.fromRGBO(136, 14, 79, .8),
    800: const Color.fromRGBO(136, 14, 79, .9),
    900: const Color.fromRGBO(136, 14, 79, 1),
  };

  @override
  String get hex => '0xff';

  //009342 - PAPAGAIO - cf1f36 BIO //004357 Cor legal
  //246EE9 Royal Blue //FF2400 Scarlet Red //3EB489 Mint Green
  @override
  String get colorFinal => 'cf1f36';

  @override
  int get hexFinal => int.parse('$hex$colorFinal');

  @override
  MaterialColor get primary => MaterialColor(hexFinal, color);
}
