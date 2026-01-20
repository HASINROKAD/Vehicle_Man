import 'package:get/get.dart';
import 'package:vehicle_man/data/models/city/city_model.dart';
import 'package:vehicle_man/data/models/weather/weather_model.dart';
import 'package:vehicle_man/data/repository/weather_repository.dart';

class WeatherController extends GetxController {
  final WeatherRepository repository;

  WeatherController(this.repository);

  RxBool loading = false.obs;
  RxBool searching = false.obs;

  Rx<WeatherModel?> weather = Rx<WeatherModel?>(null);
  RxList<CityModel> citySuggestions = <CityModel>[].obs;
  RxString error = ''.obs;

  void onCityChanged(String query) async {
    try {
      searching.value = true;
      citySuggestions.value = await repository.searchCity(query);
    } catch (_) {
      citySuggestions.clear();
    } finally {
      searching.value = false;
    }
  }

  void selectCity(String cityName) async {
    citySuggestions.clear();
    loadWeather(cityName);
  }

  void loadWeather(String city) async {
    try {
      loading.value = true;
      error.value = '';
      weather.value = await repository.fetchWeather(city);
    } catch (e) {
      error.value = e.toString();
    } finally {
      loading.value = false;
    }
  }
}
