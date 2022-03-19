import 'package:flutter/material.dart';
import '../utils/style.dart';


class MyDivider {
    static Widget buildHorizontalDivider({double height = 1, double? thickness, double indent = 0, double endIndent = 0}) {
        return Divider(
            color: FontColor.fontColorLightExtremely,
            height: height,
            thickness: thickness,
            indent: indent,
            endIndent: endIndent,
        );
    }

    static Widget buildVerticalDivider({double width = 1, double thickness = 1, double indent = 0, double endIndent = 0}) {
        return VerticalDivider(
            color: FontColor.fontColorLightExtremely,
            width: width,
            thickness: thickness,
            indent: indent,
            endIndent: endIndent,
        );
    }
}
