import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = ['m.ctrip.com/', 'm.ctrip.com/html5/', 'm.ctrip.com/html5'];

class WebView extends StatefulWidget {
  final String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  const WebView(
      {Key key,
      this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid = false,
      })
      : super(key: key);

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final webviewReference = FlutterWebviewPlugin();
  StreamSubscription<String> _onUrlChanged;
  StreamSubscription<WebViewStateChanged> _onStateChanged;
  StreamSubscription<WebViewHttpError> _onStateError;
  bool exiting = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //防止页面再次打开

    //url变化监听
    webviewReference.close();

    _onUrlChanged = webviewReference.onUrlChanged.listen((String url) {});

    //加载监听
    _onStateChanged =
        webviewReference.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          if (_isToMain(state.url) && !exiting) {
            if (widget.backForbid) {
              webviewReference.launch(widget.url);
            }else {
              Navigator.pop(context);
              exiting = true;
            }
          }
          break;
        default:
          break;
      }
    });
    //webview打开错误
    _onStateError =
        webviewReference.onHttpError.listen((WebViewHttpError error) {
      print(error.toString());
    });
  }

  _isToMain(String url) {
    bool contain = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        contain = true;
        break;
      }
    }
    return contain;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _onUrlChanged.cancel();
    _onStateChanged.cancel();
    _onUrlChanged.cancel();
    _onStateError.cancel();
    webviewReference.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColors;
    if (statusBarColorStr == 'ffffff') {
      backButtonColors = Colors.black;
    } else {
      backButtonColors = Colors.white;
    }

    return new Scaffold(
      body: new Column(
        children: <Widget>[
          _appBar(
              Color(int.parse('0xff' + statusBarColorStr)), backButtonColors),
          Expanded(
            child: WebviewScaffold(
              url: widget.url,
              withZoom: true,
              withLocalStorage: true,
              hidden: true,
              initialChild: Container(
                ///正在加载webview
                color: Colors.white,
                child: new Center(
                  child: new Text('正在加载...'),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColors) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      color: backgroundColor,
      padding: EdgeInsets.fromLTRB(0, 40,0, 10),
      child: FractionallySizedBox(
        widthFactor: 1,
        child: Stack(
          children: <Widget>[
            GestureDetector(
              onTap: (){
                Navigator.pop(context);
              },
              child: Container(
                margin: EdgeInsets.only(left: 10),
                child: Icon(
                  Icons.close,
                  color: backButtonColors,
                  size: 26,
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                child: new Center(
                  child: new Text(
                    widget.title ?? '',
                    style: TextStyle(color: backButtonColors, fontSize: 20),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
