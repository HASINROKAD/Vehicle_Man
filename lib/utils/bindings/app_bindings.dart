import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get.dart';
import 'package:vehicle_man/app/modules/auth/auth_controller.dart';
import 'package:vehicle_man/app/modules/auth/login/controller/login_controller.dart';
import 'package:vehicle_man/app/modules/auth/register/controller/register_controller.dart';
import 'package:vehicle_man/app/modules/home/controller/vehicle_controller.dart';
import 'package:vehicle_man/app/modules/splash/controller/splash_controller.dart';
import 'package:vehicle_man/app/modules/weather/controller/weather_controller.dart';
import 'package:vehicle_man/data/network/dio_client.dart';
import 'package:vehicle_man/data/repository/weather_repository.dart';
import 'package:vehicle_man/data/services/weather_service.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VehicleController(), fenix: true);
    Get.lazyPut(() => RegisterController(), fenix: true);
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
    Get.lazyPut(() => SplashController(), fenix: true);

    final dio = DioClient.create();

    Get.lazyPut<WeatherApiService>(
      () => WeatherApiService(dio, dotenv.env['WEATHER_API_KEY']!),
      fenix: true,
    );
    Get.lazyPut<WeatherRepository>(
      () => WeatherRepository(Get.find()),
      fenix: true,
    );
    Get.lazyPut<WeatherController>(
      () => WeatherController(Get.find()),
      fenix: true,
    );
  }
}
