import 'package:flutter/material.dart';
import 'package:q8uc/core/view_models/items_vm.dart';
import 'package:q8uc/ui/styles/spacing.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:q8uc/ui/widgets/connect.dart';
import 'package:q8uc/ui/widgets/custom_text_widget.dart';
import 'package:q8uc/ui/widgets/custom_textspan_widget.dart';
import 'package:q8uc/utils/progressHud.dart';
import 'package:url_launcher/url_launcher.dart';

class UsageScreen extends StatefulWidget {
  const UsageScreen({Key key}) : super(key: key);

  @override
  _UsageScreenState createState() => _UsageScreenState();
}

class _UsageScreenState extends State<UsageScreen> {
  ItemsViewModel model;
  var phone = "+96550067637";
  var _url = 'https://www.midasbuy.com/kw/redeem/pubgm';

  @override
  void initState() {
    model = ItemsViewModel();
    super.initState();
  }

  void _launchURL() async => await canLaunch(_url)
      ? await launch(_url)
      : throw 'Could not launch $_url';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Styles.colorWhite,
        appBar: buildAppBar(context),
        floatingActionButton: Connect(phone: phone),
        body: ProgressHud(
          inAsyncCall: model.busy,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ListView(
              children: [
                CustomText(
                  'Easily, after you pay, you will receive a Buggy code on the same payment page or via email like this',
                  fontSize: 13,
                  bottomMargin: 20,
                  fontWeight: FontWeight.bold,
                ),
                CustomText(
                  'xyqXsE8YTVSKS976WVSKS7',
                  fontSize: 14,
                  color: Styles.appBackground1,
                  fontWeight: FontWeight.bold,
                  bottomMargin: 20,
                ),
                RichText(
                  textAlign: TextAlign.start,
                  text: customTextSpan(
                    text:
                        'If you receive the code, copy it and enter PUBG Wesite for shipping wedget from ',
                    context: context,
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Styles.colorBlack,
                    children: <TextSpan>[
                      customTextSpan(
                          text: 'here',
                          context: context,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Styles.colorLightBlue,
                          onTap: () {
                            _launchURL();
                            // routeTo(context, Webstate());
                          }),
                    ],
                  ),
                ),
                verticalSpaceSmall,
                CustomText(
                  'Click on login if you have account already',
                  fontSize: 13,
                  color: Styles.colorBlack,
                  fontWeight: FontWeight.bold,
                  bottomMargin: 10,
                ),
                Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                      'images/login.png',
                      fit: BoxFit.fill,
                    )),
                verticalSpaceSmall,
                CustomText(
                  'Sign in or Create a new account',
                  fontSize: 13,
                  color: Styles.colorBlack,
                  fontWeight: FontWeight.bold,
                  bottomMargin: 10,
                ),
                CustomText(
                  'You can also use the special account on our website (but it is better that you set up a private account on your own)',
                  fontSize: 13,
                  color: Styles.colorBlack,
                  bottomMargin: 10,
                ),
                Row(
                  children: [
                    CustomText(
                      'Email: ',
                      fontSize: 13,
                      color: Styles.colorGrey,
                    ),
                    CustomText(
                      'q8uc.com@gmail.com',
                      fontSize: 13,
                      color: Styles.colorBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Row(
                  children: [
                    CustomText(
                      'Password: ',
                      fontSize: 13,
                      color: Styles.colorGrey,
                    ),
                    CustomText(
                      'q8uc.com',
                      fontSize: 13,
                      color: Styles.colorBlack,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                verticalSpaceSmall,
                Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                      'images/signin.png',
                      fit: BoxFit.fill,
                    )),
                verticalSpaceMedium,
                CustomText(
                  'Put your hands in the first box',
                  fontSize: 13,
                  color: Styles.colorBlack,
                  fontWeight: FontWeight.bold,
                  bottomMargin: 20,
                ),
                CustomText(
                  'Put the shipping code in the second box',
                  fontSize: 13,
                  color: Styles.colorBlack,
                  fontWeight: FontWeight.bold,
                  bottomMargin: 10,
                ),
                CustomText(
                  'How to put hands and code as in the illustration',
                  fontSize: 13,
                  color: Styles.colorBlack,
                  bottomMargin: 10,
                  fontWeight: FontWeight.bold,
                ),
                Container(
                    height: 200,
                    width: double.infinity,
                    child: Image.asset(
                      'images/illustration.png',
                      fit: BoxFit.fill,
                    )),
                verticalSpaceSmall,
                Center(
                  child: CustomText(
                    '!Congratulation, it has been shipped ',
                    fontSize: 13,
                    color: Styles.red,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                verticalSpaceMedium,
              ],
            ),
          ),
        ));
  }

  Widget buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Styles.colorWhite,
      iconTheme: IconThemeData(color: Styles.colorBlack),
      elevation: 0,
      title: CustomText(
        'HOW TO SHIP WIDGET PUBG',
        color: Styles.colorBlack,
        fontWeight: FontWeight.bold,
        fontSize: 12.0,
      ),
    );
  }
}
