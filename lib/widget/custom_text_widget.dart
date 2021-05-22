import 'package:flutter/material.dart';
import 'package:q8uc/widget/export.dart';


class CustomText extends StatelessWidget {
  const CustomText(this.text,
      {Key key,
      this.fontSize,
      this.fontWeight,
      this.textAlign,
      this.color,
      this.textheight,
      this.leftMargin = 0.0,
      this.topMargin = 0.0,
      this.rightMargin = 0.0,
      this.bottomMargin = 0.0,
      this.letterSpacing,
      this.decoration,
      this.fontFamily})
      : super(key: key);
  final String text;
  final String fontFamily;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final double leftMargin;
  final double letterSpacing;
  final double topMargin;
  final double rightMargin;
  final double bottomMargin;
  final double textheight;
  final TextAlign textAlign;
  final decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(leftMargin, topMargin, rightMargin, bottomMargin),
      child: Text(
        text,
        textAlign: textAlign ?? TextAlign.center,
        style: TextStyle(
            height: textheight,
            decoration: decoration,
            letterSpacing: letterSpacing,
            fontFamily: fontFamily ?? 'Crossten',
            fontSize: screenAwareSize(fontSize ?? 14, context, width: true),
            fontWeight: fontWeight,
            color: color ?? Styles.colorGrey),
      ),
    );
  }
}
