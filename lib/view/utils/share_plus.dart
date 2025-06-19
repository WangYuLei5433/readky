import 'package:share_plus/share_plus.dart';

void shareApp() {
  final String message = '''
Digital Omamoriアプリをチェックしてみてください！
お守りのように日常を守るアプリです。

📲 ダウンロードはこちら:
https://play.google.com/store/apps/details?id=com.example.readky
''';

  Share.share(message);
}
