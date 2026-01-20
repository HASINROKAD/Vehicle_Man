import 'package:dio/dio.dart';
import 'package:vehicle_man/data/models/city/city_model.dart';
import 'package:vehicle_man/data/models/weather/weather_model.dart';
import '../network/api_exception.dart';

class WeatherApiService {
  final Dio dio;
  final String apiKey;

  WeatherApiService(this.dio, this.apiKey);

  Future<WeatherModel> getWeather(String city) async {
    try {
      final response = await dio.get(
        '/forecast.json',
        queryParameters: {
          'key': apiKey,
          'q': city,
          'days': 1,
          'aqi': 'no',
          'alerts': 'no',
        },
      );

      return WeatherModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }

  Future<List<CityModel>> searchCity(String query) async {
    if (query.isEmpty) return [];
    try {
      final response = await dio.get(
        '/search.json',
        queryParameters: {'key': apiKey, 'q': query},
      );

      return (response.data as List).map((e) => CityModel.fromJson(e)).toList();
    } on DioException catch (e) {
      throw ApiException.fromDio(e);
    }
  }
}
