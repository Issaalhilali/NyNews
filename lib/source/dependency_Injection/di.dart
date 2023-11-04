import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:nynews/consts/private_key.dart';
import 'package:nynews/source/data/popular_news.dart';
import 'package:nynews/source/data/section_news.dart';
import 'package:nynews/source/repository/popular_repository.dart';
import 'package:nynews/source/repository/section_repository.dart';

var locator = GetIt.instance;

getItInit() {
  Map<String, dynamic> parmeters = {
    'api-key': PrivateKey.API_KEY,
  };
  // components
  locator.registerSingleton<Dio>(Dio(BaseOptions(
      baseUrl: 'http://api.nytimes.com/',
      queryParameters: parmeters,
      connectTimeout: const Duration(seconds: 6),
      receiveTimeout: const Duration(seconds: 6))));

  //dataSource
  locator.registerFactory<IPopularDataSource>(() => PopularRemote());
  locator.registerFactory<ISectionDataSource>(() => SectionRemote());

//repository
  locator.registerFactory<IPopularRepository>(() => PopularRepository());
  locator.registerFactory<ISectionRepository>(() => SectionRepository());
}
