import 'package:moyen_express/model/payment/payment_model.dart';
import 'package:moyen_express/repository/payment_repository.dart';

import '../../../resources/exports/index.dart';

class CashPaymentController extends GetxController {
  late GlobalKey<FormState> wireKey;
  late TextEditingController country;
  late TextEditingController business;
  late TextEditingController address;

  PaymentSuccess? testValue = PaymentSuccess();
  Rx<File?> image = Rx<File?>(null);
  final PaymentMethodController payController =
      Get.put(PaymentMethodController());
  Future<void> postCashPayment() async {
    await PaymentRepository.wireTransfer(
         imageName: "country_cash_payment_image",
        paymentMethod: "cash_payment",
        ssAttachment: image.value);
  }

  @override
  void onInit() {
    wireKey = GlobalKey<FormState>();
    country = TextEditingController();
    business = TextEditingController();
    address = TextEditingController();
    getPaymentValue();

    super.onInit();
  }

  @override
  void dispose() {
    country.dispose();
    business.dispose();
    address.dispose();
    super.dispose();
  }

  Future<void> getPaymentValue() async {
    testValue = await PaymentRepository.getPayment();
    country.text = testValue?.cashPayments?.country.toString() ?? '';
    business.text = testValue?.cashPayments?.business.toString() ?? '';
    address.text = testValue?.cashPayments?.address.toString() ?? '';
    update();
  }

  Future<File?> pickImageFromCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      return File(pickedFile.path);
    } else {
      return null;
    }
  }

  Future<File?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image.value = File(pickedFile.path);
      return File(pickedFile.path);
    } else {
      return null;
    }
  }
}
