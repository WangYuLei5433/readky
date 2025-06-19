import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';

const Color primaryColor = Color(0xFF1760AD);
const Color secondaryColor = Color(0xFFE3F2FD);

void shareApp(BuildContext context) async {
  await showGeneralDialog(
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
                  Icons.share,
                  size: 48,
                  color: primaryColor,
                ),
                const SizedBox(height: 12),
                const Text(
                  '友達に紹介しよう！',
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
                  'Digital Omamori（デジタルお守り）は、日常を守るためのアプリです。あなたの大切な人にもシェアしませんか？',
                  textAlign: TextAlign.center,
                  style: TextStyle(height: 1.5),
                ),
                SizedBox(height: 12),
                Text(
                  '※ アプリストアから安全にダウンロードできます',
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
                      onPressed: () => Navigator.of(ctx).pop(),
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
                      onPressed: () {
                        Navigator.of(ctx).pop();
                        final String message = '''
Digital Omamoriアプリをチェックしてみてください！
お守りのように日常を守るアプリです。

📲 ダウンロードはこちら:
https://play.google.com/store/apps/details?id=com.example.digital_omamori
''';
                        Share.share(message);
                      },
                      child: const Text('シェアする'),
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
}
