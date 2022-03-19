import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:provider/provider.dart';

import '../../utils/style.dart';
import '../../states/states.dart';

Widget buildRefreshFooter(BuildContext context, {Map<LoadStatus, Widget?> footersBindStatus = const {}, double footerHeight = 40}) {
    if (footersBindStatus[LoadStatus.idle] == null) {
        footersBindStatus[LoadStatus.idle] = Text("", style: FontStyle.sLight);
    }
    if (footersBindStatus[LoadStatus.canLoading] == null) {
        footersBindStatus[LoadStatus.canLoading] = Text("下拉刷新", style: FontStyle.sLight);
    }
    if (footersBindStatus[LoadStatus.loading] == null) {
        footersBindStatus[LoadStatus.loading] = CupertinoActivityIndicator();
    }
    if (footersBindStatus[LoadStatus.failed] == null) {
        footersBindStatus[LoadStatus.failed] = Text("Faild", style: FontStyle.sLight);
    }
    if (footersBindStatus[LoadStatus.noMore] == null) {
        footersBindStatus[LoadStatus.noMore] = Text("No More", style: FontStyle.sLight);
    }

    return CustomFooter(
        builder: (BuildContext context, LoadStatus? mode) {
            Widget? body;

            if (mode == null || footersBindStatus[mode] == null) {
                body = Container();
            } else {
                body = footersBindStatus[mode];
            }

            return Container(
                child: body,
                height: footerHeight,
                alignment: Alignment.center,
            );
        },
    );
}

Widget buildRefreshHeader(BuildContext context) {
    return WaterDropHeader(
        // refresh: ,
        complete: Text("刷新成功", style: FontStyle.xsLight),
        // failed: ,
        // completeDuration: ,
        waterDropColor: appTheme['themeColor'],
    );
}
