import 'package:dio/dio.dart';
import 'package:nynews/consts/private_key.dart';
import 'package:nynews/model/section/sections.dart';
import 'package:nynews/source/dependency_Injection/di.dart';
import 'package:nynews/model/errors/api_exception.dart';

abstract class ISectionDataSource {
  Future<List<SectionsModel>> getSections();
}

class SectionRemote extends ISectionDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<SectionsModel>> getSections() async {
    try {
      final response = await _dio.get(PrivateKey.getAllSections);
      return response.data['results']
          .map<SectionsModel>(
              (jsonObject) => SectionsModel.fromJSon(jsonObject))
          .toList();
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'somthing error');
    }
  }
}
