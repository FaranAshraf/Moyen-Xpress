import 'package:moyen_express/repository/wallet_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';

class WithDrawRequestController extends GetxController {
  late TextEditingController amountController;
  late TextEditingController stripeId;
  late TextEditingController stripeMessage;
  late TextEditingController payPalId;
  late TextEditingController payPalMessage;
  late TextEditingController bankName;
  late TextEditingController bankAccName;
  late TextEditingController bankAccNo;
  late TextEditingController bankRoutingNo;
  late TextEditingController bankMessage;

  Future<void> postWithDrawRequest() async {
    await WalletRepository.postWithDraw(
        amount: amountController.text.toString(),
        withDrawType: dropDownValue.value,
        stripeId: stripeId.text,
        message: stripeMessage.text.isEmpty
            ? (payPalMessage.text.isEmpty
                ? (bankMessage.text.isEmpty ? "" : bankMessage.text)
                : payPalMessage.text)
            : stripeMessage.text,
        payPalId: payPalId.text,
        bankName: bankName.text,
        bankAccName: bankAccName.text,
        bankAccNumber: bankAccNo.text,
        bankRoutingNumber: bankRoutingNo.text);
        onClear();
  }

  onClear(){
    amountController.clear();
    stripeId.clear();
    stripeMessage.clear();
    payPalId.clear();
    payPalMessage.clear();
    bankName.clear();
    bankAccName.clear();
    bankAccNo.clear();
    bankRoutingNo.clear();
    bankMessage.clear();
  }

  @override
  void onInit() {
    amountController = TextEditingController();
    stripeId = TextEditingController();
    stripeMessage = TextEditingController();
    payPalId = TextEditingController();
    payPalMessage = TextEditingController();
    bankName = TextEditingController();
    bankAccName = TextEditingController();
    bankAccNo = TextEditingController();
    bankRoutingNo = TextEditingController();
    bankMessage = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    amountController.dispose();
    stripeId.dispose();
    stripeMessage.dispose();
    payPalId.dispose();
    payPalMessage.dispose();
    bankName.dispose();
    bankAccName.dispose();
    bankAccNo.dispose();
    bankRoutingNo.dispose();
    bankMessage.dispose();
    super.dispose();
  }

  var dropDownValue = 'Stripe'.obs;
  var items = [
    'Stripe',
    'Paypal',
    'Bank Transfer',
  ];
}
