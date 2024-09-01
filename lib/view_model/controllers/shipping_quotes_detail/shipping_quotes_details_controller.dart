import 'package:moyen_express/resources/exports/index.dart';

class ShippingQuoteDetailController extends GetxController{
  int check=0;
  @override
  void onInit() {
    check = Get.arguments != null ? Get.arguments["check"] : 0;
    
    super.onInit();
  }
}