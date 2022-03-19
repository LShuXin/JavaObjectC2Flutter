import 'dart:io';
import 'dart:async';
import 'dart:isolate';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:dio_http2_adapter/dio_http2_adapter.dart';
import 'package:cookie_jar/cookie_jar.dart';

import 'package:device_info/device_info.dart';
import 'package:connectivity/connectivity.dart';
import 'package:package_info/package_info.dart';

import '../env.dart';

class QE implements Exception {
    int? errNo;
    final String? errInfo;
    final dynamic extraInfo;

    QE(this.errInfo, {this.extraInfo, this.errNo});

    @override
    String toString() => errInfo!;
}

class MyFetch {
    static late String _uuid;
    static late String _packageName;
    static final Map<String, String> _baseParams = {};

    static late Dio _dio;

    static CookieJar? _cookieJar;

    static Future<void> initialize({required String appDocPath, String lang = ''}) async {
        MyFetch._cookieJar = PersistCookieJar(ignoreExpires: true, storage: FileStorage(appDocPath + "/.cookies/"));

        MyFetch._dio = _createDio();
    }

    static Dio _createDio() {
        Dio dio = Dio(BaseOptions(
            baseUrl: Env.host,
            connectTimeout: 6000,
            receiveTimeout: 6000,
        ));

        //https/2.0
        if (Env.host.startsWith('https')) {
            dio.httpClientAdapter = Http2Adapter(
                ConnectionManager(
                    idleTimeout: 15000,
                    // Ignore bad certificate
                    onClientCreate: (_, config) => config.onBadCertificate = (_) => true,
                )
            );
        }

        dio.interceptors.add(CookieManager(MyFetch._cookieJar!));
        return dio;
    }
    static printCookie() async {
        List<Cookie> cookies = await _cookieJar!.loadForRequest(Uri.parse(Env.host));
        cookies.forEach((i) => print(i));
    }

    static Future<bool> hasSSID() async  {
        List<Cookie> cookies = await _cookieJar!.loadForRequest(Uri.parse(Env.host));
        return cookies.indexWhere((e) => e.name == 'SSID') > -1;
    }

    static deleteCookie() async {
        await MyFetch._cookieJar!.delete(Uri.parse(Env.host));
    }

    static deleteAllCookie() async {
        await MyFetch._cookieJar!.deleteAll();
    }

    static Future<String> getCookie(String name) async {
        List<Cookie> cookies = await _cookieJar!.loadForRequest(Uri.parse(Env.host));
        int idx = cookies.indexWhere((e) => e.name == name);
        if (idx > -1) {
            return cookies[idx].value;
        }
        return '';
    }

    static Future<dynamic> get(String url, Map<String, dynamic> params) async {
        if (_baseParams['_net'] == 'none') {
            throw QE('无网络');
        }

        Map<String, dynamic> headers = {
            HttpHeaders.acceptHeader: Headers.jsonMimeType.toString(), // application/json; charset=utf-8
        };
        Response resDio;
        try {
            resDio = await MyFetch._dio.get(
                url,
                queryParameters: {}..addAll(MyFetch._baseParams)..addAll(params),
                options: Options(
                    responseType: ResponseType.json,
                    headers: headers,
                ),
            );
        } on DioError catch(err) {
            if (err.type == DioErrorType.connectTimeout) {
                throw QE('连接超时，请检查网络');
            } else if (err.type == DioErrorType.receiveTimeout || err.type == DioErrorType.sendTimeout) {
                throw QE('网络超时，请重试');
            } else if (err.type == DioErrorType.other) {
                MyFetch._dio.close();
                MyFetch._dio = _createDio();
                throw QE('网络异常，请重试');
            } else {
                rethrow;
            }
        }
        //print(resDio.statusCode);
        if (resDio.data is Map && resDio.data['st'] != 'ok') {
            throw QE(resDio.data['errinfo'], extraInfo: resDio.data, errNo: resDio.data['errno']);
        }
        return resDio.data;
    }

    static Future<dynamic> post(String url, Map<String, dynamic> params) async {
        Map<String, dynamic> headers = {
            HttpHeaders.acceptHeader: Headers.jsonMimeType.toString(),                   // application/json; charset=utf-8
            HttpHeaders.contentTypeHeader: Headers.formUrlEncodedContentType.toString(), // application/x-www-form-urlencoded
        };
        Map<String, dynamic> data = {}..addAll(MyFetch._baseParams)..addAll(params);
        Response resDio;
        try {
            resDio = await MyFetch._dio.post(
                url,
                data: data,
                options: Options(
                    responseType: ResponseType.json,
                    headers: headers,
                ),
            );
        } on DioError catch(err) {
            if (err.type == DioErrorType.connectTimeout) {
                throw QE('连接超时');
            } else if (err.type == DioErrorType.receiveTimeout || err.type == DioErrorType.sendTimeout) {
                throw QE('网络超时');
            } else {
                rethrow;
            }
        }
        if (resDio.data is Map && resDio.data['st'] != 'ok') {
            throw QE(resDio.data['errinfo'], extraInfo: resDio.data, errNo: resDio.data['errno']);
        }
        return resDio.data;
    }
}
