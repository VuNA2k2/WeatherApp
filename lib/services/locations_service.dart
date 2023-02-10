

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/config.dart';

class LocationsAPI {
  final Dio dio;

  LocationsAPI(
      Dio? dio,
      ) : dio = dio ?? Dio() {
    this.dio.interceptors.add(PrettyDioLogger(
      responseBody: true,
      requestBody: true,
      requestHeader: true,
    ));
    final BaseOptions options = BaseOptions(
      baseUrl: EndPoints.idBaseUrl,
      sendTimeout: 30000,
      receiveTimeout: 30000,
      followRedirects: false,
      validateStatus: (status) {
        return status! <= 500;
      },
      headers: {
        "Accept": "application/json",
        "content-type": "application/json"
      },
    );
    this.dio.options = options;
  }

  Future<Response> getLocation({String? id}) async {
    final Response response = await dio.get(EndPoints.getLocations, queryParameters: {
      "id": id,
    });
    return response;
  }

}
