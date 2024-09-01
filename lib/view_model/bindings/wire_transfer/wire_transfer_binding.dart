import 'package:moyen_express/resources/exports/index.dart';

import '../../controllers/wire_transfer/wire_transfer_controller.dart';

class WireTransferBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => WireTransferController());
  }

}