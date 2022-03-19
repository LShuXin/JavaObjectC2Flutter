import 'package:share_plus/share_plus.dart';

/// 原生分享
class AppShare {

    /// 分享图片(传入图片的路径)
    static shareImages(List<String> images, {String text = '', String subject = ''}) async {
        var res = await Share.shareFiles(images, text: text, subject: subject);
        return res;
    }

     /// 分享文本
    static shareText(String content, {String subject = ''}) async {
        var res = Share.share(content, subject: subject);
        return res;
    }
}
