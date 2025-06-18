import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digital_omamori/model/core/news.dart';
import 'package:digital_omamori/model/helper/news_helper.dart';
import 'package:digital_omamori/route/slide_page_route.dart';
import 'package:digital_omamori/view/screens/breaking_news_page.dart';
import 'package:digital_omamori/view/screens/profile_page.dart';
import 'package:digital_omamori/view/widgets/breaking_news_card.dart';
import 'package:digital_omamori/view/widgets/custom_app_bar.dart';
import 'package:digital_omamori/view/widgets/news_tile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<News> breakingNewsData = NewsHelper.breakingNews;
  List<News> recomendationNewsData = NewsHelper.recomendationNews;

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
        title: SvgPicture.asset('assets/icons/DigitalOmamori.svg',width: 140),
      ),
        
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // section 1 - Breaking News
          Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
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
                  margin: EdgeInsets.only(top: 6),
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    itemCount: breakingNewsData.length,
                    physics: BouncingScrollPhysics(),
                    separatorBuilder: (context, index) => SizedBox(width: 13),
                    itemBuilder: (context, index) {
                      return BreakingNewsCard(data: breakingNewsData[index]);
                    },
                  ),
                ),
              ],
            ),
          ),

          // section 2 - Recent News
          Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 8),
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
                            Colors.grey.withValues(alpha: (0.1 * 255))
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
                Container(
                  margin: EdgeInsets.only(top: 16, bottom: 16),
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: recomendationNewsData.length,
                    separatorBuilder: (context, index) => SizedBox(height: 16),
                    itemBuilder: (context, index) {
                      return NewsTile(data: recomendationNewsData[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
