import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/core/storage/local_storage.dart';
import 'package:q8uc/core/view_models/auth_vm.dart';
import 'package:q8uc/ui/screens/bag_screen.dart';
import 'package:q8uc/ui/screens/order_history.dart';
import 'package:q8uc/ui/screens/payment/profile_screen.dart';
import 'package:q8uc/ui/screens/usage_screen.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/utils/base_view.dart';
import 'package:q8uc/utils/router.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return BaseView<AuthViewModel>(
        onModelReady: (AuthViewModel model) {},
        builder: (_, AuthViewModel model, __) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                return Container(
                  width: 250,
                  child: Drawer(
                    child: ListView(
                      children: [
                        new UserAccountsDrawerHeader(
                          accountName: new CustomText(
                            AppCache.getUser().username,
                            color: Styles.colorWhite,
                          ),
                          accountEmail: new CustomText(
                            AppCache.getUser().email.toString(),
                            color: Styles.colorWhite,
                          ),
                          decoration: new BoxDecoration(color: Styles.colorRed),
                          currentAccountPicture: CircleAvatar(
                              backgroundImage: snapshot.hasData
                                  ? NetworkImage(user.photoURL)
                                  : AssetImage('images/user.jpg')),
                        ),
                        new ListTile(
                            leading: Icon(Icons.dashboard),
                            title: new Text("Main"),
                            onTap: () {
                              Navigator.pop(context);
                            }),
                        new ListTile(
                            leading: Icon(Icons.shopping_cart),
                            title: new Text("Shopping"),
                            onTap: () {
                              routeTo(context, BagScreen());
                            }),
                        new ListTile(
                            leading: Icon(Icons.settings),
                            title: new Text("History"),
                            onTap: () {
                              routeTo(context, OrderHistory());
                            }),
                        new Divider(),
                        new ListTile(
                            leading: Icon(Icons.person),
                            title: new Text("Profile"),
                            onTap: () {
                              routeTo(context, ProfileScreen());
                            }),
                        new ListTile(
                            leading: Icon(Icons.info),
                            title: new Text("About"),
                            onTap: () {
                              routeTo(context, UsageScreen());
                            }),
                        // new ListTile(
                        //     leading: Icon(Icons.app_registration),
                        //     title: new Text("Signup/Login"),
                        //     onTap: () {
                        //       routeTo(context, SignupScreen());
                        //     }),
                        new ListTile(
                            leading: Icon(Icons.power_settings_new),
                            title: new Text("Logout"),
                            onTap: () {
                              logOutDialog(context, model);
                            }),
                      ],
                    ),
                  ),
                );
              });
        });
  }
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
                  Navigator.pop(context);
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
// }
