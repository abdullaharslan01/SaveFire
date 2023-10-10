import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class FireMap extends StatefulWidget {
  const FireMap({super.key});

  @override
  State<FireMap> createState() => _nameState();
}

class _nameState extends State<FireMap> {
  var controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(const Color(0x00000000))
    ..setNavigationDelegate(
      NavigationDelegate(
        onProgress: (int progress) {
        },
        onPageStarted: (String url) {},
        onPageFinished: (String url) {},
        onWebResourceError: (WebResourceError error) {},
        onNavigationRequest: (NavigationRequest request) {
        
          return NavigationDecision.navigate;
        },
      ),
    )
    ..loadRequest(Uri.parse('https://firms.modaps.eosdis.nasa.gov/map/#d:today;@0.0,0.0,3.0z'));

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: InteractiveViewer(
        panEnabled: true,
        
        child: WebViewWidget(
          
          controller: controller)),
    );
  }
}
