import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static const Color figmaPink = Color(0xFFFF565C);
  static const Color figmaPurple = Color(0xFF8256FF);
  static const Color figmaGreen = Color(0xFF56FFE1);
  static const Color figmaGray = Color(0xFFDEE0EA);
  static const Color figmaDark = Color(0xFF343A47);
  static const Color figmaWhite = Color(0xFFFFFFFF);
  static const Color figmaYellow = Color(0xFFFFCE51);
  static const Color figmaLightGreen = Color(0xFF56FFE1);
  static const Color figmaDarkPurple = Color(0xFF5621AB);
  static const Color figmaMidDark = Color(0xFF424858);
  static const Color figmaBlackDark = Color(0xFF282C36);

  static const Color nearlyWhite = Color(0xFFFAFAFA);
  static const Color white = figmaWhite;
  static const Color background = figmaDark;
  static const Color nearlyDarkBlue = Color(0xFF2633C5);

  static const Color nearlyBlue = Color(0xFF00B6F0);
  static const Color nearlyBlack = Color(0xFF213333);
  static const Color grey = Color(0xFF3A5160);
  static const Color dark_grey = Color(0xFF313A44);

  static const Color darkText = Color(0xFF253840);
  static const Color darkerText = Color(0xFF17262A);
  static const Color lightText = Color(0xFF4A6572);
  static const Color deactivatedText = Color(0xFF767676);
  static const Color dismissibleBackground = Color(0xFF364A54);
  static const Color spacer = Color(0xFFF2F2F2);
  static const Color transparent = Colors.transparent;
  static const String fontName = 'Roboto';

  static const TextTheme textTheme = TextTheme(
    display1: display1,
    headline: headline,
    title: title,
    subtitle: subtitle,
    body2: body2,
    body1: body1,
    caption: caption,
  );

  static const TextStyle display1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 36,
    letterSpacing: 0.4,
    height: 0.9,
    color: figmaGreen,
  );

  static const TextStyle headline = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 24,
    letterSpacing: 0.27,
    color: figmaGreen,
  );

  static const TextStyle title = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.bold,
    fontSize: 16,
    letterSpacing: 0.18,
    color: figmaGreen,
  );

  static const TextStyle subtitle = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: -0.04,
    color: white,
  );

  static const TextStyle body2 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    letterSpacing: 0.2,
    color: white,
  );

  static const TextStyle body1 = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    letterSpacing: -0.05,
    color: white,
  );

  static const TextStyle caption = TextStyle(
    fontFamily: fontName,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    letterSpacing: 0.2,
    color: lightText, // was lightText
  );
}

ThemeData themeEF = ThemeData(
  scaffoldBackgroundColor: AppTheme.figmaMidDark,
  primaryColor: AppTheme.figmaPurple,
  accentColor: AppTheme.figmaGreen,
  highlightColor: AppTheme.figmaLightGreen,
  backgroundColor: AppTheme.figmaDarkPurple,
  tabBarTheme: TabBarTheme(
    labelColor: AppTheme.figmaWhite,
    indicator: BoxDecoration(
      border: Border(
        bottom: BorderSide(
          color: AppTheme.figmaPink,
          width: 2.0,
        ),
      ),
    ),
  ),
  //        gray: Colors.blueGrey[100],
  //        altBackground: Colors.deepPurpleAccent[700],
  primarySwatch: Colors.blue,
);
