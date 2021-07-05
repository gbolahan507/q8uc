import 'package:flutter/material.dart';
import 'package:q8uc/ui/styles/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:async';

class Webstate extends StatefulWidget {
  const Webstate({Key key}) : super(key: key);

  @override
  _WebstateState createState() => _WebstateState();
}

class _WebstateState extends State<Webstate> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  num _stackToView = 1;

  void _handleLoad(String value) {
    setState(() {
      _stackToView = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(
        //   leading: Builder(builder: (BuildContext context) {
        //     return IconButton(
        //       icon: Icon(
        //         Icons.arrow_back,
        //         color: Colors.black,
        //       ),
        //       onPressed: () {
        //         Navigator.pop(context);
        //       },
        //     );
        //   }),
        //   backgroundColor: Colors.white10,
        //   elevation: 0,
        // ),
        body: IndexedStack(
      index: _stackToView,
      children: [
        Column(
          children: <Widget>[
            Expanded(
                child: WebView(
              initialUrl: 'https://www.midasbuy.com/kw/redeem/pubgm',
              javascriptMode: JavascriptMode.unrestricted,
              onPageFinished: _handleLoad,
              onWebViewCreated: (WebViewController webViewController) {
                _controller.complete(webViewController);
              },
            )),
          ],
        ),
        Container(
            color: Styles.appBackground1,
            child: Center(
              child: CircularProgressIndicator(),
            )),
      ],
    ));
  }
}
