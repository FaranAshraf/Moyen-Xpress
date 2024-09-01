import 'package:moyen_express/resources/exports/index.dart';

class ShippingQuoteController extends GetxController{
  int id=0;
  int check=0;
 @override
  void onInit() {
    id = Get.arguments != null ? Get.arguments["id"] : 0;
    check = Get.arguments != null ? Get.arguments["check"] : 0;
    log.e(id);
    super.onInit();
  }
}