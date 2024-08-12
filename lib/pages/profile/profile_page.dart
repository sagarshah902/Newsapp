import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:navi_app/pages/profile/hottest/hottest_news_section.dart';
import 'package:navi_app/widgets/explore_section.dart';
import 'package:navi_app/widgets/news_events_section.dart';
import 'package:navi_app/widgets/profile_appbar.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    log("print");
    return const Scaffold(
      appBar: ProfileAppBar(),
      body: Padding(
        padding: EdgeInsets.only(top: 10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HottestNewsSection(),
              ExploreSection(),
              NewsEventsSection(),
            ],
          ),
        ),
      ),
    );
  }
}
