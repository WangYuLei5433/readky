import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:digital_omamori/view/widgets/custom_app_bar.dart';

class AboutUsPage extends StatefulWidget {
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  PackageInfo _packageInfo = PackageInfo(
    appName: 'Digital Omamori',
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
      backgroundColor: Colors.grey[50], // 浅灰色背景提升质感
      appBar: CustomAppBar(
        leadingIcon: Icon(
          Icons.arrow_back_ios,
          color: Colors.white,
          size: 20, // 更精致的图标大小
        ),
        onPressedLeading: () {
          Navigator.of(context).pop();
        },
        title: Text(
          'About Us',
          style: TextStyle(
            fontWeight: FontWeight.w500, // 稍重的字体
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 0.5, // 字母间距增加高级感
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 应用信息卡片
            Container(
              padding: EdgeInsets.all(24),
              margin: EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // 应用名称和版本
                  Text(
                    _packageInfo.appName,
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Version ${_packageInfo.version} • Build ${_packageInfo.buildNumber}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                      letterSpacing: 0.3,
                    ),
                  ),
                  SizedBox(height: 24),
                  
                  // 分割线
                  Divider(height: 1, color: Colors.grey[200]),
                  SizedBox(height: 24),
                  
                  // 应用描述
                  Text(
                    'Digital Omamori is a premium security news application developed by SBI Everspin, delivering the latest and most relevant security updates to professionals worldwide.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.6, // 增加行高提升可读性
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            
            // 公司信息部分
            Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'About SBI Everspin',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF1760AD), // 品牌蓝色
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'SBI Everspin is a leading cybersecurity firm dedicated to providing cutting-edge security solutions and timely threat intelligence to global enterprises.',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.6,
                    ),
                  ),
                  SizedBox(height: 16),
                  _buildInfoItem(Icons.location_on, 'Tokyo, Japan'),
                  _buildInfoItem(Icons.language, 'www.sbieverspin.com'),
                  _buildInfoItem(Icons.email, 'contact@sbieverspin.com'),
                ],
              ),
            ),
            
            SizedBox(height: 40),
            
            // 版权信息
            Center(
              child: Text(
                '© ${DateTime.now().year} SBI Everspin. All Rights Reserved.',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 13,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            size: 20,
            color: Colors.grey[600],
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: Colors.black87,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}