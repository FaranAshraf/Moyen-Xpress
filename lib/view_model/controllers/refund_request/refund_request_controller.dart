import 'package:file_picker/file_picker.dart';
import 'package:moyen_express/resources/exports/index.dart';

class RefundRequestController extends GetxController {
  late GlobalKey<FormState> refundRequest;
  late TextEditingController productName;
  late TextEditingController orderCode;
  late TextEditingController refundReason;
  late TextEditingController wearHouseAddress;

  var quantityType = 'Completed'.obs;
  var quantityTypeItems = ['Completed', 'Quarter', 'Single Piece'];
  RxString idCardFrontPath = "".obs;
  Future<void> pickFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      // allowedExtensions: ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (result != null) {
      File file = File(result.files.single.path!);
      idCardFrontPath.value = file.path;
    } else {
      if (kDebugMode) {
        print("Error");
      }
    }
    update();
  }

  @override
  void onInit() {
    refundRequest = GlobalKey<FormState>();
    productName = TextEditingController();
    orderCode = TextEditingController();
    refundReason = TextEditingController();
    wearHouseAddress = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    productName.dispose();
    orderCode.dispose();
    refundReason.dispose();
    wearHouseAddress.dispose();
    super.dispose();
  }
}
