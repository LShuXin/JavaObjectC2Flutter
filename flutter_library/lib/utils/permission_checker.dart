import 'dart:io';

import 'package:permission_handler/permission_handler.dart';


///检查获取存储权限
Future<bool> checkStoragePermission() async {
    Permission permission = Permission.storage;
    PermissionStatus status = await permission.status;
    if (status.isGranted) {
        //权限通过
        return true;
    } else if (status.isDenied) {
        //权限拒绝， 需要区分IOS和Android，二者不一样
        if (Platform.isAndroid) {
            Map<Permission, PermissionStatus> statuses = await [Permission.storage].request();
            return statuses[Permission.storage] == PermissionStatus.granted;
        }
        openAppSettings();
        return false;
    } else if (status.isPermanentlyDenied) {
        //权限永久拒绝，且不在提示，需要进入设置界面，IOS和Android不同
        openAppSettings();
        return false;
    } else if (status.isRestricted) {
        //活动限制（例如，设置了家长///控件，仅在iOS以上受支持。
        openAppSettings();
        return false;
    } else {
        //第一次申请
        Map<Permission, PermissionStatus> statuses = await [Permission.storage].request();
        return statuses[Permission.storage] == PermissionStatus.granted;
    }
}
