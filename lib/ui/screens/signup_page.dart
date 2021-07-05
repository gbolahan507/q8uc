import 'package:auth_buttons/auth_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:q8uc/core/view_models/auth_vm.dart';
import 'package:q8uc/core/view_models/connectivity_vm.dart';
import 'package:q8uc/ui/screens/signin_page.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widget2/custom_button.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/ui/widgets/custom_textfield.dart';
import 'package:q8uc/ui/widgets/custom_textspan_widget.dart';
import 'package:q8uc/ui/widgets/size_calculator.dart';
import 'package:q8uc/utils/base_view.dart';
import 'package:q8uc/utils/progressHud.dart';
import 'package:q8uc/utils/util.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final formKey = new GlobalKey<FormState>();

  var _userNameController = TextEditingController();
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();
  var _phoneController = TextEditingController();

  bool isApiCallProcess = false;

  Future<bool> _onWillPop() async {
    SystemNavigator.pop();
    return true;
  }

  ConnectionViewModel model;

  @override
  void initState() {
    super.initState();
    model = ConnectionViewModel();
    model.isconnectivity(context);
    setState(() {});
  }

  ValueNotifier<int> cartCount;

  @override
  Widget build(BuildContext context) {
    return BaseView<AuthViewModel>(
        onModelReady: (AuthViewModel model) {},
        builder: (_, AuthViewModel model, __) {
          return WillPopScope(
            onWillPop: _onWillPop,
            child: GestureDetector(
              onTap: () => Utils.offKeyboard(context),
              child: Scaffold(
                backgroundColor: Styles.colorWhite,
                appBar: AppBar(
                  centerTitle: true,
                  backgroundColor: Styles.colorWhite,
                  elevation: 0,
                  title: CustomText(
                    'Sign Up',
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
                                height: screenAwareSize(40, context),
                              ),
                              Image.asset(
                                'images/redlogo.png',
                                height: screenAwareSize(100, context),
                                width:
                                    screenAwareSize(100, context, width: true),
                              ),
                              // verticalSpaceMedium,
                              // verticalSpaceMedium,
                              CustomTextField(
                                maxLines: 1,
                                title: 'Username',
                                controller: _userNameController,
                                validator: (value) => Utils.isValidName(value),
                              ),

                              verticalSpaceSmall,

                              CustomTextField(
                                maxLines: 1,
                                title: 'Email',
                                controller: _emailController,
                                validator: Utils.validateEmail,
                              ),

                              verticalSpaceSmall,

                              CustomTextField(
                                maxLines: 1,
                                title: 'Phone',
                                controller: _phoneController,
                                inputType: TextInputType.number,
                                validator: (val) => Utils.isNumver(val),
                              ),

                              verticalSpaceSmall,

                              CustomTextField(
                                title: 'Password',
                                controller: _passwordController,
                                maxLines: 1,
                                obscure: true,
                                validator: (val) => Utils.validatePassword(val),
                              ),

                              verticalSpaceSmall,
                              RichText(
                                textAlign: TextAlign.left,
                                text: customTextSpan(
                                  text:
                                      'Your personal data will be used to support your experience throughout this app, to manage access to your account, and for other purposes described in our ',
                                  context: context,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Styles.colorBlack,
                                  children: <TextSpan>[
                                    customTextSpan(
                                        text: 'Privacy and Policy',
                                        context: context,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Styles.colorLemon,
                                        onTap: () {}),
                                  ],
                                ),
                              ),
                              verticalSpaceMedium,
                              verticalSpaceMedium,
                              CustomButton(
                                title: 'Sign Up',
                                fontSize: 14,
                                buttonColor: Styles.colorLightBlue,
                                onPressed: () {
                                  if (validateAndSave()) {
                                    Utils.offKeyboard(context);
                                    model.createUsers(
                                        context,
                                        _emailController.text,
                                        _passwordController.text,
                                        _userNameController.text,
                                        _phoneController.text);
                                  }
                                },
                              ),
                              verticalSpaceMedium,

                              CustomText(
                                'or',
                                color: Styles.colorRed,
                                fontWeight: FontWeight.bold,
                              ),
                              verticalSpaceSmall,
                              GoogleAuthButton(
                                onPressed: () {
                                  model.googleSignUp();
                                },
                                // ),
                                // },
                                darkMode: false,
                                style: AuthButtonStyle(
                                  iconType: AuthIconType.outlined,
                                ),
                              ),
                              verticalSpaceMedium,
                              // FacebookAuthButton(
                              //   onPressed: () {
                              //     model.facebookSignIn();
                              //   },
                              //   // darkMode: darkMode,
                              //   isLoading: model.busy,
                              //   style: AuthButtonStyle(
                              //     buttonType: AuthButtonType.secondary,
                              //     iconType: AuthIconType.outlined,
                              //   ),
                              // ),
                              verticalSpaceSmall,

                              RichText(
                                textAlign: TextAlign.center,
                                text: customTextSpan(
                                  text: 'Already a user?  ',
                                  context: context,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                  color: Styles.colorBlack,
                                  children: <TextSpan>[
                                    customTextSpan(
                                        text: 'Sign In',
                                        context: context,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: Styles.colorLemon,
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      LoginScreen()));
                                        }),
                                  ],
                                ),
                              ),
                              verticalSpaceMedium,
                            ],
                          ),
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

  showSuccessfulSignUpDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: AlertBoxx(
            title: 'Registration Successfull',
            action: 'Return to LoginScreen',
            titlecolor: Styles.colorDeepGreen,
            buttoncolor: Styles.colorBlack,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ));
        });
  }

  showFailureUpDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return Dialog(
              child: AlertBoxx(
            title: 'User Record already exist',
            action: 'SignIn',
            titlecolor: Styles.red,
            buttoncolor: Styles.red,
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => LoginScreen()));
            },
          ));
        });
  }
}

class AlertBoxx extends StatelessWidget {
  final String title, action;
  final buttoncolor;
  final titlecolor;
  final Function onTap;
  const AlertBoxx({
    this.onTap,
    this.title,
    this.action,
    this.buttoncolor,
    this.titlecolor,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(50)),
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
          CustomText(
            title,
            fontSize: 16,
            color: titlecolor,
          ),
          verticalSpaceMedium,
          verticalSpaceMedium,
          verticalSpaceMedium,
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              InkWell(
                  onTap: onTap,
                  child: CustomText(
                    action,
                    fontSize: 14,
                    color: buttoncolor,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
