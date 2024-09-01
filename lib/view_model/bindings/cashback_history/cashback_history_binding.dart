import 'package:moyen_express/resources/exports/index.dart';

import '../../controllers/cashback_history/cashback_history_controller.dart';

class CashBackHistoryBinding extends Bindings{
  @override
  void dependencies(){
      Get.lazyPut(() => CashBackController());
  }
}