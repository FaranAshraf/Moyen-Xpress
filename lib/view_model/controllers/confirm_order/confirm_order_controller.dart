import 'package:moyen_express/model/order_done_model/order_done_model.dart';
import 'package:moyen_express/repository/payment_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';

class ConfirmOrderController extends GetxController {
  Rx<OrderDone?> orderData = Rx<OrderDone?>(null);
  // ignore: unused_field
  late Timer _timer;
  bool isTrue = false;
  OrderDone? orderCheck = OrderDone();
  Future<OrderDone?> getConfirmOrder(id) async {
    orderCheck = await PaymentRepository.getDoneConfirmation(id: id);
    update(["123"]);
    return orderCheck;
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      PaymentRepository.getDoneConfirmation(
          id: PaymentRepository.orderId.toString());
      update(["timer"]);
    });
  }

  // ignore: unused_field
  @override
  void onInit() {
    super.onInit();
    startTimer();
    loadData(id: PaymentRepository.orderId);
  }

  Future<OrderDone?> loadData({required dynamic id}) async {
    await PaymentRepository.getDoneConfirmation(id: id);
    update(["orderData"]);
    return null;
  }
}
