import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:q8uc/ui/screens/account_screen.dart';
import 'package:q8uc/ui/screens/categories_screen.dart';
import 'package:q8uc/ui/screens/usage_screen.dart';
import 'package:q8uc/ui/styles/styles.dart';

class ButtomNavScreen extends StatefulWidget {
  const ButtomNavScreen({Key key}) : super(key: key);

  @override
  _ButtomNavScreenState createState() => _ButtomNavScreenState();
}

class _ButtomNavScreenState extends State<ButtomNavScreen> {
  final List<Widget> _screens = [
    CategoriesScreen(),
    UsageScreen(),
    AccountScreen(),
  ];

  int _selectedIndex = 0;

  ValueNotifier<int> cartCount;

  Future<bool> _onWillPop() async {
    print("on will pop");

    if (_selectedIndex == 0)
     return true;

    setState(() {
      _selectedIndex = 0;
      print(_selectedIndex);
    });

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
          body: IndexedStack(
            index: _selectedIndex,
            children: _screens,
          ),
          bottomNavigationBar: BottomNavigationBar(
              onTap: (index) => setState(() => _selectedIndex = index),
              currentIndex: _selectedIndex,
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Styles.colorRed,
              unselectedItemColor: Colors.black,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
              unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
              items: [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.history),
                  label: 'Usage',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person),
                  label: 'Account',
                ),
              ])),
    );
  }
}
