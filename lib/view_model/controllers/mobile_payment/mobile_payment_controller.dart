import '../../../model/payment/payment_model.dart';
import '../../../repository/payment_repository.dart';
import '../../../resources/exports/index.dart';

class MobilePaymentController extends GetxController {
  late GlobalKey<FormState> wireKey;
  late TextEditingController country;
  late TextEditingController business;
  late TextEditingController mobileCompany;
  late TextEditingController mobileNumber;
  PaymentSuccess? testValue;
  String walletPrice = "";
  var image = Rx<File?>(null);

  @override
  void onInit() {
    // Initialize controllers and call getPaymentValue
    country = TextEditingController();
    business = TextEditingController();
    mobileCompany = TextEditingController();
    mobileNumber = TextEditingController();
    getPaymentValue(); // Call getPaymentValue during initialization
    super.onInit();
  }

  @override
  void dispose() {
    // Dispose of controllers
    country.dispose();
    business.dispose();
    mobileCompany.dispose();
    mobileNumber.dispose();
    super.dispose();
  }

  final PaymentMethodController payController =
      Get.put(PaymentMethodController());
  Future<void> postMobilePayment() async {
    await PaymentRepository.wireTransfer(
        imageName: "country_mobile_payment_image",
        paymentMethod: "mobile_payment",
        ssAttachment: image.value);
  }

  Future<void> pickImageFromCamera() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        image.value = File(pickedFile.path);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image from camera: $e');
      }
    }
  }

  Future<void> pickImageFromGallery() async {
    final picker = ImagePicker();
    try {
      final pickedFile = await picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        image.value = File(pickedFile.path);
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error picking image from gallery: $e');
      }
    }
  }

  Future<void> getPaymentValue() async {
    try {
      testValue = await PaymentRepository.getPayment();
      if (testValue != null && testValue!.balance != null) {
        walletPrice = testValue!.balance.toString();
        update(); // Update the UI only when necessary
      }
      // Update text controllers with received data
      country.text = testValue?.mobilePayments?.country ?? '';
      business.text = testValue?.mobilePayments?.business ?? '';
      mobileCompany.text = testValue?.mobilePayments?.mobileCompany ?? '';
      mobileNumber.text = testValue?.mobilePayments?.mobileNumber ?? '';
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching payment details: $e');
      }
    }
  }
}
