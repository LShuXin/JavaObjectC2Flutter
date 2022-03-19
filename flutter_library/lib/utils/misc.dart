import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
export 'package:collection/collection.dart';
export 'package:tuple/tuple.dart';

import '../env.dart';

bool int2Bool(int i) => i != 0;
int bool2Int(bool b) => b ? 1 : 0;

List<String> commaStr2List(String s) => s == '' ? [] : s.split(',');
String list2CommaStr(List<String> l) => l.join(',');

int string2Int(dynamic s) => s is String ? int.parse(s) : (s is int ? s : 0);

bool isServerPic(url) {
    return url.startsWith('http') && url.indexOf('/pic/') != -1 && url.indexOf('/tmp/') == -1;
}

String picUrl(String? sign, [String? size]) {
    if (sign == null || sign == '') {
        return '';
    }
    if (size == null || size == '') {
        return Env.cdnHost + '/pic/$sign';
    }
    return Env.cdnHost + '/pic/$size/$sign';
}

String picSign(String url) {
    if (url == '') {
        return '';
    }
    var idx = url.indexOf('/pic/');
    if (idx == -1) {
        return '';
    }
    var questionIdx = url.indexOf('?', idx + 6);
    if (questionIdx != -1) {
        return url.substring(idx + 5, questionIdx);
    }
    return url.substring(idx + 5);
}
/// 2021-05-26 14:19:26 => 1622009966
int human2ts(String timeStr) {
    return DateTime.parse(timeStr).millisecondsSinceEpoch ~/ 1000;
}

int obj2ts(DateTime obj) {
    return obj.millisecondsSinceEpoch ~/ 1000;
}

DateTime ts2obj(int ts) {
    return DateTime.fromMillisecondsSinceEpoch(ts * 1000);
}

DateTime int2DateTime(int yyyymmdd) {
    int year = int.parse(yyyymmdd.toString().substring(0, 4));
    int month = int.parse(yyyymmdd.toString().substring(4, 6));
    int day = int.parse(yyyymmdd.toString().substring(6));
    return DateTime(year, month, day);
}

final _df1 = DateFormat('yyyy-MM-dd HH:mm:ss');
final _df2 = DateFormat('yyyy-MM-dd HH:mm');
final _df3 = DateFormat('MM-dd HH:mm');
final _df4 = DateFormat('MM月dd日 HH:mm');
final _df5 = DateFormat('yyyyMMdd');
final _df6 = DateFormat('HH:mm');


///  https://api.flutter.dev/flutter/intl/DateFormat-class.html
String formatDT(DateTime obj, [String? format, Locale? locale]) {
    if (format == null) {
        return _df1.format(obj);
    }
    switch (format) {
        case 'yyyy-MM-dd HH:mm:ss':
            return _df1.format(obj);
        case 'yyyy-MM-dd HH:mm':
            return _df2.format(obj);
        case 'MM-dd HH:mm':
            return _df3.format(obj);
        case 'MM月dd日 HH:mm':
            return _df4.format(obj);
        case 'yyyyMMdd':
            return _df5.format(obj);
        case 'HH:mm':
            return _df6.format(obj);
    }
    return DateFormat(format).format(obj);
}



String smartDay(DateTime obj) {
    const smartDays = {
        'dby': '前天',
        'yday': '昨天',
        'today': '今天',
        'twm': '明天',
        'dat': '后天',
    };

    int todayZero = lastMidnightTS();
    int targetTs = obj.millisecondsSinceEpoch ~/ 1000;

    if (targetTs >= todayZero && targetTs < todayZero + 24 * 3600) {
        return smartDays['today']!;
    } else if (targetTs >= todayZero + 24 * 3600 && targetTs < todayZero + 48 * 3600) {
        return smartDays['twm']!;
    } else if (targetTs >= todayZero + 48 * 3600 && targetTs < todayZero + 72 * 3600) {
        return smartDays['dat']!;
    } else if (targetTs < todayZero && targetTs >= todayZero - 24 * 3600) {
        return smartDays['yday']!;
    } else if (targetTs < todayZero - 24 * 3600 && targetTs >= todayZero - 48 * 3600) {
        return smartDays['dby']!;
    } else {
        return formatDT(obj, 'yyyy-MM-dd');
    }
}

/// genderSymbol: F、M
String? humanGender(String genderSymbol) {
    const genderSymbols = {
        'F': '女',
        'M': '男'
    };
    return genderSymbols[genderSymbol];
}

/// 对formatDT的封装，只是参数为时间戳秒数
String formatTS(int ts, [String? format]) {
    return formatDT(DateTime.fromMillisecondsSinceEpoch(ts * 1000), format);
}

/// 当前时间戳
int nowTS() {
    return DateTime.now().millisecondsSinceEpoch ~/ 1000;
}

/// 上个临晨的时间戳
int lastMidnightTS([int tzoffset = 8*3600]) {
    int ts = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return ts - (ts + tzoffset) % (24 * 3600);
}

/// 下个临晨的时间戳
int nextMidnightTS([int tzoffset = 8*3600]) {
    int ts = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return ts + 24 * 3600 - (ts + tzoffset) % (24 * 3600);
}

String dayStr([int days = 0]) {
    int msts = DateTime.now().millisecondsSinceEpoch;
    var obj = DateTime.fromMillisecondsSinceEpoch(msts + 28800 * 1000 + 3600 * 24 * days * 1000, isUtc: true);
    return formatDT(obj, 'yyyyMMdd');
}
int dayInt([days = 0]) {
    return int.parse(dayStr(days));
}

String hhmmStr([int hh = 0, int mm = 0]) {
    int msts = DateTime.now().millisecondsSinceEpoch;
    var obj = DateTime.fromMillisecondsSinceEpoch(msts + 28800 * 1000 + 3600 * hh * 1000 + mm * 60 * 1000, isUtc: true);
    return formatDT(obj, 'HHmm');
}

int hhmmInt([hh = 0, mm = 0]) {
    return int.parse(hhmmStr(hh, mm));
}

int obj2int(DateTime date, [String? format]) {
    if (format == 'yyyyMM') {
        return date.year * 100 + date.month;
    }
    return date.year * 10000 + date.month * 100 + date.day;
}

DateTime prevMonth(DateTime time) {
    return DateTime(time.year, time.month - 1);
}

DateTime nextMonth(DateTime time) {
    return DateTime(time.year, time.month + 1);
}
