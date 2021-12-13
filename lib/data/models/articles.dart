class Article {
  late String title;
  late String url;
  String? urlToImage;
  late String publishedAt;

  Article.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    url = json['url'];
    urlToImage = json['urlToImage'];
    publishedAt = _dateAndTime(json['publishedAt']);
  }

  String _dateAndTime(String publishedAt) {
    // "2021-10-18T06:41:00Z"
    var splitted = publishedAt.split('T');
    return '${splitted[0]} - ${splitted[1].substring(0, 5)}';
  }
}
