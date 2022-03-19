package com.lsx.androiddemo;

import android.content.Context;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.FlutterEngineCache;
import io.flutter.embedding.engine.dart.DartExecutor.DartEntrypoint;

// for warm-up FlutterEngine
// https://docs.flutter.dev/development/add-to-app/android/add-flutter-screen
public class FlutterApp {
    static FlutterApp instance;
    public static final String FLUTTER_ENGINE_ID = "FLUTTER_ENGINE";

    FlutterEngine flutterEngine;

    public static FlutterApp getInstance(Context context) {
        if (instance == null) {
            instance = new FlutterApp(context);
        }
        return instance;
    }

    public static FlutterEngine getFlutterEngine(Context context) {
        if (instance == null) {
            getInstance(context);
        }
        return instance.flutterEngine;
    }

    public FlutterEngine getFlutterEngine() {
        if (instance == null) {
            return null;
        }
        return flutterEngine;
    }

    FlutterApp(Context context) {
        // Instantiate a FlutterEngine.
        flutterEngine = new FlutterEngine(context);
        // Configure an initial route.
        flutterEngine.getNavigationChannel().setInitialRoute("/");
        // Start executing Dart code to pre-warm the FlutterEngine.
        flutterEngine.getDartExecutor().executeDartEntrypoint(
                DartEntrypoint.createDefault()
        );
        // Cache the FlutterEngine to be used by FlutterActivity.
        FlutterEngineCache
                .getInstance()
                .put(FLUTTER_ENGINE_ID, flutterEngine);
    }
}