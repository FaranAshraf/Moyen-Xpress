import 'package:moyen_express/resources/exports/index.dart';

import '../../controllers/purchase_history_detail/purchase_history_detail_controller.dart';

class PurchaseHistoryDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PurchaseHistoryDetailController());
  }

}