import 'package:dartz/dartz.dart';
import 'package:nynews/source/data/popular_news.dart';
import 'package:nynews/source/dependency_Injection/di.dart';
import 'package:nynews/model/errors/api_exception.dart';

abstract class IPopularRepository {
  getPopulars({section, period});
}
//'all-sections'

class PopularRepository implements IPopularRepository {
  final IPopularDataSource _dataSource = locator.get();
  @override
  Future getPopulars({section, period}) async {
    try {
      final response =
          await _dataSource.getPopular(section: section, period: period);
      return response;
    } on ApiException catch (ex) {
      return left(ex.message ?? 'somthing error');
    }
  }
}
