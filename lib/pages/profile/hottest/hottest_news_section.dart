import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:navi_app/pages/news_detail_page.dart';
import 'package:navi_app/services/news_service.dart';
import 'package:navi_app/utils/news_card.dart';
import 'package:navi_app/utils/news_data.dart';

class HottestNewsSection extends StatelessWidget {
  const HottestNewsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Hottest News',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder<List<News>>(
            future: NewsService().fetchNews(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No news available.'));
              }

              final hottestNews = snapshot.data!;
              return CarouselSlider.builder(
                itemCount: hottestNews.length,
                itemBuilder: (context, index, realIdx) {
                  final news = hottestNews[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NewsDetailPage(news: news),
                        ),
                      );
                    },
                    child: NewsCard(news: news),
                  );
                },
                options: CarouselOptions(
                  height: 360,
                  enlargeCenterPage: true,
                  autoPlay: true,
                  aspectRatio: 16 / 9,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enableInfiniteScroll: true,
                  viewportFraction: 0.8,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
