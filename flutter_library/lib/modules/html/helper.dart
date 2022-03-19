import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../env.dart';
import '../../widgets/bottom_sheet.dart';
import '../../utils/myfetch.dart';


mixin H5Mixin<T extends StatefulWidget> on State<T> {
    final bool debuggingEnabled = false;

    String getInitialUrl(String url) {
        return Env.host + url;
    }

    Map<String, dynamic> getHost() {
        return {'host': Env.host, 'cdn_host': Env.cdnHost};
    }

    Future onReplyToRpcChan(uuid, WebViewController controller, dynamic res) async {
        String reply = jsonEncode({'res': res}).replaceAll('\'', '\\\'');
        try {
            return await controller.evaluateJavascript("window.set_rpc_result && set_rpc_result('$uuid', '${RegExp.escape(reply)}')");
        } catch (_) {
            // pass
        }
    }

    Future<String?> getTitle(WebViewController controller) async {
        String title = await controller.evaluateJavascript('document.title');
        RegExp re = RegExp(r'^["](.*)["]$');
        RegExpMatch? mRes = re.firstMatch(title);
        if (mRes != null) {
            return mRes.group(1)!;
        }
        return title;
    }

    onPopupRefreshBottomSheet(BuildContext context, WebViewController controller) async {
        await showDialog(
            barrierDismissible: true,
            context: context,
            builder: (ctx) => BottomSheetWidget(
                list: const ['刷新'],
                onItemClickListener: (idx) async {
                    if (idx == 0) {
                        await controller.clearCache();
                    }
                    if (mounted) {
                        Navigator.of(context).pop();
                    };
                }
            ),
        );
    }
}
