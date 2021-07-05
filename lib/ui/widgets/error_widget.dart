import 'package:flutter/material.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:google_fonts/google_fonts.dart';

class ErrorOccurredWidget extends StatelessWidget {
  const ErrorOccurredWidget({Key key, this.error = 'An error occurred'})
      : super(key: key);

  final String error;

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Icon(Icons.error, size: 40, color: Colors.red),
          verticalSpaceMedium,
          Text(error,
              textAlign: TextAlign.center,
              style: GoogleFonts.nunito(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.red)),
        ],
      ),
    ));
  }
}
