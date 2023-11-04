import 'package:flutter/material.dart';
import 'package:nynews/consts/color.dart';
import 'package:nynews/view/widghet/list_news.dart';
import 'package:nynews/view/widghet/seaction_news.dart';
import 'package:nynews/view/widghet/search.dart';

class NewsScreen extends StatefulWidget {
  static const String route = '/';
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  late String? searchQuery = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.backgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
              text: 'NY',
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.orange, fontSize: 20),
              children: [
                TextSpan(
                    text: 'News',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.black, fontSize: 20)),
              ]),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Column(
              children: [
                SearchBox(
                  searchQuery: searchQuery,
                  callback: (value) {
                    setState(() {
                      searchQuery = value.toString();
                    });
                  },
                ),
                const HeadNews(),
                const SizedBox(height: 20),
                HomePage(
                  searchQuery: searchQuery,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
