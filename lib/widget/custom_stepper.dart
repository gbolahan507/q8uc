import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:q8uc/model/product_cat_model.dart';
import 'package:q8uc/widget/export.dart';

class CustomStepper extends StatefulWidget {
  final int lowerLimit;
  final int upperLimit;
  final int stepperValue;
  int value;
  final double iconSize;
  final Function onChanged;

  CustomStepper(
      {this.lowerLimit,
      this.upperLimit,
      this.stepperValue,
      this.value,
      this.iconSize,
      this.onChanged});
  @override
  _CustomStepperState createState() => _CustomStepperState();
}

class _CustomStepperState extends State<CustomStepper> {
  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<ProductCatModels>(context);

    return Container(
      decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(color: Colors.white, blurRadius: 15, spreadRadius: 10)
          ]),
      child: Row(
        children: [
          IconButton(
              icon: Icon(Icons.remove),
              onPressed: () {
                productData.removeItem(productData.activeProduct);
                // setState(() {
                //   widget.value = widget.value == widget.lowerLimit
                //       ? widget.lowerLimit
                //       : widget.value -= widget.stepperValue;
                //   widget.onChanged(widget.value);
                // });
              }),
          Container(
            width: widget.iconSize,
            child: CustomText(
              widget.value.toString(),
              textAlign: TextAlign.center,
              fontSize: widget.iconSize * 0.8,
            ),
          ),
          horizontalSpaceTiny,
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                productData.addItem(productData.activeProduct);
                // setState(() {
                //   widget.value = widget.value == widget.upperLimit
                //       ? widget.lowerLimit
                //       : widget.value += widget.stepperValue;
                //   widget.onChanged(widget.value);
                // });
              }),
        ],
      ),
    );
  }
}
