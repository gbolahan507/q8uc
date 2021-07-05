import 'package:flutter/material.dart';
import 'package:q8uc/ui/screens/drawer/util.dart';

class CollapsingListTile extends StatefulWidget {
  final String title;
  final String icon;
  final iconSize;
  final AnimationController animationController;
  final bool isSelected;
  final Function onTap;
  final bool image;

  CollapsingListTile(
      {@required this.title,
      @required this.icon,
      this.iconSize,
      this.image = false,
      @required this.animationController,
      this.isSelected = false,
      this.onTap});

  @override
  _CollapsingListTileState createState() => _CollapsingListTileState();
}

class _CollapsingListTileState extends State<CollapsingListTile> {
  Animation<double> widthAnimation, sizedBoxAnimation;

  @override
  void initState() {
    super.initState();
    widthAnimation =
        Tween<double>(begin: 200, end: 70).animate(widget.animationController);
    sizedBoxAnimation =
        Tween<double>(begin: 10, end: 0).animate(widget.animationController);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16.0)),
          color: widget.isSelected ? Colors.transparent : Colors.transparent,
        ),
        width: widthAnimation.value,
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        child: Row(
          children: <Widget>[
            widget.image
                ? SizedBox()
                : Image.asset(
                    widget.icon,
                    width: widget.iconSize ?? 30,
                  ),
            SizedBox(width: sizedBoxAnimation.value),
            (widthAnimation.value >= 190)
                ? Text(widget.title,
                    style: widget.image
                        ? imageTextStyle
                        : widget.isSelected
                            ? listTitleSelectedTextStyle
                            : listTitleDefaultTextStyle)
                : Container()
          ],
        ),
      ),
    );
  }
}
