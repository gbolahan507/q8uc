import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';

class LoginTextField extends StatefulWidget {
  const LoginTextField(
      {Key key,
      this.controller,
      this.enabled = true,
      this.autoFocus = false,
      this.inputType,
      this.inputAction,
      this.focusNode,
      this.maxLength,
      this.maxLines,
      this.labelText,
      this.suffixIcon,
      this.validator,
      this.onChanged,
      this.hintText,
      this.obscure})
      : super(key: key);
  final TextEditingController controller;
  final TextInputType inputType;
  final TextInputAction inputAction;
  final FocusNode focusNode;
  final int maxLength;
  final int maxLines;
  final bool enabled;
  final bool autoFocus;
  final String labelText;
  final String hintText;
  final Widget suffixIcon;
  final String Function(String) validator;
  final Function(String) onChanged;
  final bool obscure;

  @override
  _LoginTextFieldState createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {
  bool obscure;

  @override
  void initState() {
    obscure = widget.obscure;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: widget.inputType,
      controller: widget.controller,
      textInputAction: widget.inputAction,
      maxLength: widget.maxLength,
      autofocus: widget.autoFocus,
      enabled: widget.enabled,
      maxLines: widget.maxLines,
      cursorColor: Colors.black,
      style: GoogleFonts.nunito(
          color: Styles.colorBlack,
          fontWeight: FontWeight.w600,
          fontSize: screenAwareSize(16, context, width: true)),
      onChanged: widget.onChanged,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: screenAwareSize(10, context, width: true),
            vertical: screenAwareSize(8, context)),
        labelText: widget.labelText,
        fillColor: Styles.colorWhite,
        filled: true,
        hintStyle: GoogleFonts.nunito(
            color: Styles.colorGreyLight,
            fontWeight: FontWeight.w400,
            fontSize: screenAwareSize(14, context, width: true)),
        labelStyle: GoogleFonts.nunito(
            color: Styles.colorGreyLight,
            fontWeight: FontWeight.w400,
            fontSize: screenAwareSize(15, context, width: true)),
        hintText: widget.hintText,
        errorStyle: GoogleFonts.nunito(
            color: Styles.colorGreyLight,
            fontWeight: FontWeight.w400,
            fontSize: screenAwareSize(10, context, width: true)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Styles.colorNavGreen, width: 1.2),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Styles.colorGreyLight, width: 1.2),
        ),
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(width: 1)),
        counterText: '',
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: Styles.colorRed, width: 1),
        ),
        suffixIcon: obscure == null
            ? null
            : IconButton(
          icon: obscure
              ? Icon(Icons.visibility_off, color: Styles.colorGreyLight)
                    : Icon(Icons.visibility, color: Styles.colorNavGreen),
                onPressed: () {
                  setState(
                    () {
                      obscure = !obscure;
                    },
                  );
                },
              ),
      ),
      validator: widget.validator,
    );
  }
}
