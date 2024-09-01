import 'package:moyen_express/view_model/controllers/inquiry_note/inquiry_notes_controller.dart';

import '../../../resources/exports/index.dart';

class InquiryNotesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InquiryNotesController());
  }
}
