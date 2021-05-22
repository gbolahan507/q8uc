import 'package:flutter/material.dart';
import 'package:q8uc/ui/cart/cart_screen3.dart';
import 'package:q8uc/widget/export.dart';

class SecurityPasswordScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Styles.colorWhite,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // verticalSpaceMedium,
              // verticalSpaceMedium,

              SecurityPasswordContainer(
                title: 'Profile',
                // status: 'Connected',
                // onPressed: () {
                //   Navigator.push(context,
                //       MaterialPageRoute(builder: (context) => BvnScreen()));
                // },
              ),
              SecurityPasswordContainer(
                title: 'Notification',
                status: 'Not Connected',
                // onPressed: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => IdVerification()));
                // },
              ),
              SecurityPasswordContainer(
                title: 'Basket',
                status: 'Not Verified',
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ShoppingCartScreen()));
                },
              ),
              SecurityPasswordContainer(
                title: 'Change Password',
                // status: 'Not Connected',
                // onPressed: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => PhoneNumberScreen()));
                // },
              ),

              SecurityPasswordContainer(
                title: 'Connect with us',
                // onPressed: () {
                //   Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => ChangePasswordScreen()));
                // },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SecurityPasswordContainer extends StatelessWidget {
  final String title, status;
  final Function onPressed;

  const SecurityPasswordContainer(
      {Key key, this.title, this.onPressed, this.status})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          onPressed: onPressed,
          borderColor: Styles.appBackground1,
          widget: Row(
            children: [
              CustomText(
                title,
                fontSize: 14,
                color: Styles.colorBlack,
              ),
              Spacer(),
              // CustomText(
              //   status,
              //   fontSize: 12,
              // ),
              // horizontalSpaceMedium,
              CustomIcon(
                icon: Icons.arrow_forward_ios,
                size: 12,
              )
            ],
          ),
        ),
        verticalSpaceMedium
      ],
    );
  }
}
