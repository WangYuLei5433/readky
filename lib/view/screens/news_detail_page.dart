import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digital_omamori/model/core/news.dart';
import 'package:digital_omamori/view/widgets/custom_app_bar.dart';

class NewsDetailPage extends StatelessWidget {
  final News data;
  NewsDetailPage({required this.data});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        onPressedLeading: () {},
        title: SvgPicture.asset('assets/icons/appname.svg'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.share_outlined,
              color: Colors.white.withValues(alpha: (0.5* 255)),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset(
              'assets/icons/Bookmark.svg',
              colorFilter:ColorFilter.mode(
                Colors.white.withValues(alpha: 0.5* 255),
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: 240,
            decoration: BoxDecoration(
              color: Colors.grey,
              image:DecorationImage(
                image: AssetImage(data.photo ?? ' '),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data.date} | ${data.author}.',
                  style: TextStyle(color: Colors.black.withValues(alpha: (0.6)), fontSize: 12),
                ),
                Container(
                  margin: EdgeInsets.only(top: 12, bottom: 20),
                  child: Text(
                    data.title ?? '',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600, height: 150 / 100, fontFamily: 'inter'),
                  ),
                ),
                Text(
                  data.description ?? '',
                  style: TextStyle(color: Colors.black.withValues(alpha: (0.8)), fontSize: 14, height: 150 / 100, fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
