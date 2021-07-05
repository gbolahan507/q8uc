import 'package:flutter/material.dart';
import 'package:q8uc/core/view_models/auth_vm.dart';
import 'package:q8uc/ui/screens/order_history.dart';
import 'package:q8uc/ui/screens/payment/profile_screen.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/connect.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/utils/base_view.dart';
import 'package:q8uc/utils/router.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key key}) : super(key: key);

  @override
  _AccountScreenState createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  var phone = "+96550067637";

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (AuthViewModel model) {},
        builder: (_, AuthViewModel model, __) {
          return Scaffold(
            floatingActionButton: Connect(phone: phone),
            body: SafeArea(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      children: [
                        ProfileButton(
                          text: "Profile",
                          color: Styles.appBackground1,
                          fontSize: 16.0,
                          icons: Icon(Icons.person),
                          press: () {
                            routeTo(context, ProfileScreen());
                          },
                        ),
                        ProfileButton(
                          text: "Order History",
                          color: Styles.appBackground1,
                          icons: Icon(Icons.payment),
                          fontSize: 16.0,
                          press: () => routeTo(context, OrderHistory()),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        // ProfileButton(
                        //   text: "About Q8uc",
                        //   color: Styles.appBackground1,
                        //   icons: Icon(Icons.info),
                        //   fontSize: 16.0,
                        //   press: () {},
                        // ),
                        // SizedBox(
                        //   height: 10,
                        // ),

                        ProfileButton(
                          text: "Log out",
                          color: Styles.appBackground1,
                          icons: Icon(Icons.logout),
                          fontSize: 16.0,
                          press: () {
                            logOutDialog(context, model);
                          },
                        ),

                        SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void logOutDialog(BuildContext context, AuthViewModel model) {
    showDialog<AlertDialog>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomText('Are you Sure you want to log out',
                    fontSize: 16,
                    bottomMargin: 10,
                    color: Styles.colorBlack,
                    fontWeight: FontWeight.bold),
              ],
            ),
            verticalSpaceMedium,
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CustomText(
                    'No',
                    color: Styles.red,
                  ),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    model.logout();
                  },
                  child: CustomText(
                    'Yes',
                    color: Styles.appBackground1,
                  ),
                ),
              ],
            )
          ],
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }
}

class ProfileButton extends StatelessWidget {
  final String text;
  final Icon icons;
  final Function press;
  final Color color, textColor;
  final double fontSize;
  final fontWeight;
  final width;

  const ProfileButton({
    Key key,
    this.text,
    this.press,
    this.width,
    this.color = Colors.blue,
    this.textColor = Colors.white,
    this.fontSize,
    this.fontWeight,
    this.icons,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(29),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          color: color,
          onPressed: press,
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Styles.appBackground1,
                child: Center(
                    child: IconButton(
                  icon: icons,
                  onPressed: () {},
                )),
              ),
              SizedBox(
                width: 15,
              ),
              Text(
                text,
                style: TextStyle(
                    color: textColor,
                    fontSize: fontSize,
                    fontWeight: fontWeight),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward_ios,
                color: Styles.colorWhite,
              )
            ],
          ),
        ),
      ),
    );
  }
}
