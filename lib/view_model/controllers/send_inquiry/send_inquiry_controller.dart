import 'package:moyen_express/repository/inquiries_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';

import '../../../model/product_detail/product_detail_model.dart';

class SendInquiryController extends GetxController {
  late TextEditingController product;
  late TextEditingController quantity;
  late TextEditingController deliveryAddress;
  late TextEditingController note;
  String? size = "";
  String? color = "";
  String? productName;
  int? id;
  Future<ProductData?> getProductInfo(int proId) async {
    // Make API call to get product details
    ProductData? product = await HomeRepository.getProductDetail(proId);
    return product;
  }

  Future<void> postInquiries() async {
    await InquiriesRepository.sendInquiries(
        note: note.text,
        productId: id,
        productQty: quantity.text,
        size: size,
        color: color,
        deliveryAddress: deliveryAddress.text);
    onClear();
  }

  void onClear() {
    note.clear();
    quantity.clear();
    deliveryAddress.clear();
  }

  @override
  void onInit() {
    productName = Get.arguments != null ? Get.arguments['productName'] : "";
    id = Get.arguments != null ? Get.arguments['id'] : "";
    product = TextEditingController(text: productName);
    quantity = TextEditingController();
    deliveryAddress = TextEditingController();
    note = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    product.dispose();
    quantity.dispose();
    deliveryAddress.dispose();
    note.dispose();

    super.dispose();
  }
}
