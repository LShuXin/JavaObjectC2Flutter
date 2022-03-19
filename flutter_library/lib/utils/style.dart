import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


const Color successColor = Color(0xFF5CB85C);

const Color errColor = Color(0xFFFF5052);

const Color warnColor = Color(0xFFFEA941);

const Color infoColor = Color.fromARGB(159, 0, 0, 0);

class DeviceInfo {
    static final deviceWidthPx = window.physicalSize.width;
    static final deviceHeightPx = window.physicalSize.height;
    //window.devicePixelRatio: 每一逻辑像素包含多少物理像素
    static final deviceWidthDb =  deviceWidthPx / window.devicePixelRatio;
    static final deviceHeightDb = deviceHeightPx / window.devicePixelRatio;
    static final ratio = deviceWidthDb / 375;
    static final aspectRatio = deviceWidthPx / deviceHeightPx;
}

const Map<String, dynamic> appTheme = {
    'themeColor': Color(0xFFC587FA),
    'primarySwatch' : MaterialColor(0xFFC587FA, {
        50:  Color(0xFFDFBDFC),
        100: Color(0xFFDCB7FC),
        200: Color(0xFFD6ABFC),
        300: Color(0xFFD19FFB),
        400: Color(0xFFCB93FA),
        500: Color(0xFFC587FA),
        600: Color(0xFFB179E1),
        700: Color(0xFF9E6CC8),
        800: Color(0xFF8A5EAF),
        900: Color(0xFF765196)
    }),
};

class BgColor {
    static const bgColorMain = Color(0xFFEFEFF4);
    static const bgColorWhite = Color(0xFFFFFFFF);
    static const bgColorGrey = Color(0xFFF4F4F4);
}

class FontColor {
    static const fontColorMain = Color(0xFF3E4857);
    static const fontColorMainTitle = Color(0xFF2a2939);
    static const fontColorLight = Color(0xFF9A9CA9);
    static const fontColorLightMore = Color(0xFFE4E4E4);
    static const fontColorLightExtremely = Color(0xFFE5E5E5);
    static const fontColorWhite = Color(0xFFFFFFFF);
}

class FontSize {
    static final fontSizeXS = 11.sp;
    static final fontSizeS = 12.sp;
    static final fontSizeNormal = 14.sp;
    static final fontSizeM = 16.sp;
    static final fontSizeL = 18.sp;
    static final fontSizeXL = 20.sp;
}

class FontStyle {
    static final xsLight = TextStyle(
        color: FontColor.fontColorLight,
        fontSize: FontSize.fontSizeXS,
    );

    static final sLight = TextStyle(
        color: FontColor.fontColorLight,
        fontSize: FontSize.fontSizeS,
    );

    static final normalLight = TextStyle(
        color: FontColor.fontColorLight,
        fontSize: FontSize.fontSizeNormal,
    );

    static final mLight = TextStyle(
        color: FontColor.fontColorLight,
        fontSize: FontSize.fontSizeM,
    );

    static final lLight = TextStyle(
        color: FontColor.fontColorLight,
        fontSize: FontSize.fontSizeL,
    );

    static final xlLight = TextStyle(
        color: FontColor.fontColorLight,
        fontSize: FontSize.fontSizeXL,
    );

    static final xsMain = TextStyle(
        color: FontColor.fontColorMain,
        fontSize: FontSize.fontSizeXS,
    );

    static final sMain = TextStyle(
        color: FontColor.fontColorMain,
        fontSize: FontSize.fontSizeS,
    );

    static final normalMain = TextStyle(
        color: FontColor.fontColorMain,
        fontSize: FontSize.fontSizeNormal,
    );

    static final mMain = TextStyle(
        color: FontColor.fontColorMain,
        fontSize: FontSize.fontSizeM,
    );

    static final lMain = TextStyle(
        color: FontColor.fontColorMain,
        fontSize: FontSize.fontSizeL,
    );

    static final xlMain = TextStyle(
        color: FontColor.fontColorMain,
        fontSize: FontSize.fontSizeXL,
    );

    static final xsWhite = TextStyle(
        color: FontColor.fontColorWhite,
        fontSize: FontSize.fontSizeXS,
    );

    static final sWhite = TextStyle(
        color: FontColor.fontColorWhite,
        fontSize: FontSize.fontSizeS,
    );

    static final normalWhite = TextStyle(
        color: FontColor.fontColorWhite,
        fontSize: FontSize.fontSizeNormal,
    );

    static final mWhite = TextStyle(
        color: FontColor.fontColorWhite,
        fontSize: FontSize.fontSizeM,
    );

    static final lWhite = TextStyle(
        color: FontColor.fontColorWhite,
        fontSize: FontSize.fontSizeL,
    );

    static final xlWhite = TextStyle(
        color: FontColor.fontColorWhite,
        fontSize: FontSize.fontSizeXL,
    );

    static final mMainTitle = TextStyle(
        color: FontColor.fontColorMainTitle,
        fontSize: FontSize.fontSizeM,
    );

    static final normalMainTitle = TextStyle(
        color: FontColor.fontColorMainTitle,
        fontSize: FontSize.fontSizeNormal,
    );
}





