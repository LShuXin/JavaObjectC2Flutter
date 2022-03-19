import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Indicator {
    static Widget pullDownRefresh() {
        return Center(
            child: Container(
                width: 480.w,
                height: 109.r,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/loading.gif'),
                        fit: BoxFit.fill,
                    )
                ),
            ),
        );
    }

    static Widget loading() {
        return Center(
            child: Container(
                width: 480.w,
                height: 109.r,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/images/loading.gif'),
                        fit: BoxFit.fill,
                    )
                ),
            ),
        );
    }
}