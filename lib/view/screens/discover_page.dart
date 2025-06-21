import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:digital_omamori/view/widgets/embedded_search_bar.dart';
import 'package:digital_omamori/model/core/news.dart';
import 'package:digital_omamori/model/helper/news_helper.dart';
import 'package:digital_omamori/model/helper/api_service.dart';
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
  List<News> searchResults = [];
  final TextEditingController searchInputController = TextEditingController();
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    _categoryTabController = TabController(length: 4, vsync: this); // 4 tabs
  }

  @override
  void dispose() {
    _categoryTabController.dispose();
    searchInputController.dispose();
    super.dispose();
  }

  void _changeTab(int index) {
    setState(() {
      _categoryTabController.index = index;
      searchResults.clear(); // 切换 Tab 清空搜索结果
    });
  }

  Future<void> _performSearch() async {
    final keyword = searchInputController.text.trim();
    if (keyword.isEmpty) return;

    setState(() {
      isSearching = true;
    });

    try {
      final paginated = await ApiService().searchNews(keyword: keyword);
      setState(() {
        searchResults = paginated.data;
        _categoryTabController.index = 0;
      });
    } catch (e) {
      print('搜索失败: $e');
    } finally {
      setState(() {
        isSearching = false;
      });
    }
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
        actions: [],
      ),
      body: ListView(
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        children: [
          // 嵌入式搜索栏
          EmbeddedSearchBar(
            controller: searchInputController,
            onSearch: _performSearch,
          ),

          // 标签栏 + 新闻内容
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
                      Tab(text: '全てのニュース'),
                      Tab(text: 'セキュリティニュース'),
                      Tab(text: '脆弱性情報'),
                      Tab(text: '法令関連動向'),
                    ],
                  ),
                ),

                // 标签内容或搜索结果
                IndexedStack(
                  index: _categoryTabController.index,
                  children: [
                    // 第一个 Tab 页面：搜索结果 or 全部新闻
                    Container(
                      width: MediaQuery.of(context).size.width,
                      child: ListView.separated(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        scrollDirection: Axis.vertical,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: searchResults.isNotEmpty
                            ? searchResults.length
                            : allCategoriesNews.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final data = searchResults.isNotEmpty
                              ? searchResults[index]
                              : allCategoriesNews[index];
                          return NewsTile(data: data);
                        },
                      ),
                    ),

                    // 其他 3 个分类 Tab 页面
                    for (int i = 1; i < 4; i++)
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
