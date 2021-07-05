import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:url_launcher/url_launcher.dart';

class Connect extends StatelessWidget {
  const Connect({
    Key key,
    @required this.phone,
  }) : super(key: key);

  final String phone;

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      animatedIcon:
       AnimatedIcons.menu_close,
      overlayColor: Styles.colorBlack.withOpacity(0.2),
      animatedIconTheme: IconThemeData.fallback(),
      backgroundColor: Styles.colorDeepPink,
      curve: Curves.bounceIn,
      activeChild: Icon(Icons.chat),
      children: [
        SpeedDialChild(
            child: Image.asset('images/telegram.png'),
            onTap: () async {
              var telegram =
                  "https://www.telegram.me/$phone/?text=${Uri.parse('Hi')}";
              await canLaunch(telegram)
                  ? launch(telegram)
                  : print(
                      "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
            }),
        SpeedDialChild(
            child: Image.asset('images/whatsapp.png'),
            onTap: () async {
              var whatsappUrl = "https://wa.me/$phone/?text=${Uri.parse('Hi')}";
              await canLaunch(whatsappUrl)
                  ? launch(whatsappUrl)
                  : print(
                      "open whatsapp app link or do a snackbar with notification that there is no whatsapp installed");
            })
      ],
    );
  }
}
