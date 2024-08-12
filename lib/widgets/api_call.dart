import 'package:flutter/material.dart';
import 'package:navi_app/services/news_service.dart';
import 'package:navi_app/utils/news_data.dart';
import 'package:navi_app/utils/news_card.dart';

class ApiNewsWidget extends StatelessWidget {
  const ApiNewsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('News')),
      body: FutureBuilder<List<News>>(
        future: NewsService().fetchNews(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No news available.'));
          }

          final news = snapshot.data!;
          return ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: news.length,
            itemBuilder: (context, index) {
              return NewsCard(news: news[index]);
            },
          );
        },
      ),
    );
  }
}
