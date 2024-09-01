import 'package:moyen_express/resources/exports/index.dart';

import '../../controllers/withdraw_request/withdraw_request_controller.dart';

class WithdrawBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WithDrawController());
  }
}
