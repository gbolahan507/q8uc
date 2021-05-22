import 'package:flutter/material.dart';
import 'package:q8uc/ui/Dashboard/homepage.dart';
import 'package:q8uc/ui/Dashboard/search_screen.dart';
import 'package:q8uc/util/styles.dart';


class NavigationScreen extends StatefulWidget {
  @override
  _NavigationScreenState createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  final List<Widget> _screens = [
    HomePage(),
    SearchScreen(),
    Scaffold()
    

  ];

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: IndexedStack(
          index: _selectedIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
            // backgroundColor: Colors.grey[100],
            elevation: 0,
            onTap: (index) => setState(() => _selectedIndex = index),
            currentIndex: _selectedIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Styles.colorLightBlue,
            unselectedItemColor: Styles.colorBlack.withOpacity(0.5),
            selectedLabelStyle:
                TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            unselectedLabelStyle:
                TextStyle(fontWeight: FontWeight.w600, fontSize: 12),
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'HOME',
              ),

               BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: 'SEARCH',
              ),
              // BottomNavigationBarItem(
              //   icon: Icon(
              //     Icons.work_outline,
              //   ),
              //   label: 'PUBG WARDS',
              // ),
              // BottomNavigationBarItem(
              //   icon: Icon(Icons.work_outline),
              //   label: 'ITUNES',
                
              // ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'SETTINGS',
                
              ),
            ]));
  }
}
