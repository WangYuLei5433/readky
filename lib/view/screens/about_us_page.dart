import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:digital_omamori/view/widgets/custom_app_bar.dart'; // 导入 CustomAppBar 的路径

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Unknown',
    packageName: 'Unknown',
    version: 'Unknown',
    buildNumber: 'Unknown',
    buildSignature: 'Unknown',
  );

  @override
  void initState() {
    super.initState();
    _initPackageInfo();
  }

  Future<void> _initPackageInfo() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _packageInfo = info;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
        ),
        onPressedLeading: () {
          Navigator.of(context).pop();
        },
        title: Text(
          'About Us',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Logo已移除
            SizedBox(height: 24),
            Center(
              child: Text(
                _packageInfo.appName,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Text(
                'Version: ${_packageInfo.version} (Build ${_packageInfo.buildNumber})',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            SizedBox(height: 24),
            Text(
              'Digital Omamori 是一款主要用于发布与安全相关新闻的应用。',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              '本应用属于 SBI Everspin 旗下重要的产品，专注于为您提供最新的安全新闻资讯。',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 32),
            // 联系支持按钮已移除
            // 分割线已移除
            // 隐私政策按钮已移除
            // 分割线已移除
            // 服务条款按钮已移除
            SizedBox(height: 32),
            Center(
              child: Text(
                '© ${DateTime.now().year} SBI Everspin. All Rights Reserved.',
                style: TextStyle(color: Colors.grey, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}