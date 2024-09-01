import 'package:moyen_express/resources/exports/index.dart';

import '../../controllers/mobile_payment/mobile_payment_controller.dart';


class MobilePaymentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => MobilePaymentController());
  }

}