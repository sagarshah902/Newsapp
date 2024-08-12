import 'package:flutter/material.dart';
import 'package:navi_app/pages/news_detail_page.dart';
import 'package:navi_app/services/news_service.dart';
import 'package:navi_app/utils/news_data.dart';

class NewsEventsSection extends StatefulWidget {
  const NewsEventsSection({super.key});

  @override
  _NewsEventsSectionState createState() => _NewsEventsSectionState();
}

class _NewsEventsSectionState extends State<NewsEventsSection> {
  List<News>? articleList;
  bool isNewsLoading = true;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    getArticleData();
  }

  Future<void> getArticleData() async {
    setState(() {
      isNewsLoading = true;
      errorMessage = ''; // Clear previous error messages
    });

    try {
      final newsService = NewsService();
      articleList = await newsService.fetchNews(); // Fetch news data
    } catch (e) {
      debugPrint('Error fetching news events: $e');
      errorMessage = 'Failed to load news';
    } finally {
      setState(() {
        isNewsLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'News Events',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          if (isNewsLoading)
            const Center(child: CircularProgressIndicator())
          else if (errorMessage.isNotEmpty)
            Center(child: Text(errorMessage))
          else if (articleList == null || articleList!.isEmpty)
            const Center(child: Text('No news available'))
          else
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (var news in articleList!)
                      Container(
                        margin: const EdgeInsets.only(right: 16),
                        width: 300, // Fixed width for each item
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                pageBuilder:
                                    (context, animation, secondaryAnimation) =>
                                        NewsDetailPage(news: news),
                                transitionsBuilder: (context, animation,
                                    secondaryAnimation, child) {
                                  const begin = Offset(0.0, 1.0);
                                  const end = Offset.zero;
                                  const curve = Curves.ease;
                                  final tween = Tween(begin: begin, end: end);
                                  final curvedAnimation = CurvedAnimation(
                                    parent: animation,
                                    curve: curve,
                                  );
                                  return SlideTransition(
                                    position: tween.animate(curvedAnimation),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: Image.network(
                                  news.imageUrl.isNotEmpty
                                      ? news.imageUrl
                                      : 'https://via.placeholder.com/300x200',
                                  width: 300,
                                  height: 200,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                news.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                news.description,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
