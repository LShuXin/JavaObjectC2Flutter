package com.lsx.androiddemo;

import androidx.appcompat.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.FrameLayout;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.android.FlutterView;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.BinaryMessenger;

public class MainActivity extends AppCompatActivity {
    FlutterApp flutterApp;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        flutterApp = FlutterApp.getInstance(this);
        setContentView(R.layout.activity_main);
    }

    public void jumpToFlutterApp(View view) {
        // 方案一：
        // 提前建立一个 FlutterEngine 实例并预热，可缩短 Flutter 页面启动时间，但是路由只能设置默认的路由
        // startActivity(
        //         FlutterActivity
        //                 .withCachedEngine(FlutterApp.FLUTTER_ENGINE_ID)
        //                 .build(this)
        // );

        // 方案二：
        // 每次启动生成新 FlutterEngine 实例，可以每次指定新的路由
         startActivity(
                 FlutterActivity
                         .withNewEngine()
                         .initialRoute("app://")
                         .build(this)
         );
    }
}


