import 'package:moyen_express/resources/exports/index.dart';

import '../../controllers/withdraw_request_history/withdraw_request_history.dart';

class WithDrawRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WithDrawRequestController());
  }
}
