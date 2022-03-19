import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'myicon.dart';
import '../utils/style.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
    // 中间的标题
    final String? title;
    final double contentHeight;
    // 是否允许返回
    final bool enableBack;
    final bool isShadowEnable;
    // 右侧的工具菜单（常用的，不显示为...）
    final List<Widget> actions;
    // 返回上一层时传回的数据
    final dynamic args;
    final List<Color> bgColor;
    // 左侧的返回按钮等
    final Widget? leading;
    // 用于设置返回图标的颜色
    final Color? leadingColor;
    final Color? titleColor;
    final SystemUiOverlayStyle? brightness;
    final double? elevation;

    MyAppBar({this.title, this.enableBack = true, this.isShadowEnable = true, this.actions = const[], this.args, this.bgColor = const [], this.leading = null,
        this.leadingColor, this.brightness = SystemUiOverlayStyle.light, this.elevation = 1, this.titleColor = Colors.white, contentHeight,
    }) : this.contentHeight = contentHeight ?? 45.w;
    @override
    Size get preferredSize => Size.fromHeight(contentHeight);

    @override
    Widget build(BuildContext context) {
        Widget? leadingIcon;
        if (leading != null) {
            leadingIcon = leading;
        } else if (enableBack && Navigator.of(context).canPop()) {
            leadingIcon = IconButton(
                icon: MyIcon('go-back', size: 22.w, color: leadingColor ?? Colors.white),
                onPressed: () => Navigator.of(context).pop(args),
                padding: EdgeInsets.symmetric(horizontal: 8.w),
            );
        } else {
            leadingIcon = null;
        }

        return AppBar(
            systemOverlayStyle: brightness,
            flexibleSpace: Container(
                decoration: BoxDecoration(
                    gradient: bgColor.length >= 2
                    ? LinearGradient(
                        colors: [bgColor[0], bgColor[1]],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                    )
                    : null,
                ),
            ),
            // 左侧返回按钮
            leading: leadingIcon,
            leadingWidth: 56.w,
            toolbarHeight: 45.w,     // 标题以上的工具栏高度
            shadowColor: isShadowEnable ? null : Colors.transparent,
            title: Text(
                title ?? '',
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: FontSize.fontSizeL,
                    color: titleColor,
                ),
            ),
            elevation: elevation,
            centerTitle: true,
            // 右侧非折叠工具菜单
            actions: actions,
            backgroundColor: bgColor.length == 1 ? bgColor[0] : null,
        );
    }
}
