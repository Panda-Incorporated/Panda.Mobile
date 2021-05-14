import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  _AuthenticationPageState createState() => _AuthenticationPageState();
}

class _AuthenticationPageState extends State<AuthenticationPage> {
  InAppWebViewController webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: InAppWebView(
          initialOptions: options,
          onWebViewCreated: (controller) {
            webViewController = controller;
          },
          onUpdateVisitedHistory: (_, Uri uri, __) {
            if (uri.queryParameters.containsKey("code")) {
              Navigator.pop(context, uri.queryParameters["code"]);
            }
          },
          initialUrlRequest: URLRequest(
              url: Uri.parse(
                  "https://pandaapi.azurewebsites.net/authenticate/frikandelbroodje"))),
    );
  }
}
