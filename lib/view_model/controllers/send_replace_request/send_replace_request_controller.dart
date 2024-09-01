import 'package:moyen_express/repository/send_request_refund_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';

class SendReplaceRequestController extends GetxController {
  Future<void> sendRequest() async {
    await SendRefundRequestRepository.sendReplaceRequest();
  }

  
  @override
  void onInit() {
    sendRequest();
    super.onInit();
  }
}
