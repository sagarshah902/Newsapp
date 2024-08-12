import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:navi_app/utils/news_data.dart';

class NewsService {
  final String _baseUrl = 'https://newsapi.org/v2/everything';
  final String _apiKey = '7501ad5666964a69b4e0201bcd6c03a4';

  Future<List<News>> fetchNews({String query = 'latest'}) async {
    try {
      final response = await http.get(
        Uri.parse('$_baseUrl?q=$query&apiKey=$_apiKey'),
      );

      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        final List<dynamic> articles = data['articles'];
        return articles.map((json) => News.fromJson(json)).toList();
      } else {
        throw Exception(
            'Failed to load news. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error: $e');
      throw Exception('Failed to load news');
    }
  }
}
