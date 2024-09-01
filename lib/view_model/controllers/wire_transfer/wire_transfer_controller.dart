import 'package:moyen_express/resources/exports/index.dart';

import '../../../model/payment/payment_model.dart';
import '../../../repository/payment_repository.dart';

class WireTransferController extends GetxController {
  late GlobalKey<FormState> wireKey;
  late TextEditingController bankAccNumber;
  late TextEditingController bankRouteNumber;
  late TextEditingController swiftCode;
  late TextEditingController beneficiary;
  late TextEditingController bankName;
  late TextEditingController address;
  var image = Rx<File?>(null);
  PaymentSuccess? testValue = PaymentSuccess();
  Future<void> getPaymentValue() async {
    testValue = await PaymentRepository.getPayment();
    bankAccNumber.text =
        testValue?.wireTransfer?.bankAccountNumber.toString() ?? '';
    bankRouteNumber.text =
        testValue?.wireTransfer?.bankRoutingNumber.toString() ?? '';
    swiftCode.text = testValue?.wireTransfer?.swiftCode ?? '';
    beneficiary.text = testValue?.wireTransfer?.beneficiary ?? '';
    bankName.text = testValue?.wireTransfer?.bankName ?? '';
    address.text = testValue?.wireTransfer?.address ?? '';
    update();
  }

  final PaymentMethodController payController =
      Get.put(PaymentMethodController());
  Future<void> getWireTransfer() async {
    await PaymentRepository.wireTransfer(
        imageName: "bank_transfer_image",
        paymentMethod: "bank_transfer",
        ssAttachment: image.value);
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

  @override
  void onInit() {
    log.e(payController.totalPrice.toString());
    bankAccNumber = TextEditingController();
    bankRouteNumber = TextEditingController();
    swiftCode = TextEditingController();
    beneficiary = TextEditingController();
    bankName = TextEditingController();
    address = TextEditingController();
    getPaymentValue();
    super.onInit();
  }

  @override
  void dispose() {
    bankAccNumber.dispose();
    bankRouteNumber.dispose();
    swiftCode.dispose();
    beneficiary.dispose();
    bankName.dispose();
    address.dispose();
    super.dispose();
  }
}
