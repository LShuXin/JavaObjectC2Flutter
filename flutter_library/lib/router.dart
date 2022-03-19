import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


import 'modules/example1/example1_page.dart';
import 'modules/example2/example2_page.dart';

import 'modules/html/html_page.dart';
import 'modules/html/h5map_page.dart';

import './states/states.dart';
import './utils/misc.dart';
import './env.dart';


class MyRouter {
    static final Map<String, Tuple2<String?, Function>> routes = {
        'app://example1': Tuple2('+', (kwargs) => Example1Page(kwargs)),                  //Example1
        'app://example2': Tuple2('+', (kwargs) => Example2Page(kwargs)),                  //Example2
        'app://html': Tuple2('+', (kwargs) => HtmlPage(kwargs)),                          //Html
        'app://h5map': Tuple2('+', (kwargs) => H5MapPage(kwargs)),                        //Map
    };
    static String get initialRoute => Env.initialRoute;
    static final RouteFactory generateRoute = (settings) {
        Map<String, dynamic> params = settings.arguments == null ? Map<String, dynamic>() : settings.arguments as Map<String, dynamic>;

        if (settings.name!.startsWith('http') || settings.name!.startsWith('/')) {
            return MaterialPageRoute(
                builder: (ctx) => HtmlPage({'url': settings.name, ...params}),
                settings: settings,
            );
        } else if (settings.name!.startsWith('app:')) {
            String path = settings.name!;
            int end = path.indexOf('?');
            if (end != -1) {
                String querySubstr = settings.name!.substring(end + 1).trim();
                path = path.substring(0, end);
                if (querySubstr != '') {
                    params.addAll(Uri.splitQueryString(querySubstr));
                }
            }
            Tuple2? creator = MyRouter.routes[path];
            if (creator == null) {
                return null;
            }
            return MaterialPageRoute(
                builder: (ctx) {
                    return creator.item2(params);
                },
                settings: settings,
                fullscreenDialog: false,
            );
        }
        return null;
    };
    static final RouteFactory unknownRoute = (settings) {
        return MaterialPageRoute(
            builder: (ctx) => Example1Page({}),
            settings: settings,
        );
    };
}
