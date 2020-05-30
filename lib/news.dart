import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:newsApp/article.dart';


class News{
  List<Article> news = [];

  Future<void> getNews() async{
    String apiKey= '';
    String url = 'https://newsapi.org/v2/top-headlines?country=us&apiKey=$apiKey';

    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((e){
        Article article = Article(
          title: e['title'],
          author: e['author'],
          description: e['description'],
          urlToImage: e['urlToImage'],
          content: e['content'],
          publishedAt: DateTime.parse(e['publishedAt'])
        );
        news.add(article);
      });
    }
  }  
} 