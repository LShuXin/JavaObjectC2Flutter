import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:collection/collection.dart';

import '../utils/style.dart';
import '../widgets/myicon.dart';

class Tips {
    static const durationTiny = Duration(microseconds: 200);
    static const durationNormal = Duration(milliseconds: 1000);
    static const durationLong = Duration(milliseconds: 2000);

    static toast(String title, {Color bgColor = infoColor, Color textColor = Colors.white}) {
        Fluttertoast.showToast(
            msg: title,
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: bgColor,
            textColor: textColor,
            fontSize: FontSize.fontSizeNormal,
        );
    }

    static info(BuildContext context, String title, {ToastGravity gravity = ToastGravity.CENTER}) {
        FToast fToast = FToast();
        fToast.init(context);
        fToast.showToast(
            child: wrapInfo(title),
            gravity: gravity,
            toastDuration: const Duration(milliseconds: 1000),
        );
    }

    static success(BuildContext context, String title, {ToastGravity gravity = ToastGravity.CENTER, Color color = successColor}) {
        FToast fToast = FToast();
        fToast.init(context);
        fToast.showToast(
            child: wrapSuccess(title, color: color),
            gravity: gravity,
            toastDuration: durationNormal,
        );
    }

    static warn(BuildContext context, String title, {ToastGravity gravity = ToastGravity.CENTER}) {
        FToast fToast = FToast();
        fToast.init(context);
        fToast.showToast(
            child: wrapWarn(title),
            gravity: gravity,
            toastDuration: durationNormal,
        );
    }

    static error(BuildContext context, String title, {ToastGravity gravity = ToastGravity.CENTER}) {
        FToast fToast = FToast();
        fToast.init(context);
        fToast.showToast(
            child: wrapError(title),
            gravity: gravity,
            toastDuration: durationNormal,
        );
    }

    /// btns: 为按钮的名字，*打头表示为primary按钮，*不会被显示；
    /// dismissible 表示点击空白区域是否关闭对话框；
    /// 返回: 点击的按钮索引号或null，null表示点了空白区。
    static confirm(BuildContext context, String description, {List<String> btns = const ['取消', '*确定'], dismissible: true, Color primaryColor = successColor}) async {

        TextStyle primaryTextStyle = TextStyle(
            fontSize: FontSize.fontSizeNormal,
            color: primaryColor,
        );

        return await showDialog(
            context: context,
            barrierDismissible: dismissible,
            builder: (context) => AlertDialog(
                content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Flexible(
                            child: Text(
                                description,
                                textAlign: TextAlign.center,
                                style: FontStyle.normalMain,
                            )
                        )
                    ],   // bugfix:  换行
                ),
                actions: [
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: btns.mapIndexed((idx, name) => OutlinedButton(
                                child: name.startsWith('*')
                                    ? Text(name.substring(1), style: FontStyle.normalWhite)
                                    : Text(name, style: primaryTextStyle),
                                style: ButtonStyle(
                                    side: MaterialStateProperty.all(BorderSide(
                                        width: 1,
                                        color: primaryColor,
                                    )),
                                    backgroundColor: name.startsWith('*')
                                        ? MaterialStateProperty.all(primaryColor)
                                        : null,
                                ),
                                onPressed: () => Navigator.of(context).pop(idx)
                            )).toList(),
                        ),
                        width: 1.sw,
                    ),
                ],
            ),
        );
    }

    static msgConfirm(BuildContext context, String description, {List<String> btns = const ['取消', '删除', '*确定'], dismissible: true, Color primaryColor = successColor}) async {

        TextStyle primaryTextStyle = TextStyle(
            fontSize: FontSize.fontSizeNormal,
            color: primaryColor,
        );

        return await showDialog(
            context: context,
            barrierDismissible: dismissible,
            builder: (context) => AlertDialog(
                content: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [Text(description, style: FontStyle.normalMain)],
                ),
                actions: [
                    Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: btns.mapIndexed((idx, name) => OutlinedButton(
                                child: name.startsWith('*')
                                    ? Text(name.substring(1), style: FontStyle.normalWhite)
                                    : Text(name, style: primaryTextStyle),
                                style: ButtonStyle(
                                    side: MaterialStateProperty.all(BorderSide(
                                        width: 1,
                                        color: primaryColor,
                                    )),
                                    backgroundColor: name.startsWith('*')
                                        ? MaterialStateProperty.all(primaryColor)
                                        : null,
                                ),
                                onPressed: () => Navigator.of(context).pop(idx)
                            )).toList(),
                        ),
                        width: 1.sw,
                    ),
                ],
            ),
        );
    }

    static Widget wrapInfo(String title) {
        return Center(
            child: Column(
                children: [
                    Row(
                        children: [
                            Container(
                                child: Row(
                                    children: [
                                        ConstrainedBox(
                                            child: Text(title, style: FontStyle.normalWhite),
                                            constraints: BoxConstraints(
                                                maxWidth: .6.sw,
                                            ),
                                        ),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                                padding: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 12.w),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.w),
                                    color: infoColor,
                                ),
                            ),
                        ],
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                ],
                mainAxisSize: MainAxisSize.min,
            ),
        );
    }

    static Widget wrapSuccess(String title, {Color color = successColor}) {
        return Center(
            child: Column(
                children: [
                    Row(
                        children: [
                            Container(
                                child: Row(
                                    children: [
                                        Container(
                                            child: MyIcon(
                                                'toast-success',
                                                size: 11.w,
                                                color: color,
                                            ),
                                            width: 22.w,
                                            height: 22.w,
                                            margin: EdgeInsets.only(right: 8.w),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(11.w),
                                            ),
                                        ),
                                        ConstrainedBox(
                                            child: Text(title, style: FontStyle.normalWhite),
                                            constraints: BoxConstraints(
                                                maxWidth: .6.sw,
                                            ),
                                        ),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                                padding: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 12.w),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.w),
                                    color: color,
                                ),
                            ),
                        ],
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                ],
                mainAxisSize: MainAxisSize.min,
            ),
        );
    }

    static Widget wrapWarn(String title) {
        return Center(
            child: Column(
                children: [
                    Row(
                        children: [
                            Container(
                                child: Row(
                                    children: [
                                        Container(
                                            child: MyIcon(
                                                'toast-warn',
                                                size: 11.w,
                                                color: warnColor,
                                            ),
                                            width: 22.w,
                                            height: 22.w,
                                            margin: EdgeInsets.only(right: 8.w),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(11.w),
                                            ),
                                        ),
                                        ConstrainedBox(
                                            child: Text(title, style: FontStyle.normalWhite),
                                            constraints: BoxConstraints(
                                                maxWidth: .6.sw,
                                            ),
                                        ),
                                    ],
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                                padding: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 12.w),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.w),
                                    color: warnColor,
                                ),
                            ),
                        ],
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                    ),
                ],
                mainAxisSize: MainAxisSize.min,
            ),
        );
    }

    static Widget wrapError(String title) {
        return Center(
            child: Column(
                children: [
                    Row(
                        children: [
                            Container(
                                child: Row(
                                    children: [
                                        Container(
                                            child: MyIcon(
                                                'toast-error',
                                                size: 11.w,
                                                color: errColor,
                                            ),
                                            width: 22.w,
                                            height: 22.w,
                                            margin: EdgeInsets.only(right: 8.w),
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(11.w),
                                            ),
                                        ),
                                        ConstrainedBox(
                                            child: Text(title, style: FontStyle.normalWhite),
                                            constraints: BoxConstraints(
                                                maxWidth: .6.sw,
                                            ),
                                        ),
                                    ],
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                ),
                                padding: EdgeInsets.fromLTRB(16.w, 12.w, 16.w, 12.w),
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5.w),
                                    color: errColor,
                                ),
                            ),
                        ],
                        mainAxisSize: MainAxisSize.min,
                    ),
                ],
                mainAxisSize: MainAxisSize.min,
            ),
        );
    }
}
