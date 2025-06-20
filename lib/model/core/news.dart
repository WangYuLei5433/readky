class News {
  String? id;
  String? title;
  String? photo;
  String? description;
  String? date;
  String? author;
  String? newsURL;
  String? category;

  News({
    this.id,
    this.title,
    this.photo,
    this.description,
    this.date,
    this.author,
    this.newsURL,
    this.category,
  });

  factory News.fromJson(Map<String, dynamic> json) {
    return News(
      id: json['id'].toString(),
      title: json['newsTitle'],
      description: json['newsContents'],
      date: json['newsDay'],
      author: json['newsCopyrightOwner'],
      newsURL: json['newsURL'],
      category: json['category_name'],
    );
  }

  /// ✅ 新增：用于处理一组 JSON 新闻数据
  static List<News> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((item) => News.fromJson(item)).toList();
  }
}
