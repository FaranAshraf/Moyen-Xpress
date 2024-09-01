import 'package:moyen_express/resources/exports/index.dart';

import '../../../repository/contact_repository.dart';

class MxShippingController extends GetxController {
  GlobalKey<FormState> cardKey = GlobalKey<FormState>();
  late TextEditingController productNameController;
  late TextEditingController descriptionController;
  late TextEditingController quantityController;
  late TextEditingController messageController;
  String dataDrop = "";
  Future<void> contactData() async {
    await ContactRepository.oneRequestMultipleQuote(
      productName: productNameController.text,
      description: descriptionController.text,
      quantity: quantityController.text,
      message: messageController.text,
      place: dataDrop
    );
    onClear();
  }

  var selectedValue = Strings.PLACE_.obs;

  void setSelectedValue(String value) {
    selectedValue.value = value;
  }

  onClear() {
    productNameController.clear();
    descriptionController.clear();
    quantityController.clear();
    messageController.clear();
  }

  @override
  void onInit() {
    cardKey = GlobalKey<FormState>();
    productNameController = TextEditingController();
    descriptionController = TextEditingController();
    quantityController = TextEditingController();
    messageController = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    productNameController.dispose();
    descriptionController.dispose();
    quantityController.dispose();
    messageController.dispose();

    super.dispose();
  }
}
