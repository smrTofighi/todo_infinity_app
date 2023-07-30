import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';

import '../../core/utils/storage_key.dart';

class DioService {
  Dio dio = Dio();
  Future<dynamic> getMethod(String url) async {
    dio.options.headers['content-Type'] = 'application/json';
    var token = GetStorage().read(StorageKeys.token);
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }
    return await dio
        .get(url,
            options: Options(responseType: ResponseType.json, method: 'GET'))
        .then((response) {
      return response;
    });
  }

  Future<dynamic> postMethod(String url) async {
    dio.options.headers['content-Type'] = 'application/json';

    var token = GetStorage().read(StorageKeys.token);
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio
        .post(url,
            //data: dio_service.FormData.fromMap(map),
            options: Options(responseType: ResponseType.json, method: 'POST'))
        .then((response) {
      return response;
    });
  }

  Future<dynamic> deleteMethod(String url) async {
    dio.options.headers['content-Type'] = 'application/json';

    var token = GetStorage().read(StorageKeys.token);
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio
        .delete(url,

            //data: dio_service.FormData.fromMap(map),
            options: Options(responseType: ResponseType.json, method: 'DELETE'))
        .then((response) {
      return response;
    });
  }

  Future<dynamic> putMethod(String url) async {
    dio.options.headers['content-Type'] = 'application/json';

    var token = GetStorage().read(StorageKeys.token);
    if (token != null) {
      dio.options.headers['Authorization'] = 'Bearer $token';
    }

    return await dio
        .delete(url,

            //data: dio_service.FormData.fromMap(map),
            options: Options(responseType: ResponseType.json, method: 'PUT'))
        .then((response) {
      return response;
    });
  }
}
