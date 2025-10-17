import 'package:flutter/material.dart';

class AppFonts {
  final Color txt;
  final Color btnTxt1;
  final Color btnTxt2;
  final Color searchTxt;

  const AppFonts({
    required this.txt,
    required this.btnTxt1,
    required this.btnTxt2,
    required this.searchTxt,
  });
  static const String _font = 'Roboto';

  TextStyle get title => TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
    color: txt,
    fontFamily: _font,
  );

  TextStyle get name => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: txt,
    fontFamily: _font,
  );

  TextStyle get rating => TextStyle(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: txt,
    fontFamily: _font,
  );

  TextStyle get add => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: btnTxt1,
    fontFamily: _font,
  );

  TextStyle get remove => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: btnTxt2,
    fontFamily: _font,
  );

  TextStyle get description => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: txt,
    fontFamily: _font,
  );

  TextStyle get searchHint => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: searchTxt,
    fontFamily: _font,
  );

  TextStyle get search => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: txt,
    fontFamily: _font,
  );

  TextStyle get result => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: txt,
    fontFamily: _font,
  );


}
