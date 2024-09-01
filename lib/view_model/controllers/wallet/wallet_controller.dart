// ignore_for_file: use_build_context_synchronously, unused_field

import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:moyen_express/resources/exports/index.dart';

import '../../../repository/payment_repository.dart';
import '../../../repository/wallet_repository.dart';

class WalletController extends GetxController {
  final TextEditingController priceController = TextEditingController();
  late GlobalKey<FormState> priceKey;
  RxBool isLoading = false.obs;
  Future<void> getWallet() async {
    await WalletRepository.getWalletPrice();
  }

  AuthManager authManager = AuthManager();
  Future<void> makePayment(BuildContext context, double totalPrice) async {
    try {
      isLoading.value=true;
      int totalPriceInt = totalPrice.toInt();
      if (kDebugMode) {
        print(totalPriceInt);
      }
      final paymentIntent = await PaymentRepository.createPaymentIntent(
          totalPriceInt.toString(), 'USD');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntent['client_secret'],
        style: ThemeMode.dark,
        merchantDisplayName: 'MOYENXPRESS',
      ))
          .then((value) {
        log.w(value);
      });
      displayPaymentSheet(context);
      isLoading.value=false;

    } catch (e, s) {
      if (kDebugMode) {
        print('exception:$e$s');
      }
    }
  }

  void displayPaymentSheet(BuildContext context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      CustomSnackBar.showSnackBar(
          message: 'Payment Successfully',
          snackBarStyle: SnackBarStyle.success);
      await WalletRepository.walletRecharge(
          userId: AuthManager.instance.user!.userID!,
          amount: priceController.text,
          paymentMethod: "Stripe",
          withDrawStatus: 'Payment Successfully');
    } catch (e) {
      if (e is StripeException) {
        CustomSnackBar.showSnackBar(
            message: 'Error from Stripe: ${e.error.localizedMessage}',
            snackBarStyle: SnackBarStyle.warning);
      } else {
        CustomSnackBar.showSnackBar(
            message: 'Unforeseen error: $e',
            snackBarStyle: SnackBarStyle.warning);
      }
    }
  }

  late Timer _apiTimer;
  void startApiTimer() {
    const duration = Duration(seconds: 5);
    _apiTimer = Timer.periodic(duration, (_) {
      getWallet();
    });
  }

  @override
  void onInit() {
    startApiTimer();
    log.e(AuthManager.instance.user?.userID);
    priceKey = GlobalKey<FormState>();
    getWallet();
    super.onInit();
  }
}
