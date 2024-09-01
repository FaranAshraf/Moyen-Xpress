import 'package:moyen_express/resources/exports/index.dart';

class PurchaseHistoryDetailController extends GetxController {
  late String id = "";
  late String purchaseId = "";
  late String dateTime;

  @override
  void onInit() {
    id = Get.arguments != null ? Get.arguments['id'] : "";
    purchaseId = Get.arguments != null ? Get.arguments['purchaseId'] : "";
    dateTime = Get.arguments != null ? Get.arguments['dateTime']:"";

    super.onInit();
  }
}
