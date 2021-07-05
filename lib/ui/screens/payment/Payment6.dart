// import 'package:flutter/material.dart';
// import 'package:myfatoorah_flutter/myfatoorah_flutter.dart';

// final String mAPIKey =
//     "rLtt6JWvbUHDDhsZnfpAhpYk4dxYDQkbcPTyGaKp2TYqQgG7FGZ5Th_WD53Oq8Ebz6A53njUoo1w3pjU1D4vs_ZMqFiz_j0urb_BH9Oq9VZoKFoJEDAbRZepGcQanImyYrry7Kt6MnMdgfG5jn4HngWoRdKduNNyP4kzcp3mRv7x00ahkm9LAK7ZRieg7k1PDAnBIOG3EyVSJ5kK4WLMvYr7sCwHbHcu4A5WwelxYK0GMJy37bNAarSJDFQsJ2ZvJjvMDmfWwDVFEVe_5tOomfVNt6bOg9mexbGjMrnHBnKnZR1vQbBtQieDlQepzTZMuQrSuKn-t5XZM7V6fCW7oP-uXGX-sMOajeX65JOf6XVpk29DP6ro8WTAflCDANC193yof8-f5_EYY-3hXhJj7RBXmizDpneEQDSaSz5sFk0sV5qPcARJ9zGG73vuGFyenjPPmtDtXtpx35A-BVcOSBYVIWe9kndG3nclfefjKEuZ3m4jL9Gg1h2JBvmXSMYiZtp9MR5I6pvbvylU_PP5xJFSjVTIz7IQSjcVGO41npnwIxRXNRxFOdIUHn0tjQ-7LwvEcTXyPsHXcMD8WtgBh-wxR8aKX7WPSsT1O8d8reb2aR7K3rkV3K82K_0OgawImEpwSvp9MNKynEAJQS6ZHe_J_l77652xwPNxMRTMASk1ZsJL";

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String _response = '';
//   String _loading = "Loading...";

//   @override
//   void initState() {
//     MFSDK.init("https://apitest.myfatoorah.com/", mAPIKey);

//     super.initState();
//   }

//   /*
//     Send Payment
//    */
//   void sendPayment() {
//     var request = MFSendPaymentRequest(
//         invoiceValue: 0.100,
//         customerName: "Customer name",
//         notificationOption: MFNotificationOption.LINK);

//     MFSDK.sendPayment(
//         context,
//         MFAPILanguage.EN,
//         request,
//         (MFResult<MFSendPaymentResponse> result) => {
//               if (result.isSuccess())
//                 {
//                   setState(() {
//                     print("Response: " +
//                         result.response.toJson().toString().toString());
//                     _response = result.response.toJson().toString().toString();
//                   })
//                 }
//               else
//                 {
//                   setState(() {
//                     print("Response: " +
//                         result.error.toJson().toString().toString());
//                     _response = result.error.message;
//                   })
//                 }
//             });

//     setState(() {
//       _response = _loading;
//     });
//   }

//   /*
//     Initiate Payment
//    */
//   void initiatePayment() {
//     var request = new MFInitiatePaymentRequest(5.5, MFCurrencyISO.KUWAIT_KWD);

//     MFSDK.initiatePayment(
//         request,
//         MFAPILanguage.EN,
//         (MFResult<MFInitiatePaymentResponse> result) => {
//               if (result.isSuccess())
//                 {
//                   setState(() {
//                     print("Response: " + result.response.toJson().toString());
//                     _response = result.response.toJson().toString().toString();
//                   })
//                 }
//               else
//                 {
//                   setState(() {
//                     print("Response: " + result.error.toJson().toString());
//                     _response = result.error.message;
//                   })
//                 }
//             });

//     setState(() {
//       _response = _loading;
//     });
//   }

//   /*
//     Execute Regular Payment
//    */
//   void executeRegularPayment() {
//     // The value 1 is the paymentMethodId of KNET payment method.
//     // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
//     int paymentMethod = 1;

//     var request = new MFExecutePaymentRequest(paymentMethod, 0.100);

//     MFSDK.executePayment(
//         context,
//         request,
//         MFAPILanguage.EN,
//         (String invoiceId, MFResult<MFPaymentStatusResponse> result) => {
//               if (result.isSuccess())
//                 {
//                   setState(() {
//                     print("invoiceId: " + invoiceId);
//                     print("Response: " + result.response.toJson().toString());
//                     _response = result.response.toJson().toString().toString();
//                   })
//                 }
//               else
//                 {
//                   setState(() {
//                     print("invoiceId: " + invoiceId);
//                     print("Response: " + result.error.toJson().toString());
//                     _response = result.error.message;
//                   })
//                 }
//             });

//     setState(() {
//       _response = _loading;
//     });
//   }

//   /*
//     Execute Direct Payment
//    */
//   void executeDirectPayment() {
//     // The value 9 is the paymentMethodId of Visa/Master payment method.
//     // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
//     int paymentMethod = 9;

//     var request = new MFExecutePaymentRequest(paymentMethod, 0.100);

// //    var mfCardInfo = new MFCardInfo(cardToken: "Put your API token key here");

//     var mfCardInfo = new MFCardInfo(
//         cardNumber: "5453010000095489",
//         expiryMonth: "05",
//         expiryYear: "21",
//         securityCode: "100",
//         cardHolderName: "Set Name",
//         bypass3DS: false,
//         saveToken: false);

//     MFSDK.executeDirectPayment(
//         context,
//         request,
//         mfCardInfo,
//         MFAPILanguage.EN,
//         (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
//               if (result.isSuccess())
//                 {
//                   setState(() {
//                     print("invoiceId: " + invoiceId);
//                     print("Response: " + result.response.toJson().toString());
//                     _response = result.response.toJson().toString().toString();
//                   })
//                 }
//               else
//                 {
//                   setState(() {
//                     print("invoiceId: " + invoiceId);
//                     print("Response: " + result.error.toJson().toString());
//                     _response = result.error.message;
//                   })
//                 }
//             });

//     setState(() {
//       _response = _loading;
//     });
//   }

//   /*
//     Execute Direct Payment with Recurring
//    */
//   void executeDirectPaymentWithRecurring() {
//     // The value 20 is the paymentMethodId of Visa/Master payment method.
//     // You should call the "initiatePayment" API to can get this id and the ids of all other payment methods
//     int paymentMethod = 20;

//     var request = new MFExecutePaymentRequest(paymentMethod, 100.0);

//     var mfCardInfo = new MFCardInfo(
//         cardNumber: "5453010000095539",
//         expiryMonth: "05",
//         expiryYear: "21",
//         securityCode: "100",
//         cardHolderName: "Set Name",
//         bypass3DS: true,
//         saveToken: true);

//     mfCardInfo.iteration = 12;

//     MFSDK.executeRecurringDirectPayment(
//         context,
//         request,
//         mfCardInfo,
//         MFRecurringType.monthly,
//         MFAPILanguage.EN,
//         (String invoiceId, MFResult<MFDirectPaymentResponse> result) => {
//               if (result.isSuccess())
//                 {
//                   setState(() {
//                     print("Response: " + invoiceId);
//                     print("Response: " + result.response.toJson().toString());
//                     _response = result.response.toJson().toString().toString();
//                   })
//                 }
//               else
//                 {
//                   setState(() {
//                     print("Response: " + invoiceId);
//                     print("Response: " + result.error.toJson().toString());
//                     _response = result.error.message;
//                   })
//                 }
//             });

//     setState(() {
//       _response = _loading;
//     });
//   }

//   /*
//     Payment Enquiry
//    */
//   void getPaymentStatus() {
//     var request = MFPaymentStatusRequest(invoiceId: "457786");

//     MFSDK.getPaymentStatus(
//         MFAPILanguage.EN,
//         request,
//         (MFResult<MFPaymentStatusResponse> result) => {
//               if (result.isSuccess())
//                 {
//                   setState(() {
//                     print("Response: " + result.response.toJson().toString());
//                     _response = result.response.toJson().toString().toString();
//                   })
//                 }
//               else
//                 {
//                   setState(() {
//                     print("Response: " + result.error.toJson().toString());
//                     _response = result.error.message;
//                   })
//                 }
//             });

//     setState(() {
//       _response = _loading;
//     });
//   }

//   /*
//     Cancel Token
//    */
//   void cancelToken() {
//     MFSDK.cancelToken(
//         "Put your token here",
//         MFAPILanguage.EN,
//         (MFResult<bool> result) => {
//               if (result.isSuccess())
//                 {
//                   setState(() {
//                     print("Response: " + result.response.toString());
//                     _response = result.response.toString();
//                   })
//                 }
//               else
//                 {
//                   setState(() {
//                     print("Response: " + result.error.toJson().toString());
//                     _response = result.error.message;
//                   })
//                 }
//             });

//     setState(() {
//       _response = _loading;
//     });
//   }

//   /*
//     Cancel Recurring Payment
//    */
//   void cancelRecurringPayment() {
//     MFSDK.cancelRecurringPayment(
//         "Put RecurringId here",
//         MFAPILanguage.EN,
//         (MFResult<bool> result) => {
//               if (result.isSuccess())
//                 {
//                   setState(() {
//                     print("Response: " + result.response.toString());
//                     _response = result.response.toString();
//                   })
//                 }
//               else
//                 {
//                   setState(() {
//                     print("Response: " + result.error.toJson().toString());
//                     _response = result.error.message;
//                   })
//                 }
//             });

//     setState(() {
//       _response = _loading;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Center(
//           child: Column(children: [
//             IntrinsicWidth(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   Padding(
//                     padding: EdgeInsets.all(5.0),
//                   ),
//                   RaisedButton(
//                     child: Text('Send Payment'),
//                     onPressed: sendPayment,
//                   ),
//                   RaisedButton(
//                     child: Text('Initiate Payment'),
//                     onPressed: initiatePayment,
//                   ),
//                   RaisedButton(
//                     child: Text('Execute Regular Payment'),
//                     onPressed: executeRegularPayment,
//                   ),
//                   RaisedButton(
//                     child: Text('Execute Direct Payment'),
//                     onPressed: executeDirectPayment,
//                   ),
//                   RaisedButton(
//                     child: Text('Execute Direct Payment with Recurring'),
//                     onPressed: executeDirectPaymentWithRecurring,
//                   ),
//                   RaisedButton(
//                     child: Text('Cancel Recurring Payment'),
//                     onPressed: cancelRecurringPayment,
//                   ),
//                   RaisedButton(
//                     child: Text('Cancel Token'),
//                     onPressed: cancelToken,
//                   ),
//                   RaisedButton(
//                     child: Text('Get Payment Status'),
//                     onPressed: getPaymentStatus,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.all(8.0),
//                   ),
//                 ],
//               ),
//             ),
//             Container(
//               child: Expanded(
//                 flex: 1,
//                 child: SingleChildScrollView(
//                   child: Text(_response),
//                 ),
//               ),
//             ),
//           ]),
//         ),
//       ),
//     );
//   }
// }
