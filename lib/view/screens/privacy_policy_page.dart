import 'package:flutter/material.dart';
import 'package:digital_omamori/view/widgets/custom_app_bar.dart';

class PrivacyPolicyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50], // 浅灰色背景提升高级感
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
          'Privacy Policy',
          style: TextStyle(
            fontWeight: FontWeight.w500, // 稍重的字体
            fontSize: 20,
            color: Colors.white,
            letterSpacing: 0.5, // 字母间距增加高级感
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0), // 更合理的边距
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // 标题部分
            Container(
              padding: EdgeInsets.only(bottom: 24),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Colors.grey[200]!,
                    width: 1.5,
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Privacy Policy',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Last Updated: ${DateTime.now().toString().substring(0, 10)}',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
            
            SizedBox(height: 32),
            
            // 隐私政策内容部分
            _buildPolicySection(
              title: '1. Information We Collect',
              content: 'Digital Omamori collects minimal personal data necessary to provide our services. This may include your device information, usage patterns, and preferences to enhance your experience.',
            ),
            
            _buildPolicySection(
              title: '2. How We Use Your Information',
              content: 'Your information is used solely to deliver and improve our services. We analyze usage patterns to optimize app performance and personalize your experience while maintaining your privacy.',
            ),
            
            _buildPolicySection(
              title: '3. Data Sharing',
              content: 'We do not sell or rent your personal data. Information is only shared with trusted third-party services essential for app functionality, all of whom adhere to strict data protection standards.',
            ),
            
            _buildPolicySection(
              title: '4. Security Measures',
              content: 'We implement industry-standard security protocols including encryption, secure servers, and regular audits to protect your data from unauthorized access or disclosure.',
            ),
            
            _buildPolicySection(
              title: '5. Your Rights',
              content: 'You have the right to access, correct, or delete your personal data. Contact our support team at privacy@digitalomamori.com for any data-related requests.',
            ),
            
            SizedBox(height: 40),
            
            // 底部版权信息
            Center(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  '© ${DateTime.now().year} Digital Omamori. All Rights Reserved.',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 13,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPolicySection({required String title, required String content}) {
    return Container(
      margin: EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1760AD), // 使用品牌蓝色
              height: 1.4,
            ),
          ),
          SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              fontSize: 15,
              color: Colors.black87,
              height: 1.6, // 增加行高提升可读性
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}