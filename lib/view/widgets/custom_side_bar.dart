import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:package_info_plus/package_info_plus.dart';

class CustomSideBar extends StatefulWidget {
  @override
  _CustomSideBarState createState() => _CustomSideBarState();
}

class _CustomSideBarState extends State<CustomSideBar> {
  String _appVersion = '';

  @override
  void initState() {
    super.initState();
    _loadAppVersion();
  }

  void _loadAppVersion() async {
    final info = await PackageInfo.fromPlatform();
    setState(() {
      _appVersion = 'v${info.version}';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 34, 102, 176),
        child: Column(
          children: [
            // 顶部用户信息区域 - 移除了GestureDetector和跳转功能
            Padding(
              padding: EdgeInsets.only(top: 90),
              child: Container(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 32),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: Colors.white.withOpacity(0.1),
                      width: 1,
                    ),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 64,
                      height: 64,
                      margin: EdgeInsets.only(right: 16),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('assets/images/omamori04.png'),
                          fit: BoxFit.cover,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.15),
                            blurRadius: 12,
                            spreadRadius: -2,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Digital Omamori',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 6),
                          Text(
                            _appVersion,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.6),
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // 菜单项
            Expanded(
              child: ListView(
                padding: EdgeInsets.only(top: 16),
                physics: BouncingScrollPhysics(),
                children: [
                  _buildMenuItem(
                    context,
                    iconAssetPath: 'assets/icons/mail.svg',
                    title: 'Contact Support',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context,
                    iconAssetPath: 'assets/icons/share.svg',
                    title: 'Share App',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context,
                    iconAssetPath: 'assets/icons/info.svg',
                    title: 'About Us',
                    onTap: () {},
                  ),
                  _buildMenuItem(
                    context,
                    iconAssetPath: 'assets/icons/lock-keyhole.svg',
                    title: 'Privacy Policy',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            // 底部版权信息
            Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                '© 2023 Digital Omamori',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, {
    required String title,
    required String iconAssetPath,
    required VoidCallback onTap,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Color.fromARGB(255, 52, 116, 183),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
              children: [
                SvgPicture.asset(
                  iconAssetPath,
                  height: 24,
                  width: 24,
                  colorFilter: ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Icon(
                  Icons.chevron_right,
                  color: Colors.white.withOpacity(0.6),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}