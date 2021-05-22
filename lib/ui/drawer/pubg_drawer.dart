import 'package:flutter/material.dart';
import 'package:q8uc/ui/Dashboard/itune_screen.dart';
import 'package:q8uc/ui/Dashboard/pubg_ward_screen.dart';
import 'package:q8uc/ui/drawer/drawel_model.dart';
import 'package:q8uc/ui/drawer/drawer_listTile.dart';
import 'package:q8uc/ui/drawer/util.dart';
import 'package:q8uc/widget/export.dart';

class PubgDrawer extends StatefulWidget {
  @override
  PubgDrawerState createState() {
    return new PubgDrawerState();
  }
}

class PubgDrawerState extends State<PubgDrawer>
    with SingleTickerProviderStateMixin {
  double maxWidth = 210;
  double minWidth = 70;
  bool isCollapsed = false;
  AnimationController _animationController;
  Animation<double> widthAnimation;
  int currentSelectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    widthAnimation = Tween<double>(begin: maxWidth, end: minWidth)
        .animate(_animationController);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, widget) => getWidget(context, widget),
    );
  }

  Widget getWidget(context, widget) {
    return Material(
      elevation: 80.0,
      child: Container(
        width: widthAnimation.value,
        color: Styles.colorWhite,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              CollapsingListTile(
                title: 'Product Categories',
                icon: 'images/itune.jpeg',
                image: true,
                animationController: _animationController,
              ),
              verticalSpaceMedium,
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (context, counter) {
                    return Divider(height: 12.0);
                  },
                  itemBuilder: (context, counter) {
                    return CollapsingListTile(
                      onTap: () {
                        setState(() {
                          currentSelectedIndex = counter;
                          currentSelectedIndex == 0
                              ? Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ItunScreen()))
                              : Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PubgWards()));
                        });
                      },
                      isSelected: currentSelectedIndex == counter,
                      title: navigationItems[counter].title,
                      icon: navigationItems[counter].icon,
                      animationController: _animationController,
                    );
                  },
                  itemCount: navigationItems.length,
                ),
              ),
              InkWell(
                onTap: () {
                  setState(() {
                    isCollapsed = !isCollapsed;
                    isCollapsed
                        ? _animationController.forward()
                        : _animationController.reverse();
                  });
                },
                child: AnimatedIcon(
                  icon: AnimatedIcons.close_menu,
                  progress: _animationController,
                  color: selectedColor,
                  size: 40.0,
                ),
              ),
              SizedBox(
                height: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
