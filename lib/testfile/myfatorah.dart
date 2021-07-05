// import 'package:flutter/material.dart';
// import 'package:q8uc/ui/styles/spacing.dart';
// import 'package:q8uc/ui/widget2/custom_button.dart';
// import 'package:q8uc/ui/widgets/custom_textfield.dart';
// import 'package:my_fatoorah/my_fatoorah.dart';

// var nameController = TextEditingController();
// var amountController = TextEditingController();

// class InnerPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: Text('دفع ماى فاتورة'),
//           actions: [
//             IconButton(
//                 icon: Icon(Icons.payment),
//                 onPressed: () {
//                   MyFatoorah.startPayment(
                   
//                     context: context,
//                     errorChild: Center(
//                       child: Icon(
//                         Icons.error,
//                         color: Colors.redAccent,
//                         size: 50,
//                       ),
//                     ),
//                     succcessChild: Center(
//                       child: Icon(
//                         Icons.done_all,
//                         color: Colors.greenAccent,
//                         size: 50,
//                       ),
//                     ),
//                     request: MyfatoorahRequest.test(
//                       token:
//                           'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
//                       currencyIso: Country.SaudiArabia,
//                       // successUrl:  
//                           // 'https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png',
//                       errorUrl:
//                           'https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png',
//                       invoiceAmount: 100,
//                       language: ApiLanguage.English,
//                     ),
//                   ).then((response) {
//                     print(response);
//                   }).catchError((e) {
//                     print(e);
//                   });
//                 })
//           ],
//         ),
//         body: SafeArea(
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 20),
//             child: Column(
//               children: [
//                 CustomTextField(
//                   hintText: 'name',
//                   title: 'name',
//                   controller: nameController,
//                 ),
//                 CustomTextField(
//                   hintText: 'Amount',
//                   title: 'Amount',
//                   controller: amountController,
//                 ),

//                 verticalSpaceMedium,
//                 verticalSpaceMedium,

//                 CustomButton(
//                     height: 50,
//                     title: 'checkOut',
//                     onPressed: () {
//                       print(nameController.text);
//                       print(amountController.text);

//                       MyFatoorah.startPayment(
//                         context: context,
//                         errorChild: Center(
//                           child: Icon(
//                             Icons.error,
//                             color: Colors.redAccent,
//                             size: 50,
//                           ),
//                         ),
//                         succcessChild: Center(
//                           child: Icon(
//                             Icons.done_all,
//                             color: Colors.greenAccent,
//                             size: 50,
//                           ),
//                         ),
//                         request: MyfatoorahRequest.test(
//                             token:
//                                 'rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL',
//                             currencyIso: Country.SaudiArabia,
//                             successUrl:
//                                 'https://assets.materialup.com/uploads/473ef52c-8b96-46f7-9771-cac4b112ae28/preview.png',
//                             errorUrl:
//                                 'https://www.digitalpaymentguru.com/wp-content/uploads/2019/08/Transaction-Failed.png',
//                             invoiceAmount: double.parse(amountController.text),
//                             language: ApiLanguage.English,
//                             customerName: nameController.text),
//                       ).then((response) {
//                         print(response);
//                       }).catchError(
//                         (e) {
//                           print(e);
//                         },
//                       );
//                     })
//                 // CustomTextField(),
//                 // CustomTextField(),
//                 // CustomTextField()
//               ],
//             ),
//           ),
//         ));
//   }
// }
