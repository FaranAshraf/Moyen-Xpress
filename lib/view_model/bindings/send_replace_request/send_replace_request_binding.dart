import 'package:moyen_express/resources/exports/index.dart';

import '../../controllers/send_replace_request/send_replace_request_controller.dart';

class SendReplaceRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SendReplaceRequestController());
  }
}
