import 'package:moyen_express/resources/exports/index.dart';

import '../../controllers/Cash_payment/Cash_payment_controller.dart';


class CashPaymentBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => CashPaymentController());
  }

}