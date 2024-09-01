import 'package:moyen_express/repository/inquiries_repository.dart';

import '../../../model/inquiries/inquiries_detail_model.dart';
import '../../../resources/exports/index.dart';

class InquiryDetailController extends GetxController {
  int? isReplied = 0;
  int? id = 0;
  late TextEditingController productName;
  late TextEditingController quantity;
  late TextEditingController deliveryAddress;
  late TextEditingController myNote;

  late TextEditingController productName1;
  late TextEditingController quantity1;
  late TextEditingController perUnitPrice;
  late TextEditingController totalPrice;
  late TextEditingController deliveryCharges;
  late TextEditingController estDeliveryDays;
  late TextEditingController deliveryAddress1;
  late TextEditingController myNote1;
  late TextEditingController sellerNote;

  InquiryDetailModel? testValue;
  Future<void> getInquiryDetail({required id}) async {
    try {
      testValue = await InquiriesRepository.getInquiriesDetail(id: id);

      // Update text controllers with received data
      productName.text = testValue?.productName ?? '';
      quantity.text = testValue?.productQty.toString() ?? '';
      deliveryAddress.text = testValue?.deliveryAddress ?? '';
      myNote.text = testValue?.userNote ?? '';

      productName1.text = testValue?.productName ?? '';
      quantity1.text = testValue?.productQty.toString() ?? '';
      perUnitPrice.text = testValue?.pricePerUnit.toString() ?? '';
      totalPrice.text = testValue?.totalPrice.toString() ?? '';
      deliveryCharges.text = testValue?.deliveryCharges.toString() ?? '';
      estDeliveryDays.text = testValue?.deliveryDays.toString() ?? '';
      deliveryAddress1.text = testValue?.deliveryAddress.toString() ?? '';
      myNote1.text = testValue?.userNote.toString() ?? '';
      sellerNote.text = testValue?.sellerNote.toString() ?? '';
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching inquiry details: $e');
      }
    }
  }
  @override
  void onInit() {
    productName = TextEditingController();
    quantity = TextEditingController();
    deliveryAddress = TextEditingController();
    myNote = TextEditingController();

    productName1 = TextEditingController();
    quantity1 = TextEditingController();
    perUnitPrice = TextEditingController();
    totalPrice = TextEditingController();
    deliveryCharges = TextEditingController();
    estDeliveryDays = TextEditingController();
    deliveryAddress1 = TextEditingController();
    myNote1 = TextEditingController();
    sellerNote = TextEditingController();

    isReplied = Get.arguments != null ? Get.arguments['isReplied'] : 0;
    id = Get.arguments != null ? Get.arguments['id'] : 0;
    getInquiryDetail(id: id);
    super.onInit();
  }

  @override
  void dispose() {
    productName.dispose();
    quantity.dispose();
    deliveryAddress.dispose();
    myNote.dispose();

    productName1.dispose();
    quantity1.dispose();
    perUnitPrice.dispose();
    totalPrice.dispose();
    deliveryCharges.dispose();
    estDeliveryDays.dispose();
    deliveryAddress1.dispose();
    myNote1.dispose();
    sellerNote.dispose();
    super.dispose();
  }
}

