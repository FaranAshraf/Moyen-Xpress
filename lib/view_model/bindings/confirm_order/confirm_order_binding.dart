import 'package:moyen_express/resources/exports/index.dart';

import '../../controllers/confirm_order/confirm_order_controller.dart';

class ConfirmOrderBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ConfirmOrderController());
  }

}