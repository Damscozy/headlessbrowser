import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:ekcab/controller/geo_controller.dart';

class HomeController extends GetxController with StateMixin {
  @override
  void onReady() {
    super.onReady();
    checkLocation();
  }

  Future checkLocation() async {
    try {
      await GeoController.to.determinePosition();
      change(null, status: RxStatus.success());
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }
}
