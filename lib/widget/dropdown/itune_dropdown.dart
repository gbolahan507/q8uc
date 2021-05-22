import 'package:flutter/material.dart';
import 'package:q8uc/widget/export.dart';




class ItuneDropDown extends StatefulWidget {
  @override
  _ItuneDropDownState createState() => _ItuneDropDownState();
}

class _ItuneDropDownState extends State<ItuneDropDown> {
  
  String _selectedState;
  List<String> _state = [
    'Sort by popularity',
    'Sort by newest',
    'Sort by : lowest price highest',
    'Sort by : Highest price lowest',

  ];

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      widget: DropdownButtonHideUnderline(
        child: DropdownButton(
          isExpanded: true,
          hint: CustomText(
            'Sort by',
            fontSize: 12,
          ),
          value:
              _selectedState, // A global variable used to keep track of the selection
          items: _state.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(
                item,
                style: TextStyle(color: Colors.black),
              ),
            );
          }).toList(),
          onChanged: (selectedItem) => setState(
            () => _selectedState = selectedItem,
          ),
        ),
      ),
    );
  }
}
