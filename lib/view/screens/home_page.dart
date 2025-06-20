import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digital_omamori/model/core/news.dart';
import 'package:digital_omamori/model/helper/api_service.dart';
import 'package:digital_omamori/view/widgets/breaking_news_card.dart';
import 'package:digital_omamori/view/widgets/news_tile.dart';
import 'package:digital_omamori/route/slide_page_route.dart';
import 'package:digital_omamori/view/screens/breaking_news_page.dart';
import 'package:digital_omamori/view/widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<News>> _latestNewsFuture;

  @override
  void initState() {
    super.initState();
    _latestNewsFuture = ApiService().fetchLatestNews();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        leadingIcon: SvgPicture.asset(
          'assets/icons/Menu.svg',
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        onPressedLeading: () {
          Scaffold.of(context).openDrawer();
        },
        title: SvgPicture.asset('assets/icons/DigitalOmamori.svg', width: 140),
      ),
      body: FutureBuilder<List<News>>(
        future: _latestNewsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('エラー: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('ニュースが見つかりません'));
          } else {
            final allNews = snapshot.data!;
            final breakingNewsData = allNews.length >= 2 ? allNews.sublist(0, 2) : allNews;
            final recommendationNewsData = allNews.length > 2 ? allNews.sublist(2) : [];

            return ListView(
              shrinkWrap: true,
              physics: BouncingScrollPhysics(),
              children: [
                // 🔴 Breaking News Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  child: Text(
                    'Breaking News',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'inter',
                    ),
                  ),
                ),
                Container(
                  height: 200,
                  margin: EdgeInsets.only(bottom: 16),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: breakingNewsData.length,
                    separatorBuilder: (context, index) => SizedBox(width: 13),
                    itemBuilder: (context, index) {
                      return BreakingNewsCard(data: breakingNewsData[index]);
                    },
                  ),
                ),

                // 🔵 Recent News Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Recent News',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          fontFamily: 'inter',
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            SlidePageRoute(child: BreakingNewsPage()),
                          );
                        },
                        style: ButtonStyle(
                          overlayColor: WidgetStateProperty.all(
                            Colors.grey.withOpacity(0.1),
                          ),
                          padding: WidgetStateProperty.all(
                            EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          ),
                          shape: WidgetStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            ),
                          ),
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Text(
                          'view more',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF1760AD),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  itemCount: recommendationNewsData.length,
                  separatorBuilder: (context, index) => SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return NewsTile(data: recommendationNewsData[index]);
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
