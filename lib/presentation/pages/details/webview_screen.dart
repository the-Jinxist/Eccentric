import 'dart:async';

import 'package:flutter/material.dart';
import 'package:game_app/domain/utils/size_config.dart';
import 'package:game_app/presentation/widgets/x_margin.dart';
import 'package:line_awesome_icons/line_awesome_icons.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewPage extends StatefulWidget {

  final String initialUrl;


  WebViewPage({@required this.initialUrl});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  final Completer<WebViewController> _webViewController = Completer<WebViewController>();

  final SizeConfig _config = SizeConfig();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(icon: Icon(LineAwesomeIcons.close), onPressed: (){}),
        actions: <Widget>[
          FutureBuilder<WebViewController>(
            future: _webViewController.future,
            builder: (BuildContext context, AsyncSnapshot<WebViewController> snapshot){
              if(snapshot.hasData){
                return Row(
                  children: <Widget>[
                    IconButton(
                      icon: const Icon(
                        Icons.refresh,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        setState((){
                          snapshot.data.reload();
                        });

                      },
                    ),
                    XMargin(2),
                  ],
                );
              }else{
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: _config.sh(30),
                      width: _config.sw(30),
                      child: const Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                    XMargin(20),
                  ],
                );
              }
            }
          )
        ],
      ),
      body: WebView(
        gestureNavigationEnabled: true,
        initialUrl: widget.initialUrl,
        initialMediaPlaybackPolicy: AutoMediaPlaybackPolicy.require_user_action_for_all_media_types,
        javascriptMode: JavascriptMode.unrestricted,
        onWebViewCreated: (WebViewController controller){
          _webViewController.complete(controller);
        },
      ),
    );
  }
}
