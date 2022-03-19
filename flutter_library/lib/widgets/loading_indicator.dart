import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget loadingIndicator = Container(
    child: Center(
        child: CupertinoActivityIndicator(),
    ),
    width: double.infinity,
    height: 1.sh,
);