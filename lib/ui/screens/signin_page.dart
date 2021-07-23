import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:q8uc/core/view_models/auth_vm.dart';
import 'package:q8uc/core/view_models/connectivity_vm.dart';
import 'package:q8uc/ui/screens/signup_page.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widget2/custom_button.dart';
import 'package:q8uc/ui/widgets/custom_button.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/ui/widgets/custom_textfield.dart';
import 'package:q8uc/ui/widgets/custom_textspan_widget.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';
import 'package:q8uc/utils/base_view.dart';
import 'package:q8uc/utils/progressHud.dart';
import 'package:q8uc/utils/util.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = new GlobalKey<FormState>();

  String email;
  String password;

  ConnectionViewModel model;

  @override
  void initState() {
    super.initState();
    model = ConnectionViewModel();
    model.startMonitoring(context);
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (AuthViewModel model) {},
        builder: (_, AuthViewModel model, __) {
          return GestureDetector(
            onTap: () => Utils.offKeyboard(context),
            child: Scaffold(
              backgroundColor: Styles.colorWhite,
              appBar: AppBar(
                centerTitle: true,
                leading: BackButton(
                  onPressed: () => SystemNavigator.pop(),
                ),
                backgroundColor: Styles.colorWhite,
                elevation: 0,
                title: CustomText(
                  'Sign In',
                  color: Styles.colorBlack,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
              body: ProgressHud(
                inAsyncCall: model.busy,
                opacity: 0.3,
                child: SingleChildScrollView(
                  child: Form(
                    key: formKey,
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: screenAwareSize(60, context),
                            ),
                            Image.asset(
                              'images/redlogo.png',
                              height: screenAwareSize(100, context),
                              width: screenAwareSize(100, context, width: true),
                            ),
                            CustomTextField(
                              title: 'Email',
                              onChanged: (value) => {
                                this.email = value,
                              },
                              maxLines: 1,
                              validator: Utils.validateEmail,
                            ),
                            verticalSpaceSmall,
                            CustomTextField(
                              title: 'Password',
                              onChanged: (value) => {
                                this.password = value,
                              },
                              maxLines: 1,
                              obscure: true,
                              validator: (val) => Utils.validatePassword(val),
                            ),
                            verticalSpaceMedium,
                            verticalSpaceMedium,
                            CustomButton(
                              height: 50,
                              title: 'Sign In',
                                buttonColor: Styles.colorLightBlue,
                              onPressed: () {
                                final Map<String, String> data = {
                                  "email": email,
                                  "password": password,
                                };
                                if (validateAndSave()) {
                                  Utils.offKeyboard(context);
                                  model.loginUser(context, data);
                                }
                              },
                            ),
                            verticalSpaceMedium,
                            verticalSpaceSmall,
                            RichText(
                              textAlign: TextAlign.center,
                              text: customTextSpan(
                                text: 'Dont have an account? ',
                                context: context,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Styles.colorBlack,
                                children: <TextSpan>[
                                  customTextSpan(
                                      text: 'Sign Up',
                                      context: context,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Styles.colorLemon,
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignupScreen()));
                                      }
                                      // locator<NavigationService>()
                                      //     .navigateToReplacing(OnboardView),
                                      ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }

  bool validateAndSave() {
    final form = formKey.currentState;
    if (form.validate()) {
      form.save();
      return true;
    }
    return false;
  }

  showSuccessfulLoginUpDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: AlertBoxx(
            title: 'Registration Successfull',
            action: 'Return to LoginScreen',
            titlecolor: Styles.colorDeepGreen,
            buttoncolor: Styles.colorBlack,
            onTap: () {},
          ));
        });
  }

  showFailureUpDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: AlertBoxx(
            title: 'No Record for user ',
            action: 'SignUp',
            titlecolor: Styles.red,
            buttoncolor: Styles.red,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SignupScreen()));
            },
          ));
        });
  }
}

class SignupPage {}
