import 'package:vehicle_man/data/models/city/city_model.dart';
import 'package:vehicle_man/data/models/weather/weather_model.dart';
import 'package:vehicle_man/data/services/weather_service.dart';

class WeatherRepository {
  final WeatherApiService apiService;

  WeatherRepository(this.apiService);

  Future<WeatherModel> fetchWeather(String city) {
    return apiService.getWeather(city);
  }

  Future<List<CityModel>> searchCity(String query) {
    return apiService.searchCity(query);
  }
}
