import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

const Color primaryColor = Color(0xFF1760AD);
const Color secondaryColor = Color(0xFFE3F2FD);

Future<void> launchSupportEmail(BuildContext context) async {
  // 1. 显示优雅的确认对话框
  final bool? confirm = await showGeneralDialog<bool>(
    context: context,
    barrierDismissible: true,
    barrierLabel: '',
    barrierColor: Colors.black.withOpacity(0.5),
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (ctx, anim1, anim2) {
      return ScaleTransition(
        scale: CurvedAnimation(parent: anim1, curve: Curves.easeOutBack),
        child: FadeTransition(
          opacity: anim1,
          child: AlertDialog(
            elevation: 8,
            shadowColor: primaryColor.withOpacity(0.2),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            title: Column(
              children: [
                Icon(
                  Icons.email_outlined,
                  size: 48,
                  color: primaryColor,
                ),
                const SizedBox(height: 12),
                const Text(
                  'サポートに連絡',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            content: const Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'メールアプリを起動して、サポートチームに直接ご連絡いただけます。',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5),
                ),
                SizedBox(height: 12),
                Text(
                  '※ 返信までにお時間を頂く場合がございます',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ],
            ),
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey.shade700,
                        side: BorderSide(color: Colors.grey.shade300),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () => Navigator.of(ctx).pop(false),
                      child: const Text('後でする'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                        shadowColor: Colors.transparent,
                      ),
                      onPressed: () => Navigator.of(ctx).pop(true),
                      child: const Text('送信する'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );

  if (confirm != true) return;

  // 2. 准备邮件内容
  final String subject = Uri.encodeComponent('デジタルお守りに関するお問い合わせ');
  final String body = Uri.encodeComponent(
    'サポートチーム\n\nいつもお世話になっております。\nアプリについて以下の件でご相談があります。\n\n（ここに内容を入力してください）\n\nよろしくお願いいたします。',
  );
  final Uri emailUri = Uri.parse(
    'mailto:sbieverspin@sbigroup.co.jp?subject=$subject&body=$body',
  );

  // 3. 启动邮件客户端
  try {
    if (await canLaunchUrl(emailUri)) {
      // 显示加载指示器
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (ctx) => const Center(
          child: CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation(primaryColor),
          ),
        ),
      );

      await launchUrl(emailUri);

      // 关闭加载指示器
      if (context.mounted) Navigator.of(context, rootNavigator: true).pop();

      // 显示感谢信息
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Row(
              children: [
                Icon(Icons.check_circle, color: Colors.white),
                SizedBox(width: 8),
                Text('お問い合わせありがとうございます'),
              ],
            ),
            backgroundColor: primaryColor,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } else {
      throw 'メールアプリを起動できませんでした';
    }
  } catch (e) {
    if (context.mounted) Navigator.of(context, rootNavigator: true).pop();

    // 显示优雅的错误提示
    if (!context.mounted) return;
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        icon:
            const Icon(Icons.error_outline, color: Colors.redAccent, size: 48),
        title: const Text('送信エラー'),
        content:
            const Text('メールアプリの起動に失敗しました。\n設定からメールアプリがインストールされているかご確認ください。'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('閉じる'),
          ),
          TextButton(
            onPressed: () =>
                launchUrl(Uri.parse('https://sbigroup.co.jp/contact')),
            child: const Text('Webフォームへ'),
          ),
        ],
      ),
    );
  }
}
