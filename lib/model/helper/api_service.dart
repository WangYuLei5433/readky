import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:digital_omamori/model/core/news.dart';

class PaginatedNews {
  final List<News> data;
  final int total;
  final int page;
  final int totalPages;

  PaginatedNews({
    required this.data,
    required this.total,
    required this.page,
    required this.totalPages,
  });

  factory PaginatedNews.fromJson(Map<String, dynamic> json) {
    final List<News> newsList = News.fromJsonList(json['data']);
    return PaginatedNews(
      data: newsList,
      total: json['total'],
      page: json['page'],
      totalPages: json['totalPages'],
    );
  }
}

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8080/public/php/mobile';

  /// 公共处理函数：为每条新闻添加图片链接
  List<News> _attachPhotoUrls(List<News> newsList) {
    return newsList.map((news) {
      news.photo = '$baseUrl/fetch_ImageBy_id.php?id=${news.id}';
      return news;
    }).toList();
  }

  Future<List<News>> fetchLatestNews() async {
    try {
      final url = Uri.parse('$baseUrl/fetch_latest.php');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body);
        final newsList = News.fromJsonList(jsonList);
        return _attachPhotoUrls(newsList);
      } else {
        throw Exception('状态码错误: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API 通信エラー: $e');
    }
  }

  Future<PaginatedNews> fetchNewsByPage({
    required int page,
    int limit = 10,
  }) async {
    try {
      final url =
          Uri.parse('$baseUrl/fetch_news_by_page.php?page=$page&limit=$limit');
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonMap = json.decode(response.body);
        final paginatedNews = PaginatedNews.fromJson(jsonMap);
        final updatedList = _attachPhotoUrls(paginatedNews.data);

        return PaginatedNews(
          data: updatedList,
          total: paginatedNews.total,
          page: paginatedNews.page,
          totalPages: paginatedNews.totalPages,
        );
      } else {
        throw Exception('状态码错误: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('API 通信エラー: $e');
    }
  }
}
