import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/myappbar.dart';
import '../../utils/style.dart';


class Example2Page extends StatefulWidget {

    Example2Page(Map<String, dynamic> args);

    @override
    _Example2State createState() => _Example2State();
}

class _Example2State extends State<Example2Page> {

    @override
    void initState() {
        super.initState();
    }

    @override
    Widget build(BuildContext context) {
        // var info = Provider.of<UserInfo>(context, listen: false);

        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: MyAppBar(
                title: "Example2",
                bgColor: [],
            ),
            body: Column(
                children: [],
            ),
            backgroundColor: BgColor.bgColorGrey
        );
    }
}
