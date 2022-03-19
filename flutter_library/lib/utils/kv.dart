import 'package:hive/hive.dart';

class KvLocalStorage {
    static late String _keyPrefix;
    static late LazyBox _lazyBox;

    static const String keyXxx = 'Xxx';

    static Future<void> initialize(String appDocPath, String keyPrefix) async {
        KvLocalStorage._keyPrefix = keyPrefix;

        Hive.init(appDocPath + '/.boxes/');

        _lazyBox = await Hive.openLazyBox(
            'lazyBox',
            compactionStrategy: (entries, deletedEntries) => deletedEntries > 50
        );
    }

    static Future<void> put(String key, dynamic val) async {
        await _lazyBox.put('${KvLocalStorage._keyPrefix}^$key', val);
    }

    static Future<dynamic> get(String key, {dynamic defaultValue}) async {
        return await _lazyBox.get('${KvLocalStorage._keyPrefix}^$key', defaultValue: defaultValue);
    }

    static Future<void> delete(String key) async {
        await _lazyBox.delete('${KvLocalStorage._keyPrefix}^$key');
    }

    static Future<int> clear() async {
        return await _lazyBox.clear();
    }
}

class KvInstantStorage {
    static KvInstantStorage? _instance;
    static final Map<String, dynamic> _instantBox = {};

    KvInstantStorage._internal();

    factory KvInstantStorage() {
        _instance ??= KvInstantStorage._internal();
        return _instance!;
    }

    static const String keyXxx = 'Xxx';

    put(String key, dynamic val) {
        _instantBox[key] = val;
    }

    get(String key, {dynamic defaultValue}) {
        return _instantBox[key] ?? defaultValue;
    }

    delete(String key) {
        _instantBox.remove(key);
    }

    clear() {
        _instantBox.clear();
    }
}
