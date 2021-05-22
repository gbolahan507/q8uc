
import 'package:flutter/material.dart';
import 'package:q8uc/core/apiService.dart';
import 'package:q8uc/ui/Dashboard/homepage.dart';
import 'package:q8uc/ui/auth/signup_page.dart';
import 'package:q8uc/util/constant/progressHud.dart';
import 'package:q8uc/widget/export.dart';


class SigninPage extends StatefulWidget {
  @override
  _SigninPageState createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

final formKey = new GlobalKey<FormState>();


  AuthService apiService;
  bool isApiCallProcess = false;
  String email;
  String password;

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
              'Sign In',
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
                          title: 'Email',
                          onChanged: (value) => {
                        this.email = value,
                         } ,
                          validator: Util.validateEmail,
                          ),
                      verticalSpaceMedium,
                      CustomTextField(
                          title: 'Password',
                           onChanged: (value) => {
                        this.password = value,
                                      } ,
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
                      Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                CustomText(
                                  'Forgot Password?',
                                  color: Styles.colorRed,
                                  fontSize: 12,
                                )
                              ],
                            ),
                      verticalSpaceMedium,
                      verticalSpaceMedium,
                      CustomButton(
                        title: 'Sign In',
                        onPressed: (){
                          if(validateAndSave()){
                           Util.offKeyboard(context);
                            setState(() {
                                isApiCallProcess = true;                    
                                   });
                                   apiService..loginUser(email, password).then(
                                     (ret) => {
                                       if (ret != null){
                                         print('succesful login'),
                                         setState(() {
                                      isApiCallProcess = false;    
                                     Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));


                                   }),
                                   
                                       } else{
                                               setState(() {
                                isApiCallProcess = false;     
                                                 showFailureUpDialog(context);

                                   }),
                                      
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
                          text:  'Dont have an account? ',
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                                 
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



     showSuccessfulLoginUpDialog(BuildContext context){
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
                 title: 'No Record for user ',
                 action : 'SignUp',
                 titlecolor: Styles.red,
                 buttoncolor: Styles.red,
                 onTap:  (){
               Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));

               },
               )
          
             );
     }
    );
  }             
}
