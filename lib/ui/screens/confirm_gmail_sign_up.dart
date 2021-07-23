import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:q8uc/core/view_models/auth_vm.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/custom_button.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';
import 'package:q8uc/utils/base_view.dart';
import 'package:q8uc/utils/progressHud.dart';

class ConfirmGmailSignUp extends StatelessWidget {
  const ConfirmGmailSignUp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return BaseView<AuthViewModel>(
        onModelReady: (AuthViewModel model) {},
        builder: (_, AuthViewModel model, __) {
          return StreamBuilder(
              stream: FirebaseAuth.instance.authStateChanges(),
              builder: (context, snapshot) {
                return Scaffold(
                  appBar: PreferredSize(
                    preferredSize: Size.fromHeight(70),
                    child: AppBar(
                      // backgroundColor: Styles.colorOrange,
                      elevation: 0,
                      actions: [
                        Padding(
                          padding: const EdgeInsets.only(top: 10, right: 30),
                          child: Image.asset(
                            'images/redlogo.png',
                            // height: screenAwareSize(100, context),
                            // width:
                            // screenAwareSize(100, context, width: true),
                          ),
                        )
                      ],
                    ),
                  ),
                  body: ProgressHud(
                    inAsyncCall: model.busy,
                    opacity: 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              CircleAvatar(
                                  radius: 50,
                                  backgroundImage: snapshot.hasData
                                      ? NetworkImage(user.photoURL)
                                      : AssetImage('images/user.jpg')),
                              verticalSpaceSmall,
                              CustomText(
                                '${user.email}',
                                color: Styles.colorRed,
                              ),
                              verticalSpaceLarge,
                              verticalSpaceLarge,
                              verticalSpaceLarge,
                              verticalSpaceLarge,
                              verticalSpaceLarge,
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 30),
                                child: CustomButton(
                                    title: 'Verify User',
                                    height: 50,
                                    onPressed: () {
                                      final Map<String, String> data = {
                                        "email": user.email,
                                        "username": user.displayName
                                      };
                                      model.confirmGmail(context, data);
                                    },
                                    buttonColor: Styles.colorLightBlue),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
  }
}
