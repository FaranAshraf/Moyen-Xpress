import 'package:moyen_express/resources/exports/index.dart';


import '../../../repository/wallet_repository.dart';

class WithDrawController extends GetxController {
  late Timer _apiTimer;

  Future<void> getWallet() async {
    await WalletRepository.getWithdrawRequest();
  }

  void startApiTimer() {
    const duration = Duration(seconds: 5);
    _apiTimer = Timer.periodic(duration, (_) {
      getWallet();
    });
  }

  @override
  void onInit() {
    super.onInit();
    startApiTimer();
    getWallet();
  }

  @override
  void onClose() {
    _apiTimer.cancel();  // Cancel the timer when the controller is closed
    super.onClose();
  }
}
