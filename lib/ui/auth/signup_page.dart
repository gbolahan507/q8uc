
import 'package:flutter/material.dart';
import 'package:q8uc/core/apiService.dart';
import 'package:q8uc/ui/auth/signin_page.dart';
import 'package:q8uc/util/constant/progressHud.dart';
import 'package:q8uc/widget/export.dart';


class SignupPage extends StatefulWidget {
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {


final formKey = new GlobalKey<FormState>();
  var _email = TextEditingController();
  var _password = TextEditingController();



  AuthService apiService;
  bool isApiCallProcess = false;

  @override
  void initState() {
    apiService = AuthService();
    super.initState();
  }






  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Util.offKeyboard(context),
      child: Scaffold(
        backgroundColor: Styles.colorWhite,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Styles.colorWhite,
          elevation: 0,
          title: CustomText(
             'Sign Up' ,
            color: Styles.colorBlack,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        body: ProgressHud(
          inAsyncCall: isApiCallProcess,
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
                        height: screenAwareSize(100, context),
                      ),
                      Image.asset(
                        'images/qulogo.png',
                        height: screenAwareSize(150, context),
                        width: screenAwareSize(150, context, width: true),
                      ),
                      verticalSpaceMedium,
                      verticalSpaceMedium,
                      CustomTextField(
                            maxLines: 1,
                          title: 'UserName or email',
                          controller: _email,
                          validator: Util.validateEmail,
                      ),
                      verticalSpaceMedium,
                      CustomTextField(
                            
                          title: 'Password',
                          controller: _password,
                           maxLines: 1,
                           obscure: true, 
                          validator:(val) {
                        if (val.isEmpty) {
                          return "Password cannot be empty!";
                        } else if (val.length < 6) {
                          return "Password must be up to 6 characters";
                        } else {
                          return null;
                        }
                      },
                              
                              ),
                      verticalSpaceSmall,
                       RichText(
                              textAlign: TextAlign.left,
                              text: customTextSpan(
                                text:
                                    'Your personal data will be used to support your experience throughout this app, to manage access to your account, and for other purposes described in our ',
                                context: context,
                                fontSize: 14,
                                fontWeight: FontWeight.normal,
                                color: Styles.colorBlack,
                                children: <TextSpan>[
                                  customTextSpan(
                                      text: 'Privacy and Policy',
                                      context: context,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Styles.colorLemon,
                                      onTap: () {}
                                      // locator<NavigationService>()
                                      //     .navigateToReplacing(OnboardView),
                                      ),
                                ],
                              ),
                            ),
                      
                      verticalSpaceMedium,
                      verticalSpaceMedium,
               
                CustomButton(
                  title: 'Sign Up',
                  fontSize: 16,
                  buttonColor: Styles.colorLightBlue,
                  onPressed: (){
                    if(validateAndSave()){
                      Util.offKeyboard(context);
                      print(
                        _email.text, 
                      );

                      setState(() {
                          isApiCallProcess = true;                    
                             });
                             apiService.createUser(
                               _email.text,
                               _password.text
                             ).then(
                               (ret) {
                                setState(() {
                                     isApiCallProcess =false; 
                                  });
                                  if (ret) {
                                    setState(() {
                                      showSuccessfulSignUpDialog(context
                                      );
                                             });
                                  
                                  } else  {

                                    setState(() {

                                      showFailureUpDialog(context);
                                   
                                               });
                                  
                                  }
                             }
                             );
                    }
                  },
                ),
                      verticalSpaceMedium,
                      verticalSpaceSmall,

                      RichText(
                        textAlign: TextAlign.center,
                        text: customTextSpan(
                          text: 'Already a user?  ',
                          context: context,
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: Styles.colorBlack,
                          children: <TextSpan>[
                            customTextSpan(
                                text: 'Sign In' ,
                                context: context,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Styles.colorLemon,
                                onTap: () {
               Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));
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
  }
    bool validateAndSave(){
 final form = formKey.currentState;
 if(form.validate()){
   form.save();
   return true;
 }
 return false;
  }

   showSuccessfulSignUpDialog(BuildContext context){
    return showDialog(
      context: context,
     builder: (context){
       return 
             Dialog(
               child: AlertBoxx(
                 title: 'Registration Successfull',
                 action : 'Return to LoginScreen',
                 titlecolor: Styles.colorDeepGreen,
                 buttoncolor: Styles.colorBlack,
                 onTap:  (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));
               },
               )
          
             );
     }
    );
  }             

  showFailureUpDialog(BuildContext context){
    return showDialog(context: context,
     builder: (context){
       return 
               Dialog(
               child: AlertBoxx(
                 title: 'User Record already exist',
                 action : 'SignIn',
                 titlecolor: Styles.red,
                 buttoncolor: Styles.red,
                 onTap:  (){
         Navigator.push(context, MaterialPageRoute(builder: (context) => SigninPage()));

               },
               )
          
             );
     }
    );
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
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50)
      ),
      height: 150,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Column(
        children: [
         CustomText( title, fontSize: 16, color: titlecolor,),
         verticalSpaceMedium,
         verticalSpaceMedium,
         verticalSpaceMedium,
         Row(
           mainAxisAlignment: MainAxisAlignment.end,
           crossAxisAlignment: CrossAxisAlignment.end,
           children: [
             InkWell(
               onTap: onTap,
               child: CustomText(action, fontSize: 14, color: buttoncolor,)),
           ],
         ),



        ],
      ),
    );
  }
}
