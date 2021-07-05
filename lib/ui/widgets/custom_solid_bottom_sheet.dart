import 'package:flutter/material.dart';
import 'package:q8uc/main.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/utils/util.dart';
import 'package:solid_bottom_sheet/solid_bottom_sheet.dart';

import 'size_calculator.dart';

class CustomSolidBottomSheet extends StatefulWidget {
  CustomSolidBottomSheet({
    Key key,
    @required this.headerBar,
    @required this.body,
    this.controller,
    this.minHeight = 0,
    this.maxHeight = 500,
    this.autoSwiped = true,
    this.toggleVisibilityOnTap = false,
    this.canUserSwipe = true,
    this.draggableBody = false,
    this.smoothness = Smoothness.medium,
    this.elevation = 0.0,
    this.showOnAppear = false,
    this.onShow,
    this.onHide,
  })  : assert(elevation >= 0.0),
        assert(minHeight >= 0.0),
        super(key: key) {
    controller.height = showOnAppear ? maxHeight : minHeight;
    controller.smoothness = smoothness;
  }

  final double minHeight;

  final double maxHeight;

  final Widget body;

  final Widget headerBar;

  final bool autoSwiped;

  final bool toggleVisibilityOnTap;

  final bool draggableBody;

  final bool canUserSwipe;

  final Smoothness smoothness;

  final double elevation;

  final bool showOnAppear;
  final SolidController controller;

  final Function onShow;

  final Function onHide;

  @override
  _CustomSolidBottomSheetState createState() => _CustomSolidBottomSheetState();
}

class _CustomSolidBottomSheetState extends State<CustomSolidBottomSheet> {
  bool isDragDirectionUp = false;

  void _onVerticalDragUpdate(DragUpdateDetails data) {
    Utils.offKeyboard(context);
    _setNativeSmoothness();
    if (((widget.controller.height - data.delta.dy) > widget.minHeight) &&
        ((widget.controller.height - data.delta.dy) < widget.maxHeight)) {
      isDragDirectionUp = data.delta.dy <= 0;
      widget.controller.height -= data.delta.dy;
    }
  }

  void _onVerticalDragEnd(DragEndDetails data) {
    Utils.offKeyboard(context);
    _setUsersSmoothness();

    if (isDragDirectionUp && widget.controller.value)
      _show();
    else if (!isDragDirectionUp && !widget.controller.value)
      _hide();
    else
      widget.controller.value = isDragDirectionUp;
  }

  void _onTap() {
    Utils.offKeyboard(context);
    final bool isOpened = widget.controller.height == widget.maxHeight;
    widget.controller.value = !isOpened;
  }

  void Function() _controllerListener;

  @override
  void initState() {
    super.initState();
    widget.controller.value = widget.showOnAppear;
    _controllerListener = () {
      widget.controller.value ? _show() : _hide();
    };
    widget.controller.addListener(_controllerListener);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        stream: widget.controller.isOpenStream,
        initialData: false,
        builder: (BuildContext context, AsyncSnapshot<bool> snap) {
          return Container(
            color: snap.data ? Colors.black45 : const Color(0xffD7EBF3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  onVerticalDragUpdate:
                      widget.canUserSwipe ? _onVerticalDragUpdate : null,
                  onVerticalDragEnd:
                      widget.autoSwiped ? _onVerticalDragEnd : null,
                  onTap: widget.toggleVisibilityOnTap ? _onTap : null,
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            color: Colors.grey.withOpacity(.2),
                            blurRadius: 5,
                            spreadRadius: 10),
                      ],
                      borderRadius: BorderRadius.only(
                          topLeft:
                              Radius.circular(screenAwareSize(30, context)),
                          topRight:
                              Radius.circular(screenAwareSize(30, context))),
                      color: Styles.colorPurple,
                    ),
                    child: Padding(
                      padding: EdgeInsets.only(
                          left: screenAwareSize(8, context),
                          right: screenAwareSize(20, context),
                          top: screenAwareSize(10, context),
                          bottom: screenAwareSize(10, context)),
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.shopping_bag_outlined,
                                color: Styles.colorWhite,
                                size: screenAwareSize(24, context),
                              ),
                              CustomText(
                                'Basket',
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Styles.colorWhite,
                                leftMargin: 8,
                              )
                            ],
                          ),
                          Expanded(
                            child: Image.asset(
                              snap.data
                                  ? 'images/drag-up.png'
                                  : 'images/drag-down.png',
                              height: screenAwareSize(10, context),
                              color: Styles.colorWhite,
                            ),
                          ),
                          Container(
                              width: screenAwareSize(40, context),
                              height: screenAwareSize(40, context),
                              decoration: BoxDecoration(
                                  color: Styles.colorWhite,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                  child: ValueListenableBuilder<int>(
                                      valueListenable: cartCount,
                                      builder: (_, int value, __) => CustomText(
                                            value.toString(),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          )))),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onVerticalDragUpdate:
                      widget.canUserSwipe ? _onVerticalDragUpdate : null,
                  onVerticalDragEnd:
                      widget.autoSwiped ? _onVerticalDragEnd : null,
                  onTap: widget.toggleVisibilityOnTap ? _onTap : null,
                  child: StreamBuilder<double>(
                    stream: widget.controller.heightStream,
                    initialData: widget.controller.height,
                    builder: (_, AsyncSnapshot<double> snapshot) {
                      return AnimatedContainer(
                        curve: Curves.easeOut,
                        duration: Duration(
                            milliseconds: widget.controller.smoothness.value),
                        height: snapshot.data,
                        child: GestureDetector(
                          onVerticalDragUpdate: widget.draggableBody
                              ? _onVerticalDragUpdate
                              : null,
                          onVerticalDragEnd:
                              widget.autoSwiped ? _onVerticalDragEnd : null,
                          onTap: widget.toggleVisibilityOnTap ? _onTap : null,
                          child: widget.controller.height == widget.maxHeight
                              ? widget.body
                              : Container(color: Styles.colorPurple),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        });
  }

  void _hide() {
    if (widget.onHide != null) {
      widget.onHide();
    }
    widget.controller.height = widget.minHeight;
  }

  void _show() {
    if (widget.onShow != null) {
      widget.onShow();
    }
    widget.controller.height = widget.maxHeight;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_controllerListener);
    super.dispose();
  }

  void _setUsersSmoothness() {
    widget.controller.smoothness = widget.smoothness;
  }

  void _setNativeSmoothness() {
    widget.controller.smoothness = Smoothness.withValue(5);
  }
}
