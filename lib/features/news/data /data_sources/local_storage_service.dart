import 'dart:convert';
import 'package:news_app/features/news/data%20/models/news_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const _keySavedNews = 'saved_news';

  Future<List<NewsModel>> getSavedNews() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? newsJsonList = prefs.getStringList(_keySavedNews);
    if (newsJsonList == null) return [];

    final List<NewsModel> savedNews = [];
    for (final jsonString in newsJsonList) {
      try {
        final decoded = json.decode(jsonString);
        if (decoded is Map<String, dynamic>) {
          final news = NewsModel.fromJson(decoded);
          savedNews.add(news);
        } else {
          print('Некорректный формат: $decoded');
        }
      } catch (e) {
        print('Ошибка при десериализации: $e');
        print('Некорректная строка JSON: $jsonString');
      }
    }
    return savedNews;
  }


  Future<void> saveNews(NewsModel news) async {
    final prefs = await SharedPreferences.getInstance();
    final newsList = await getSavedNews();
    if (!newsList.any((item) => item.title == news.title)) {
      newsList.add(news);
      final List<String> newsJsonList = newsList.map((n) => json.encode(n.toJson())).toList();
      await prefs.setStringList(_keySavedNews, newsJsonList);
    }
  }

  Future<void> removeNews(NewsModel news) async {
    final prefs = await SharedPreferences.getInstance();
    final newsList = await getSavedNews();
    newsList.removeWhere((item) => item.title == news.title);
    final List<String> newsJsonList = newsList.map((n) => json.encode(n.toJson())).toList();
    await prefs.setStringList(_keySavedNews, newsJsonList);
  }
}