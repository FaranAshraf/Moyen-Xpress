import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/wallet/wallet_controller.dart';


class WalletBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => WalletController());
  }

}