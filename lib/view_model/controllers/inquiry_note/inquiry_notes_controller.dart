import 'package:moyen_express/repository/inquiries_repository.dart';

import '../../../resources/exports/index.dart';

class InquiryNotesController extends GetxController {
  int? id;
  int? sellerId;
  late TextEditingController note;
  late GlobalKey<FormState> noteKey;

  Future<void> getInquiryNotes({required id}) async {
    await InquiriesRepository.getInquiriesNotes(id: id);
  }

  @override
  void onInit() {
    noteKey = GlobalKey<FormState>();
    note = TextEditingController();
    id = Get.arguments != null ? Get.arguments['id'] : 0;
    sellerId = Get.arguments != null ? Get.arguments['sellerId'] : 0;
    log.e("seller Id: $sellerId");
    log.e("Id: $id");

    getInquiryNotes(id: id);
    super.onInit();
  }

  @override
  void dispose() {
    note.dispose();
    super.dispose();
  }

  Future<void> postInquiry() async {
    if (noteKey.currentState?.validate() ?? false) {
      await InquiriesRepository.postInquiryNotes(
          note: note.text, productId: id, receiveId: sellerId);
          
    }
    note.clear();
  }
}
