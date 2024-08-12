import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:navi_app/pages/profile/profile_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // List of image URLs for the carousel
    final List<String> imgList = [
      'https://images.unsplash.com/photo-1504711434969-e33886168f5c',
      'https://images.unsplash.com/photo-1512453979798-5ea266f8880c',
    ];

    return Scaffold(
      body: Column(
        children: [
          // Image Carousel Section
          Expanded(
            flex: 5,
            child: CarouselSlider.builder(
              itemCount: imgList.length,
              itemBuilder: (context, index, realIdx) {
                return Image.network(
                  imgList[index],
                  fit: BoxFit.cover,
                  width: double.infinity,
                );
              },
              options: CarouselOptions(
                height: 300,
                autoPlay: true,
                enlargeCenterPage: true,
                aspectRatio: 16 / 9,
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enableInfiniteScroll: true,
                viewportFraction: 0.8,
              ),
            ),
          ),
          // Text Section
          const Expanded(
            flex: 3,
            child: Padding(
              padding: EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Text(
                    'Get the latest and updated news easily with us',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Stay informed with our up-to-date news portal.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 30),
                ],
              ),
            ),
          ),
          // Button Section
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        const ProfilePage(), // Navigate to ProfilePage
                  ),
                );
              },
              child: const Text('Go to News Portal'),
            ),
          ),
        ],
      ),
    );
  }
}
