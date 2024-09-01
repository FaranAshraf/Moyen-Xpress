import 'package:moyen_express/repository/send_request_refund_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';

class SendRefundRequestController extends GetxController {
  Future<void> sendRequest() async {
    await SendRefundRequestRepository.sendRefundRequest();
  }

  var dropDownValue = ''.obs;
  var items = [
    'Pending',
    'On the way',
    'Dropped',
  ];
  @override
  void onInit() {
    sendRequest();
    super.onInit();
  }
}
