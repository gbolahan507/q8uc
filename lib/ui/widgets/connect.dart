import 'package:flutter/material.dart';
import 'package:speed_dial_fab/speed_dial_fab.dart';
import 'package:url_launcher/url_launcher.dart';

class Connect extends StatelessWidget {
  const Connect({
    Key key,
    @required this.phone,
  }) : super(key: key);

  final String phone;

  @override
  Widget build(BuildContext context) {
    return SpeedDialFabWidget(
      primaryIconExpand: Icons.chat,
      secondaryIconsList: [
        Image.asset('images/telegram.png'),
        Image.asset('images/whatsapp.png'),
      ],
      secondaryIconsText: [
        "copy",
        "paste",
      ],
      secondaryIconsOnPress: [
        () async {
          var telegram =
              "https://www.telegram.me/$phone/?text=${Uri.parse('Hi')}";
          await canLaunch(telegram)
              ? launch(telegram)
              : print(
                  "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
        },
        () async {
          var whatsappUrl = "https://wa.me/$phone/?text=${Uri.parse('Hi')}";
          await canLaunch(whatsappUrl)
              ? launch(whatsappUrl)
              : print(
                  "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
        },
      ],
      secondaryBackgroundColor: Colors.transparent,
      secondaryForegroundColor: Colors.grey[100],
      primaryBackgroundColor: Colors.grey[900],
      primaryForegroundColor: Colors.grey[100],
    );
    // SpeedDial(
    //   // animatedIcon:
    //   //  AnimatedIcons.menu_close,
    //   icon: Icons.chat,
    //   overlayColor: Styles.colorBlack.withOpacity(0.2),
    //   animatedIconTheme: IconThemeData.fallback(),
    //   backgroundColor: Styles.colorDeepPink,
    //   curve: Curves.bounceIn,
    //   activeChild: Icon(Icons.chat),
    //   children: [
    //     SpeedDialChild(
    //         child: Image.asset('images/telegram.png'),
    //         onTap: () async {
    //           var telegram =
    //               "https://www.telegram.me/$phone/?text=${Uri.parse('Hi')}";
    //           await canLaunch(telegram)
    //               ? launch(telegram)
    //               : print(
    //                   "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
    //         }),
    //     SpeedDialChild(
    //         child: Image.asset('images/whatsapp.png'),
    //         onTap: () async {
    //           var whatsappUrl = "https://wa.me/$phone/?text=${Uri.parse('Hi')}";
    //           await canLaunch(whatsappUrl)
    //               ? launch(whatsappUrl)
    //               : print(
    //                   "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
    //         })
    //   ],
    // );
  }
}
