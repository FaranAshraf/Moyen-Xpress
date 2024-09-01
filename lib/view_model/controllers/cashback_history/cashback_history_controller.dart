import 'package:moyen_express/repository/wallet_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';

class CashBackController extends GetxController {
  Future<void> getCash() async {
    await WalletRepository.getCashBacks();
  }

  @override
  void onInit() {
    getCash();
    super.onInit();
  }
}
