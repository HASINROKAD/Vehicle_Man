import 'package:get/get.dart';
import 'package:vehicle_man/app/modules/auth/auth_controller.dart';
import 'package:vehicle_man/app/modules/auth/login/controller/login_controller.dart';
import 'package:vehicle_man/app/modules/auth/register/controller/register_controller.dart';
import 'package:vehicle_man/app/modules/home/controller/vehicle_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VehicleController(), fenix: true);
    Get.lazyPut(() => RegisterController(), fenix: true);
    Get.lazyPut(() => LoginController(), fenix: true);
    Get.lazyPut(() => AuthController(), fenix: true);
  }
}
