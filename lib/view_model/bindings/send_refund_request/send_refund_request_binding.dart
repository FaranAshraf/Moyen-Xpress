import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/send_refund_request/send_refund_request_controller.dart';

class SendRefundRequestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SendRefundRequestController());
  }
}
