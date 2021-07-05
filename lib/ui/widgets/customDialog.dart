

// import 'package:flutter/material.dart';
// import 'package:q8uc/ui/screens/bag_screen.dart';
// import 'package:q8uc/ui/screens/payment/visa.dart';
// import 'package:q8uc/ui/styles/styles.dart';
// import 'package:q8uc/ui/widgets/custom_text_widget.dart';

// class PaymentDialog extends StatelessWidget {
//   const PaymentDialog({ Key? key }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       child: ,
//   showDialog<AlertDialog>(
//       context: context,
//       builder: (BuildContext context) => AlertDialog(
//         content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             CustomText('Choose Payment Method',
//                 fontSize: 12,
//                 bottomMargin: 20,
//                 color: Styles.colorBlack,
//                 fontWeight: FontWeight.bold),
//             PaymentMethods(
//                 onTap: () {
//                   selected = 0;
//                   serial.clear();
//                   for (var i in allCartItems) {
//                     serial.add(i.id);
//                   }
//                   print(serial.join(','));
//                   Navigator.pop(context);
//                   routeTo(
//                       context,
//                       VisaPaymentScreen(
//                           idm: serial.join(','),
//                           totalAmount: totalAmount.toStringAsFixed(2)));
//                 },
//                 text: 'VISA/MASTER CARD',
//                 image: 'images/visam.png',
//                 width: 25.0,
//                 color:
//                     selected == 0 ? Styles.colorLightBlue : Styles.colorBlack),
//             // PaymentMethods(
//             //     onTap: () {
//             //       selected = 1;
//             //       // serial.clear();
//             //       for (var i in allCartItems) {
//             //         serial.add(i.id);
//             //       }
                  
//             //     },
//             //     text: 'KNET',
//             //     image: 'images/knet1.png',
//             //     width: 25.0,
//             //     color:
//             //         selected == 1 ? Styles.colorLightBlue : Styles.colorBlack),
//             // PaymentMethods(
//             //     onTap: () {
//             //       selected = 2;
//             //       for (var i in allCartItems) {
//             //         serial.add(i.id);
//             //       }
//             //       print(serial);
//             //       Navigator.pop(context);
//             //       routeTo(
//             //           context,
//             //           VisaPaymentScreen(
//             //               itemid: serial,
//             //               totalAmount: totalAmount.toStringAsFixed(2)));
//             //     },
//             //     text: 'Qatar Debit Card',
//             //     image: 'images/naps7.png',
//             //     width: 40.0,
//             //     color:
//             //         selected == 2 ? Styles.colorLightBlue : Styles.colorBlack),
//             // Row(
//               mainAxisAlignment: MainAxisAlignment.end,
//               children: [
//                 InkWell(
//                   onTap: () => Navigator.pop(context),
//                   child: CustomText(
//                     'close',
//                     color: Styles.red,
//                   ),
//                 ),
//               ],
//             )
//           ],
//         ),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       ),
//     );
//   }

      
//     );
//   }
// }