import 'package:dartz/dartz.dart';
import 'package:nynews/source/data/section_news.dart';
import 'package:nynews/source/dependency_Injection/di.dart';
import 'package:nynews/model/errors/api_exception.dart';

abstract class ISectionRepository {
  getSections();
}

class SectionRepository implements ISectionRepository {
  final ISectionDataSource _dataSource = locator.get();
  @override
  Future getSections() async {
    try {
      final response = await _dataSource.getSections();
      return response;
    } on ApiException catch (ex) {
      return left(ex.message ?? 'somthing error');
    }
  }
}
