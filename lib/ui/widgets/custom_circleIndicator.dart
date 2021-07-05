import 'package:flutter/material.dart';

class Utility {
  
  Container indicator() {
    return Container(
        height: 20,
        width: 20,
        child: CircularProgressIndicator(
          strokeWidth: 2.0,
        ));
  }
}
