import 'package:flutter/material.dart';

class Gap extends StatelessWidget {
  const Gap._({
    this.width = 0,
    this.height = 0,
  });

  final double width;
  final double height;

  static Widget custom({double height = 0, double width = 0}) =>
      Gap._(width: width, height: height);

  // Vertical Gaps
  static const v2 = Gap._(height: 2);
  static const v4 = Gap._(height: 4);
  static const v8 = Gap._(height: 8);
  static const v6 = Gap._(height: 6);
  static const v10 = Gap._(height: 10);
  static const v12 = Gap._(height: 12);
  static const v14 = Gap._(height: 14);
  static const v16 = Gap._(height: 16);
  static const v18 = Gap._(height: 18);
  static const v20 = Gap._(height: 20);
  static const v24 = Gap._(height: 24);
  static const v30 = Gap._(height: 30);
  static const v32 = Gap._(height: 32);
  static const v40 = Gap._(height: 40);
  static const v48 = Gap._(height: 48);
  static const v100 = Gap._(height: 100);

  // Horizontal Gaps
  static const h2 = Gap._(width: 2);
  static const h4 = Gap._(width: 4);
  static const h8 = Gap._(width: 8);
  static const h6 = Gap._(width: 6);
  static const h10 = Gap._(width: 10);
  static const h12 = Gap._(width: 12);
  static const h14 = Gap._(width: 14);
  static const h16 = Gap._(width: 16);
  static const h18 = Gap._(width: 18);
  static const h20 = Gap._(width: 20);
  static const h24 = Gap._(width: 24);
  static const h30 = Gap._(width: 30);
  static const h32 = Gap._(width: 32);
  static const h40 = Gap._(width: 40);
  static const h48 = Gap._(width: 48);

  @override
  Widget build(BuildContext context) => SizedBox(
        width: width,
        height: height,
      );
}
