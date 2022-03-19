import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyIcon extends StatelessWidget {
    final String name;
    final double size;
    final Color? color;
    final Alignment? alignment;
    MyIcon(this.name, {double? size, this.color, this.alignment = Alignment.center}) : this.size = size ?? 24.w;

    @override
    Widget build(BuildContext context) {
        return Container(
            child: SvgPicture.asset(
                'assets/icons/$name.svg',
                color: color,
                height: size,
                width: size,
            ),
            height: size,
            width: size,
            alignment: alignment,
        );
    }
}
