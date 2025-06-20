import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:digital_omamori/model/core/news.dart'; // 根据你的路径修改

class ApiService {
  static const String baseUrl = 'http://10.0.2.2:8080/public/php/mobile';

  Future<List<News>> fetchLatestNews() async {
  try {
    final url = Uri.parse('$baseUrl/fetch_latest.php');
    final response = await http.get(url);

    print('📡 请求 URL: $url');
    print('📡 状态码: ${response.statusCode}');
    print('📡 返回内容: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      final newsList = News.fromJsonList(jsonList);

      // 拼接图片路径
      return newsList.map((news) {
        news.photo = '$baseUrl/image_fetch.php?id=${news.id}';
        return news;
      }).toList();
    } else {
      throw Exception('状態コード異常: ${response.statusCode}');
    }
  } catch (e, stack) {
    print('❌ 例外発生: $e');
    print('🔍 Stacktrace:\n$stack');
    throw Exception('API通信エラー: $e');
  }
}


  
  
}
