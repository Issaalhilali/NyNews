import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nynews/source/bloc/news/news_bloc.dart';
import 'package:nynews/source/bloc/news/news_event.dart';
import 'package:nynews/source/bloc/section/bloc/section_bloc.dart';
import 'package:nynews/source/dependency_Injection/di.dart';
import 'package:nynews/view/home_screen.dart';
import 'package:nynews/view/widghet/details_news.dart';

void main() {
  getItInit();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NewsBloc>(create: (context) {
          var bloc = NewsBloc();
          bloc.add(NewsDataEvent(section: 'all-sections', period: '30'));
          return bloc;
        }),
        BlocProvider<SectionBloc>(create: (context) => SectionBloc()),
      ],
      child: MaterialApp(
        title: 'NYNews Time',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        initialRoute: '/',
        routes: {
          NewsScreen.route: (context) => const NewsScreen(),
          DetailsNews.route: (context) => const DetailsNews(),
        },
      ),
    );
  }
}
