import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/settings/setting_controller.dart';

class SettingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SettingController());
  }
}
