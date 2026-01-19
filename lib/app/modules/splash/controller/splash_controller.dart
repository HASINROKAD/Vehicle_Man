import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:vehicle_man/app/modules/auth/auth_controller.dart';
import 'package:vehicle_man/app/routes/app_routes.dart';

class SplashController extends GetxController {
  final RxBool showLoader = false.obs;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void onInit() {
    super.onInit();
    handleNavigation();
  }

  Future<void> handleNavigation() async {
    try {
      showLoader.value = true;

      await Future.delayed(const Duration(seconds: 2));

      final user = _auth.currentUser;
      if (user == null) {
        Get.offAllNamed(AppRoutes.loginView);
        return;
      }

      // ✅ Restore session data
      final authController = Get.find<AuthController>();
      await authController.restoreUserSession();

      Get.offAllNamed(AppRoutes.homeView);
    } catch (e) {
      Get.offAllNamed(AppRoutes.loginView);
    } finally {
      showLoader.value = false;
    }
  }
}
