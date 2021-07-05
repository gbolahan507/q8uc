import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';

import 'custom_text_widget.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    Key key,
    @required this.title,
    this.busy = false,
    @required this.onPressed,
    this.textColor = const Color(0xffffffff),
    this.buttonColor = const Color(0xff008751),
    this.fontSize = 15,
    this.height,
    this.hasIcon = false,
  }) : super(key: key);

  final String title;
  final GestureTapCallback onPressed;
  final bool busy;
  final Color textColor;
  final bool hasIcon;
  final Color buttonColor;
  final double fontSize;
  final double height;

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10.0),
      child: Material(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          color: widget.buttonColor,
          child: InkWell(
            onTap: widget.onPressed,
            child: Container(
                width: screenWidth(context),
                height: screenAwareSize(widget.height, context),
                alignment: Alignment.center,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
                child: widget.busy
                    ? Platform.isIOS
                        ? const CupertinoActivityIndicator(radius: 12)
                        : const CircularProgressIndicator(
                            valueColor:
                                AlwaysStoppedAnimation<Color>(Colors.white),
                          )
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          if (widget.hasIcon)
                            Icon(
                              Icons.shopping_bag_outlined,
                              color: Styles.colorWhite,
                              size: screenAwareSize(22, context),
                            ),
                          CustomText(
                            widget.title,
                            color: widget.textColor,
                            leftMargin: 8,
                            fontSize: widget.fontSize,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      )),
          )),
    );
  }
}
