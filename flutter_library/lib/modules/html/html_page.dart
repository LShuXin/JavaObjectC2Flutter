import 'dart:io';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';

import '../../env.dart';
import '../../widgets/myappbar.dart';
import '../../utils/style.dart';
import '../../states/states.dart';


class HtmlPage extends StatefulWidget {
    final String title;
    final String url;

    HtmlPage(Map<String, dynamic> args)
            : title = args['title'] ?? '',
              url = args['url'];

    @override
    _HtmlPageState createState() => _HtmlPageState();
}

class _HtmlPageState extends State<HtmlPage> {
    WebViewController? _controller;
    String _title = '';

    @override
    void initState() {
        super.initState();
        // Enable hybrid composition.
        if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    }

    _onPageFinished(String url) async {
        //使用_controller!.getTitle()在html异步设置title时无法获取
        //安卓使用_controller!.getTitle()：如果返回的是301/302跳转，获取到的title会是目标url
        _controller!.evaluateJavascript('document.title').then((result){
            RegExp re = RegExp(r'^["](.*)["]$');
            RegExpMatch? mres = re.firstMatch(result);
            if (mres != null) {
                _title = mres.group(1)!;
            } else if (result.isNotEmpty) {
                _title = result;
            }
            if (mounted) {
                setState(() {});
            }
        });
    }

    @override
    Widget build(BuildContext context) {
        bool canPop = Navigator.of(context).canPop();

        //添加语言
        String url = widget.url;
        if (url.startsWith('/') ) {
            url = Env.host + url;
        }

        return Scaffold(
            appBar: MyAppBar(
                title: _title,
                bgColor: [],
                enableBack: canPop,
                actions: [
                    if (!canPop) IconButton(
                        icon: Icon(Icons.home),
                        onPressed: () => Navigator.of(context).pushReplacementNamed('app://home')
                    ),
                ],
            ),
            body: WebView(
                //userAgent: 'Mozilla/5.0',
                onPageFinished: _onPageFinished,
                initialUrl: url,
                javascriptMode: JavascriptMode.unrestricted,
                onWebViewCreated: (WebViewController controller) {
                    _controller = controller;
                },
            ),
        );
    }
}
