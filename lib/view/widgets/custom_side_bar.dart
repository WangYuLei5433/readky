import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digital_omamori/route/slide_page_route.dart';
import 'package:digital_omamori/view/screens/profile_page.dart';

class CustomSideBar extends StatefulWidget {
  @override
  _CustomSideBarState createState() => _CustomSideBarState();
}

class _CustomSideBarState extends State<CustomSideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 34, 102, 176),
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(SlidePageRoute(child: ProfilePage()));
              },
              child: Container(
                margin: EdgeInsets.only(top: 30),
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                child: Row(
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      margin: EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.circular(100)),
                      child: Image.asset(
                        'assets/images/pp.png',
                        width: 48,
                        height: 48,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Shasy Rhe',
                            style: TextStyle(color: Colors.white, fontSize: 16),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            'Basic Account.',
                            style: TextStyle(color: Colors.white.withValues(alpha: (0.35))),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Divider(
              thickness: 0.5,
              color: Color(0xFF606060),
            ),
            _buildListTile(
              context,
              iconAssetPath: 'assets/icons/mail.svg',
              title: 'Contact Support',
              onTap: () {},
            ),
            _buildListTile(
              context,
              iconAssetPath: 'assets/icons/share.svg',
              title: 'Share App',
              onTap: () {},
            ),
            _buildListTile(
              context,
              iconAssetPath: 'assets/icons/info.svg',
              title: 'About Us',
              onTap: () {},
            ),
            _buildListTile(
              context,
              iconAssetPath: 'assets/icons/lock-keyhole.svg',
              title: 'Privacy Policy',
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(BuildContext context, {required String title, required String iconAssetPath, required VoidCallback onTap}) {
    return Container(
      color: Color.fromARGB(255, 52, 116, 183),
      child: ListTileTheme(
        contentPadding: EdgeInsets.only(left: 24, top: 10, bottom: 10),
        minLeadingWidth: 12,
        tileColor: Colors.white.withValues(alpha: (0.8)),
        selectedTileColor: Colors.white,
        selectedColor: Colors.white,
        textColor: Colors.white.withValues(alpha: (0.8)),
        child: ListTile(
          leading: SvgPicture.asset(
            iconAssetPath,
            height: 24,
            width: 24,
            colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600,color: Colors.white,),
          ),
          onTap: onTap,
        ),
      ),
    );
  }
}
