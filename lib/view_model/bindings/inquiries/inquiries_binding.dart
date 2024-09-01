import 'package:moyen_express/view_model/controllers/inquiries/inquiries_controller.dart';

import '../../../resources/exports/index.dart';

class InquiriesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InquiriesController());
  }
}
