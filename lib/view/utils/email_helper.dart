import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> launchSupportEmail(BuildContext context) async {
  // 日语主题与正文
  final String subject = Uri.encodeComponent('デジタルお守りに関するお問い合わせ');
  final String body = Uri.encodeComponent(
    'サポートチーム\n\nいつもお世話になっております。\nアプリについて以下の件でご相談があります。\n\n（ここに内容を入力してください）\n\nよろしくお願いいたします。',
  );

  final Uri emailUri = Uri.parse(
    'mailto:sbieverspin@sbigroup.co.jp?subject=$subject&body=$body',
  );

  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('メールクライアントを起動できませんでした。')),
    );
  }
}
