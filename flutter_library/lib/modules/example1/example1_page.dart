import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

import '../../widgets/myappbar.dart';


class Example1Page extends StatefulWidget {

    const Example1Page(Map<String, dynamic> args);

    @override
    _Example1State createState() => _Example1State();
}

class _Example1State extends State<Example1Page> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: MyAppBar(
                title: 'Example1',
                bgColor: [],
            ),
            body: Column(
                children: [],
            ),
        );
    }
}
