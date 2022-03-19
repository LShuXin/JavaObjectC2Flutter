import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:math';
import 'dart:async';
import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:path_provider/path_provider.dart';

import './utils/http_overrides.dart';
import './utils/kv.dart';
import './utils/style.dart';
import './utils/myfetch.dart';
import './states/states.dart';
import './env.dart';
import './router.dart';
import 'dart:ui';

void main() => runApp(_widgetForRoute(window.defaultRouteName));

Widget _widgetForRoute(String route) {
  print('=================================');
  print(route);
  switch (route) {
    default:
      return MaterialApp(
        home: Scaffold(
          backgroundColor: const Color(0xFFD63031),//ARGB红色
          body: Center(
            child: Text(
              'Hello from Flutter', //显示的文字
              textDirection: TextDirection.ltr,
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.blue,
              ),
            ),
          ),
        ),
      );
  }
}




class ProviderWrapper extends StatelessWidget {
  final Widget child;
  const ProviderWrapper({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserInfo(), lazy: false),
      ],
      child: child,
    );
  }
}

class MyNavigator extends NavigatorObserver {
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
  }
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    debugPaintSizeEnabled = false;
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      builder: () => MaterialApp(
        title: Env.appName,
        theme: ThemeData(
          primarySwatch: appTheme['primarySwatch'],
          highlightColor: const Color.fromRGBO(0, 0, 0, 0),
          splashColor: const Color.fromRGBO(0, 0, 0, 0),
          visualDensity: VisualDensity.adaptivePlatformDensity,
          disabledColor: const Color(0XFFF4F4F4),
        ),
        navigatorObservers: [MyNavigator()],
        initialRoute: MyRouter.initialRoute,
        onGenerateRoute: MyRouter.generateRoute,
        onUnknownRoute: MyRouter.unknownRoute,
      ),
    );
  }
}

gInit() async {}

appMain({required String channel}) async {
  HttpOverrides.global = MyHttpOverrides();

  var bindingInstance = WidgetsFlutterBinding.ensureInitialized();

  SystemChannels.keyEvent.setMessageHandler((dynamic message) async {
    try {
      return await bindingInstance.keyEventManager.handleRawKeyMessage(message);
    } catch (e) {}
  });

  await Env.initialize(channel: channel);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  Directory appDocDir = await getApplicationDocumentsDirectory();
  String keyPrefix = md5.convert(utf8.encode(Env.host)).toString().substring(0, 8);
  await KvLocalStorage.initialize(appDocDir.path, keyPrefix);
  await Future.wait([MyFetch.initialize(appDocPath: appDocDir.path)]);

  Env.gInitFuture = gInit();

  runApp(ProviderWrapper(child: MyApp()));
}

