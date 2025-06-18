import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digital_omamori/view/widgets/embedded_search_bar.dart';
import 'package:digital_omamori/model/core/news.dart';
import 'package:digital_omamori/model/helper/news_helper.dart';
import 'package:digital_omamori/view/widgets/custom_app_bar.dart';
import 'package:digital_omamori/view/widgets/news_tile.dart';

class DiscoverPage extends StatefulWidget {
  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage>
    with TickerProviderStateMixin {
  late TabController _categoryTabController;
  List<News> allCategoriesNews = NewsHelper.allCategoriesNews;
  final TextEditingController searchInputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _categoryTabController = TabController(length: 7, vsync: this);
  }

  @override
  void dispose() {
    _categoryTabController.dispose();
    searchInputController.dispose();
    super.dispose();
  }

  _changeTab(index) {
    setState(() {
      _categoryTabController.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: SvgPicture.asset(
          'assets/icons/Menu.svg',
          colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn),
        ),
        onPressedLeading: () {
          Scaffold.of(context).openDrawer();
        },
        title: Text(
          'Discover',
          style: TextStyle(
              fontWeight: FontWeight.w400, fontSize: 20, color: Colors.white),
        ),
        actions: [], // 已移除右上角搜索图标
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // 嵌入式搜索组件
          EmbeddedSearchBar(
            controller: searchInputController,
            onSearch: () {
              // 你可以添加过滤搜索逻辑
              print('搜索关键词: ${searchInputController.text}');
              // 示例仅打印，不做过滤
            },
          ),

          // 新闻列表
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            width: MediaQuery.of(context).size.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 标签栏
                Padding(
                  padding: EdgeInsets.only(bottom: 8),
                  child: TabBar(
                    isScrollable: true,
                    controller: _categoryTabController,
                    labelStyle: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'inter'),
                    labelColor: Colors.black,
                    unselectedLabelStyle: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'inter'),
                    unselectedLabelColor: Colors.black.withOpacity(0.6),
                    indicatorColor: Colors.transparent,
                    onTap: _changeTab,
                    tabs: const [
                      Tab(text: 'All categories'),
                      Tab(text: 'セキュリティニュース'),
                      Tab(text: 'International'),
                      Tab(text: 'Europe'),
                      Tab(text: 'American'),
                      Tab(text: 'Asian'),
                      Tab(text: 'Sports'),
                    ],
                  ),
                ),

                // 分类内容
                IndexedStack(
                  index: _categoryTabController.index,
                  children: [
                    // 第一个标签：全部新闻
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: allCategoriesNews.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          return NewsTile(data: allCategoriesNews[index]);
                        },
                      ),
                    ),

                    // 其他标签页的占位符
                    for (int i = 1; i < 7; i++)
                      SizedBox(
                        child: Center(
                          child: Text('category page $i'),
                        ),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
