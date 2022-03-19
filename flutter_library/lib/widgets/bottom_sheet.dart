import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

typedef OnItemClickListener = void Function(int index);

class BottomSheetWidget extends StatefulWidget {
    const BottomSheetWidget({Key? key, required this.list, required this.onItemClickListener})
        : super(key: key);

    final list;
    final OnItemClickListener onItemClickListener;

    @override
    _BottomSheetWidgetState createState() => _BottomSheetWidgetState();
}

class _BottomSheetWidgetState extends State<BottomSheetWidget> {
    final _textStyle = TextStyle(
        fontWeight: FontWeight.normal,
        decoration: TextDecoration.none,
        color: Color(0xFF333333),
        fontSize: 18.sp
    );

    @override
    Widget build(BuildContext context) {
        int listLength = widget.list.length;
        // 最后还有一个cancel，所以加1
        int itemCount = listLength + 1;
        int height = (listLength + 1) * 48;
        //取消按钮
        var cancelContainer = GestureDetector(
            child: Container(
                height: 44.w,
                margin: EdgeInsets.symmetric(horizontal: 10.w),
                decoration: BoxDecoration(
                    color: Colors.white, // 底色
                    borderRadius: BorderRadius.circular(10.w),
                ),
                child: Center(child: Text(
                    "取消",
                    style: _textStyle,
                )),
            ),
            onTap: () => Navigator.of(context).pop(),
        );
            //整个按钮列表
        var listview = ListView.builder(
            itemCount: itemCount,
            itemBuilder: (ctx, idx) {
                if (idx == itemCount - 1) {
                    return Container(
                        child: cancelContainer,
                        margin: EdgeInsets.only(top: 6.w),
                    );
                }
                return _buildItemContainer(context, idx, listLength);
            }
        );
        var totalContainer = Container(
            child: listview,
            height: ScreenUtil().setWidth(height),
            width: 0.98.sw,
        );
        return Stack(
            alignment: Alignment.center,
            children: [
                Positioned(
                    bottom: 0,
                    child: totalContainer,
                ),
            ],
        );
    }

    Widget _buildItemContainer(BuildContext context, int index, int listLength) {
        var contentText = Text(
            widget.list[index],
            style: _textStyle,
        );

        var decoration;
        if (listLength == 1) {
            decoration = BoxDecoration(
                color: Colors.white, // 底色
                borderRadius: BorderRadius.circular(10.w),
                border: Border.all(width: 0.5.w, color: Color(0xffe5e5e5)),
            );
        } else if (listLength > 1) {
            if (index == 0) {
                decoration = BoxDecoration(
                    color: Colors.white, // 底色
                    borderRadius: BorderRadius.only(topLeft: Radius.circular(10.w), topRight: Radius.circular(10.w)),
                    border: Border.all(width: 0.5.w, color: Color(0xffe5e5e5)),
                );
            } else if (index == listLength - 1) {
                decoration = BoxDecoration(
                    color: Colors.white, // 底色
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.w), bottomRight: Radius.circular(10.w)),
                    border: Border.all(width: 0.5.w, color: Color(0xffe5e5e5)),
                );
            } else {
                decoration = BoxDecoration(
                    color: Colors.white, // 底色
                    border: Border.symmetric(
                        vertical: BorderSide(width: 0.5.w, color: Colors.white),
                        horizontal: BorderSide(width: 0.5.w, color: Color(0xffe5e5e5)),
                    ),
                );
            }
        }
        var itemContainer = Container(
            height: 44.w,
            margin: EdgeInsets.symmetric(horizontal: 10.w),
            decoration: decoration,
            child: Center(child: contentText),
        );

        return GestureDetector(
            onTap: () => widget.onItemClickListener(index),
            child: itemContainer,
        );
    }
}
