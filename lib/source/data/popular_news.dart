import 'package:dio/dio.dart';
import 'package:nynews/consts/private_key.dart';
import 'package:nynews/model/popular/popular.dart';
import 'package:nynews/source/dependency_Injection/di.dart';
import 'package:nynews/model/errors/api_exception.dart';

abstract class IPopularDataSource {
  Future<List<Popular>> getPopular({section, period});
}

class PopularRemote extends IPopularDataSource {
  final Dio _dio = locator.get();
  @override
  Future<List<Popular>> getPopular({section, period}) async {
    try {
      final response = await _dio
          .get(PrivateKey.getPopular(section: section, period: period));
      if (response.statusCode == 200) {
        return response.data['results']
            .map<Popular>((jsonObject) => Popular.fromJSon(jsonObject))
            .toList();
      } else {
        throw ApiException(0, 'Somthing error');
      }
    } on DioException catch (ex) {
      throw ApiException(ex.response?.statusCode, ex.response?.data['message']);
    } catch (ex) {
      throw ApiException(0, 'somthing error');
    }
  }
}
