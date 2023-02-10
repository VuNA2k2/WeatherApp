

import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../config/config.dart';

class WeatherAPI {
  final Dio dio;

  WeatherAPI(
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

  Future<Response> getWeatherByLocationAtDate({required int locationId, required DateTime date}) async {
    final Response response = await dio.get(EndPoints.getWeatherByLocationAtDate, queryParameters: {
      "location_id": locationId,
      "date": "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
    });
    return response;
  }

}
