import 'dart:convert';

import 'package:orgnews/model/articalModel.dart';
import 'package:http/http.dart' as http;

class News {
  List<ArtiacleModel> news = [];
  Future<void> getNews() async {
    String url =
        'http://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=8c35376419f743629f57a2522bfad774';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArtiacleModel artiacleModel = ArtiacleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(artiacleModel);
        }
      });
    }
  }
}
class CategoryNews {
  List<ArtiacleModel> news = [];
  Future<void> get(String category) async {
    String url =
        'http://newsapi.org/v2/top-headlines?category=$category&country=in&apiKey=8c35376419f743629f57a2522bfad774';
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);
    if (jsonData['status'] == "ok") {
      jsonData["articles"].forEach((element) {
        if (element["urlToImage"] != null && element["description"] != null) {
          ArtiacleModel artiacleModel = ArtiacleModel(
            title: element["title"],
            author: element["author"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
          );
          news.add(artiacleModel);
        }
      });
    }
  }
}