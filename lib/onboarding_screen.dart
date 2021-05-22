import 'dart:async';

import 'package:flutter/material.dart';
import 'package:q8uc/ui/auth/signup_page.dart';
import 'package:q8uc/util/spacing.dart';
import 'package:q8uc/util/styles.dart';
import 'package:q8uc/widget/size_calculator.dart';




class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

   void initState() {
    super.initState();
    Timer(
        Duration(seconds: 3),
        () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => SignupPage())));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: screenHeight(context),
          width: screenWidth(context),
          decoration: BoxDecoration(
            color: Styles.colorWhite
      //       gradient: LinearGradient(
      // begin: Alignment.topCenter,
      // end: Alignment.bottomCenter,
      // colors: [Styles.appBackground1, Styles.appBackground2])
  ),

          
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
               Image.asset(
                      'images/qulogo.png',
                      width: screenAwareSize(150, context, width: true),
                      height: screenAwareSize(150, context),
                    ),
                    // verticalSpaceMedium,

                    // CustomText('Q8-uc', fontSize: 24, color: Styles.colorBlack, fontWeight: FontWeight.w600,)
            ],
          )
      ),
     
      
    );
  }
}