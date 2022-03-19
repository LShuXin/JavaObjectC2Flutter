import 'dart:io';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter/platform_interface.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './helper.dart';
import '../../env.dart';
import '../../widgets/myicon.dart';
import '../../widgets/myappbar.dart';
import '../../utils/myfetch.dart';
import '../../states/states.dart';


double toDouble(dynamic v, double d) => v is String ? double.parse(v) : (v is double ? v : d);

class H5MapPage extends StatefulWidget {
    final String title;
    final double lat;
    final double lng;
    final bool isLocationChosen;

    H5MapPage(Map<String, dynamic> args)
        : title = args['title'] ?? '',
          lng = toDouble(args['lng'], 116.39145),
          lat = toDouble(args['lat'], 39.907325),
          isLocationChosen = args['isLocationChosen'];

    @override
    _H5MapPageState createState() => _H5MapPageState();
}

class _H5MapPageState extends State<H5MapPage> with H5Mixin {
    final String _url = '/html/h5map/';
    String _title = '';
    WebViewController? _controller;

    @override
    void initState() {
        super.initState();
        _title = widget.title;

        // Enable hybrid composition.
        if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    }

    _onPageStarted(String url) {
    }

    _onPageFinished(String url) async {
        _title = await getTitle(_controller!) ?? widget.title;
        if (mounted) {
            setState(() {});
        }
    }

    _onWebResourceError(WebResourceError error) {
        print(error);
    }

    _onMsgFromRpcChan(JavascriptMessage msg) async {
        Map<String, dynamic> obj = jsonDecode(msg.message);
        String func = obj['func'];
        String uuid = obj['uuid'];
        Map<String, dynamic> kwargs = obj['kwargs'];
        switch (func) {
            case 'debug':
                print('DEBUG: ${jsonEncode(kwargs)}');
                await onReplyToRpcChan(uuid, _controller!, null);
                break;
            case 'get_hosts':
                await onReplyToRpcChan(uuid, _controller!, getHost());
                break;
            case 'set_result_and_exit':
                Navigator.of(context).pop({});
                break;
            default:
                onReplyToRpcChan(uuid, _controller!, null);
        }
    }

    @override
    Widget build(BuildContext context) {

        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: MyAppBar(
                title: _title,
                bgColor: [],
                actions: [
                    IconButton(
                        icon: MyIcon('dots', size: 22.w, color: Colors.white),
                        onPressed: () => onPopupRefreshBottomSheet(context, _controller!),
                    ),
                ],
            ),
            body: WebView(
                debuggingEnabled: debuggingEnabled,
                initialUrl: getInitialUrl(_url),
                javascriptMode: JavascriptMode.unrestricted,
                onPageStarted: _onPageStarted,
                onPageFinished: _onPageFinished,
                onWebResourceError: _onWebResourceError,
                onWebViewCreated: (WebViewController controller) {
                    _controller = controller;
                },
                javascriptChannels: {
                    JavascriptChannel(name: 'RpcChan', onMessageReceived: _onMsgFromRpcChan),
                },
            ),
        );
    }
}
