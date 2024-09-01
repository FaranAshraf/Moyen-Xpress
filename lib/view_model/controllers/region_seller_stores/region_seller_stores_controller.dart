import 'package:moyen_express/resources/exports/index.dart';

class RegionSellerStoreController extends GetxController {
  int regionId = 0;

  @override
  void onInit() {
    regionId = Get.arguments != null ? Get.arguments["regionId"] : 0;
    super.onInit();
  }
}
