// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';

// import 'package:google_fonts/google_fonts.dart';
// import 'package:health/core/model/login_model.dart';
// import 'package:health/core/storage/local_storage.dart';
// import 'package:health/core/view_models/auth_vm.dart';
// import 'package:health/testfile/login_textfield.dart';
// import 'package:health/ui/constants/routes.dart';
// import 'package:health/ui/screens/main_layout_screen.dart';
// import 'package:health/ui/styles/spacing.dart';
// import 'package:health/ui/styles/styles.dart';
// import 'package:health/ui/widget2/custom_button.dart';
// import 'package:health/ui/widgets/custom_text_widget.dart';
// import 'package:health/ui/widgets/size_calculator.dart';
// import 'package:health/utils/base_view.dart';
// import 'package:health/utils/util.dart';

// class SignupScreen extends StatefulWidget {
//   const SignupScreen({Key key}) : super(key: key);

//   @override
//   _SignupScreenState createState() => _SignupScreenState();
// }

// class _SignupScreenState extends State<SignupScreen> {
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController regionController = TextEditingController();
//   final GlobalKey<FormState> _riderLoginKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     final String token = ModalRoute.of(context).settings.arguments as String;

//     return BaseView<AuthViewModel>(
//         onModelReady: (AuthViewModel model) {},
//         builder: (_, AuthViewModel model, __) {
//           return GestureDetector(
//             // onTap: Utils.offKeyboard(),
//             child: Scaffold(
//                 backgroundColor: Styles.colorWhite,
//                 // appBar: AppBar(
//                 //     elevation: 0,
//                 //     leading: BackButtonWidget(color: Styles.colorGreyLight)),
//                 body: Container(
//                   height: screenHeight(context),
//                   margin: const EdgeInsets.only(left: 20, right: 20),
//                   child: Form(
//                     key: _riderLoginKey,
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                     child: ListView(
//                       children: <Widget>[
//                         CustomText(
//                           'Create Account',
//                           bottomMargin: 10,
//                           fontSize: 36.0,
//                           fontWeight: FontWeight.w600,
//                           color: Styles.colorBlack,
//                         ),
//                         CustomText(
//                           'Complete the form below to create an account',
//                           fontSize: 14.0,
//                           fontWeight: FontWeight.w600,
//                           color: Styles.colorGrey,
//                         ),
//                         verticalSpaceMedium,
//                         LoginTextField(
//                           inputType: TextInputType.text,
//                           controller: passwordController,
//                           inputAction: TextInputAction.next,
//                           maxLines: 1,
//                           enabled: !model.busy,
//                           labelText: 'Full Name',
//                           validator: Utils.isValidName,
//                         ),
//                         verticalSpaceMedium,
//                         LoginTextField(
//                           inputType: TextInputType.emailAddress,
//                           controller: emailController,
//                           inputAction: TextInputAction.next,
//                           maxLines: 1,
//                           enabled: !model.busy,
//                           labelText: 'Email',
//                           validator: Utils.validateEmail,
//                         ),
//                         verticalSpaceMedium,
//                         LoginTextField(
//                           inputType: TextInputType.text,
//                           controller: regionController,
//                           inputAction: TextInputAction.next,
//                           maxLines: 1,
//                           enabled: !model.busy,
//                           labelText: 'Province / Region',
//                           validator: Utils.isValidName,
//                         ),
//                         verticalSpaceLarge,
//                         Row(
//                           children: <Widget>[
//                             GestureDetector(
//                               onTap: () {
//                                 iAgree = !iAgree;
//                                 setState(() {});
//                               },
//                               child: Container(
//                                 height: screenAwareSize(20, context),
//                                 width: screenAwareSize(20, context),
//                                 decoration: BoxDecoration(
//                                     color: iAgree
//                                         ? Styles.colorNavGreen
//                                         : Styles.colorGreyLight,
//                                     borderRadius: BorderRadius.circular(8)),
//                                 child: iAgree
//                                     ? Icon(
//                                         Icons.done,
//                                         color: Styles.colorWhite,
//                                         size: screenAwareSize(15, context),
//                                       )
//                                     : const SizedBox(),
//                               ),
//                             ),
//                             horizontalSpaceSmall,
//                             RichText(
//                               textAlign: TextAlign.center,
//                               text: TextSpan(
//                                   text: 'I agree to the ',
//                                   style: GoogleFonts.nunito(
//                                       fontSize: screenAwareSize(12, context,
//                                           width: true),
//                                       color: Styles.colorGreyLight),
//                                   children: <TextSpan>[
//                                     TextSpan(
//                                       text: 'Terms & Conditions',
//                                       style: GoogleFonts.nunito(
//                                           fontSize: screenAwareSize(12, context,
//                                               width: true),
//                                           fontWeight: FontWeight.bold,
//                                           color: Styles.colorNavGreen),
//                                     ),
//                                     TextSpan(
//                                       text: ' and ',
//                                       style: GoogleFonts.nunito(
//                                           fontSize: screenAwareSize(12, context,
//                                               width: true),
//                                           color: Styles.colorGreyLight),
//                                     ),
//                                     TextSpan(
//                                       text: 'Privacy Policy',
//                                       style: GoogleFonts.nunito(
//                                           fontSize: screenAwareSize(12, context,
//                                               width: true),
//                                           fontWeight: FontWeight.bold,
//                                           color: Styles.colorNavGreen),
//                                     ),
//                                   ]),
//                             )
//                           ],
//                         ),
//                         verticalSpaceMedium,
//                         CustomButton(
//                             title: 'Log In',
//                             buttonColor: Styles.colorNavGreen,
//                             textColor: Styles.colorWhite,
//                             busy: model.busy,
//                             height: 50,
//                             onPressed: () {
//                               if (_riderLoginKey.currentState.validate() &&
//                                   iAgree) {
//                                    model.createUser(
//                                   emailController.text,
//                                   passwordController.text,
//                                 );
//                               }
//                               // Navigator.push(context, MaterialPageRoute(builder: (context) => MainLayoutScreen()));
//                             }

//                             //   _riderLoginKey.currentState.validate();
//                             //   if (_riderLoginKey.currentState.validate() &&
//                             //       iAgree) {
//                             //     model.signUp(
//                             //       emailController.text,
//                             //       passwordController.text,
//                             //     );
//                             //   }
//                             // }

//                             ),
//                         verticalSpaceMedium,
//                       ],
//                     ),
//                   ),
//                 )),
//           );
//         });
//   }

//   bool iAgree = false;

//   UserModel userModel;

//   createNewUser(String name, email, region) {
//     if (_riderLoginKey.currentState.validate() && iAgree) {
//       AppCache.saveUser(userModel);
//       print(userModel.email);
//     } else {
//       print('failure');
//     }
//   }
// }
