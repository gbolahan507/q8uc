// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:q8uc/ui/styles/spacing.dart';
// import 'package:q8uc/ui/styles/styles.dart';
// import 'package:q8uc/ui/widgets/custom_text_widget.dart';
// import 'package:q8uc/ui/widgets/size_calculator.dart';

// class CustomButton extends StatefulWidget {
//   const CustomButton(
//       {Key key,
//       this.height,
//       this.width,
//       this.borderColor,
//       this.onPressed,
//       this.checkicon = false,
//       this.busy = false,
//       this.newWidget,
//       this.textColor = Colors.white,
//       this.buttonColor = const Color(0xff03588C),
//       this.title,
//       this.fontSize})
//       : super(key: key);
//   final double height;
//   final double width;
//   final Function() onPressed;
//   final bool busy;
//   final newWidget;
//   final bool checkicon;
//   final Color textColor, borderColor;

//   final Color buttonColor;
//   final String title;
//   final double fontSize;

//   @override
//   _CustomButtonState createState() => _CustomButtonState();
// }

// class _CustomButtonState extends State<CustomButton> {
//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: widget.busy ? null : widget.onPressed,
//       child: Container(
//         height: widget.height ?? 50,
//         width: widget.width,
//         decoration: BoxDecoration(
//             boxShadow: const <BoxShadow>[
//               BoxShadow(
//                 blurRadius: 5.0,
//                 color: Color(0x20000000),
//                 spreadRadius: 0.0,
//                 offset: Offset(3.5, 5.0),
//               ),
//             ],
//             color: widget.busy
//                 ? widget.buttonColor.withOpacity(0.5)
//                 : widget.buttonColor,
//             borderRadius: BorderRadius.circular(8),
//             border: Border.all(
//                 color: widget.borderColor ?? Styles.appBackground1, width: 2)),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             if (widget.busy)
//               Platform.isIOS
//                   ? const CupertinoActivityIndicator(radius: 12)
//                   : const CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
//             else
//               Row(
//                 children: [
//                   widget.checkicon ? widget.newWidget : SizedBox(),
//                   widget.checkicon ? horizontalSpaceSmall : SizedBox(width: 0),
//                   CustomText(widget.title,
//                       letterSpacing: 0.5,
//                       color: widget.textColor,
//                       fontSize: screenAwareSize(
//                           screenAwareSize(widget.fontSize ?? 12, context,
//                               width: true),
//                           context),
//                       fontWeight: FontWeight.w700),
//                 ],
//               ),
//           ],
//         ),
//       ),
//     );
//   }
// }
