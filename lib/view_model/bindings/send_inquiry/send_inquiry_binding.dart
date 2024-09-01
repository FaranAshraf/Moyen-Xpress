import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/send_inquiry/send_inquiry_controller.dart';

class SendInquiryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SendInquiryController());
  }
}
