import 'package:q8uc/ui/styles/spacing.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/ui/widgets/custom_textfield.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';

class AddcardSheet2 extends StatefulWidget {
  @override
  _AddcardSheet2State createState() => _AddcardSheet2State();
}

class _AddcardSheet2State extends State<AddcardSheet2> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            SizedBox(height: screenAwareSize(20, context)),
            CustomTextField(
              title: 'Card Holder Name',
              hintText: 'Mubarak Gbolagade',
              maxLines: 1,
            ),
            SizedBox(height: screenAwareSize(10, context)),
            CustomTextField(
              title: 'Card Number',
              hintText: 'Mubarak Gbolagade',
              maxLines: 1,
            ),
            SizedBox(height: screenAwareSize(10, context)),
            Row(
              children: [
                Expanded(
                  child: CustomTextField(
                    title: 'Expire Month',
                    hintText: 'Mubarak Gbolagade',
                    maxLines: 1,
                  ),
                ),
                horizontalSpaceMedium,
                Expanded(
                  child: CustomTextField(
                    title: 'Expire Year',
                    hintText: 'Mubarak Gbolagade',
                    maxLines: 1,
                  ),
                ),
              ],
            ),
            SizedBox(height: screenAwareSize(10, context)),
            CustomTextField(
              title: 'CVV',
              hintText: 'Mubarak Gbolagade',
              maxLines: 1,
              obscure: true,
            ),
          ],
        ),
      ),
    );
  }
}
