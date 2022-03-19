import 'package:flutter/cupertino.dart';

class UserInfo with ChangeNotifier {
    UserInfo() {
        init();
    }

    init({bool needNotify = true}) async {
        if (needNotify) {
            notifyListeners();
        }
    }

    void notify() {
        notifyListeners();
    }
}
