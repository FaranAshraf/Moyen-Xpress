import '../../../resources/exports/index.dart';

class QuoteRepliesController extends GetxController {
  int? replyId;
 
  @override
  void onInit() {
    replyId = Get.arguments != null ? Get.arguments['replyId'] : 0;
    log.e(replyId);

    super.onInit();
  }
}




// {{url}}/appV1/send_inquiry_detail

// {
//     "product_id": 1441,
//     "product_qty": 2,
//     "note": "I would like to inquire about the delivery time.",
//     "size": "M",
//     "colour": "Red",
//     "delivery_address": "123 Main Street, Springfield, USA"
// }