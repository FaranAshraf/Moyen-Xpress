import 'package:moyen_express/resources/exports/index.dart';

class QuoteDetailController extends GetxController{
  late int id = 0;
 @override
  void onInit() {
    id = Get.arguments != null ? Get.arguments['id'] : 0;
    log.e(id);
    // getDetail();
    super.onInit();
  }
}