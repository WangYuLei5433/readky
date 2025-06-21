import 'package:flutter/material.dart';
import 'package:digital_omamori/model/core/news.dart';
import 'package:digital_omamori/model/helper/api_service.dart';
import 'package:digital_omamori/view/widgets/custom_app_bar.dart';
import 'package:digital_omamori/view/widgets/news_tile.dart';

class BreakingNewsPage extends StatefulWidget {
  @override
  _BreakingNewsPageState createState() => _BreakingNewsPageState();
}

class _BreakingNewsPageState extends State<BreakingNewsPage> {
  List<News> newsList = [];
  int currentPage = 1;
  bool isLoading = false;
  bool hasMore = true;
  final ScrollController _scrollController = ScrollController();
  final int limit = 10;

  @override
  void initState() {
    super.initState();
    fetchNews();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
              _scrollController.position.maxScrollExtent - 200 &&
          !isLoading &&
          hasMore) {
        fetchNews();
      }
    });
  }

  Future<void> fetchNews() async {
    setState(() => isLoading = true);
    try {
      final response =
          await ApiService().fetchNewsByPage(page: currentPage, limit: limit);
      setState(() {
        newsList.addAll(response.data);
        currentPage++;
        hasMore = currentPage <= response.totalPages;
      });
    } catch (e) {
      print('Error fetching news: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        leadingIcon: Icon(Icons.arrow_back_ios, color: Colors.white),
        onPressedLeading: () => Navigator.of(context).pop(),
        title: Text(
          'Recent News',
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: ListView.separated(
        controller: _scrollController,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        itemCount: newsList.length + 1,
        separatorBuilder: (_, __) => SizedBox(height: 16),
        itemBuilder: (context, index) {
          if (index < newsList.length) {
            return NewsTile(data: newsList[index]);
          } else {
            return isLoading
                ? Center(child: CircularProgressIndicator())
                : hasMore
                    ? SizedBox.shrink()
                    : Center(child: Text('すべて読み込みました'));
          }
        },
      ),
    );
  }
}
