import 'package:shared_preferences/shared_preferences.dart';

class Env {
    static Future<void> initialize({required String channel}) async {
        final prefs = await SharedPreferences.getInstance();
        Env._envIdx = prefs.getInt('env_index') ?? 0;
        if (Env._envIdx! >= Env.envOptions.length) {
            Env._envIdx = 0;
        }
        Env._envIdx = 1;
        Env._host = Env.envOptions[envIdx]['host']!;
        Env._cdnHost = Env.envOptions[envIdx]['cdnHost']!;
        Env._isOnline = envIdx == 0;
        Env._channel = channel;
    }

    static Future<void> onEnvSwitch(int? envIdx) async {
        if (envIdx == null) {
            return;
        }
        if (envIdx == _envIdx) {
            return;
        }
        if (envIdx < 0 || envIdx >= Env.envOptions.length) {
            return;
        }
        final prefs = await SharedPreferences.getInstance();
        prefs.setInt('env_index', envIdx);
    }

    static Future? _gInitFuture;
    static set gInitFuture(fu) => _gInitFuture = fu;
    static get gInitFuture => _gInitFuture;

    static int? _envIdx;
    static int get envIdx => _envIdx!;
    static String? _host;
    static String get host => _host!;
    static String? _cdnHost;
    static String get cdnHost => _cdnHost!;
    static bool? _isOnline;
    static bool get isOnline => _isOnline!;

    static final List<Map<String, String>> envOptions = [{
        'name': '线上环境',
        'host': 'http://androidbasedflutterdemo.lsx.com',
        'cdnHost': 'http://androidbasedflutterdemocdn.lsx.com',
    }, {
        'name': '测试环境',
        'host': 'http://androidbasedflutterdemo.lsx.com',
        'cdnHost': 'http://androidbasedflutterdemocdn.lsx.com',
    }];

    static const String aliQuickLoginKeyAndroid = '';

    static const String aliQuickLoginKeyIos = '';

    static int serverPort = 0;

    static const String appName = 'AndroidBasedFlutterDemo';

    static const String initialRoute = 'app://launch?target=app://test';

    static const String officialUrl = 'http://androidbasedflutterdemo.lsx.com';

    static const int itmsAppsId = 0;

    static String? _channel;
    static String get channel => _channel!;

    static const String salt = '';

    static const String configName = 'app';

    static const String defaultOfficialAvatar = '/static/img/androidbasedflutterdemo-logo.png';

    static final Map<String, dynamic> h5Pages = {
        'h5_name_01': {
            'title': '',
            'url': '/'
        },
        'h5_name_02': {
            'title': '',
            'url': '/'
        }
    };

    static final Map<String, String> simpleDNS = {
        'androidbasedflutterdemo.lsx.com': '127.0.0.1',
        'androidbasedflutterdemocdn.lsx.com': '127.0.0.1',
    };
}
