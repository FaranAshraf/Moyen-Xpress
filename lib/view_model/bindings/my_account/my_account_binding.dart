import 'package:moyen_express/resources/exports/index.dart';

import '../../controllers/my_account/my_account_controller.dart';

class MyAccountBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MyAccountController());
  }

}