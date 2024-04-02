import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/models/news_model.dart';

class NewsRepository {
  Future<List<NewsModel>> fetchNews() async {
    List<NewsModel> newsList = [];
    var response = await http.get(
      Uri.parse(
          "https://newsapi.org/v2/top-headlines?country=us&apiKey=ab3b6086568c4c00ad6c843bf2aa2cf5"),
    );

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      for (var article in data["articles"]) {
        NewsModel newsModel = NewsModel.fromJson(article);
        newsList.add(newsModel);
      }
      return newsList;
    } else {
      throw Exception('Failed to Load The Data');
    }
  }
}
