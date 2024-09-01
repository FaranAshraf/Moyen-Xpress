import 'package:moyen_express/repository/ship_with_moyen_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';

import '../../../model/ship_with_moyen/ship_with_moyen_model.dart';
import '../shipping_description/shipping_description_controller.dart';

class GetQuoteController extends GetxController {
  final ShippingDescriptionController shippingDescriptionController =
      Get.put(ShippingDescriptionController());
  GlobalKey<FormState> name1Key = GlobalKey<FormState>();
  GlobalKey<FormState> name2Key = GlobalKey<FormState>();
  GlobalKey<FormState> name3Key = GlobalKey<FormState>();
  GlobalKey<FormState> name4Key = GlobalKey<FormState>();
  GlobalKey<FormState> name5Key = GlobalKey<FormState>();
  String itemType = "";
  String shipType = "";
  String shipVia = "";
  var pName = ''.obs;
  var pWeight = ''.obs;
  var pLength = ''.obs;
  var pWidth = ''.obs;
  var pHeight = ''.obs;

  late TextEditingController productName;
  late TextEditingController weight;
  late TextEditingController length;
  late TextEditingController width;
  late TextEditingController height;
  late TextEditingController quantity;

  String fromCountry = "";
  String fromState = "";
  String fromCity = "";

  String toCountry = "";
  String toState = "";
  String toCity = "";
  RxString anotherDropdownValue = ''.obs;
  List<ShippingProducts> anotherDropdownItems = <ShippingProducts>[].obs;
  // For From Form
  late TextEditingController fromFullName;
  late TextEditingController fromEmail;
  late TextEditingController fromPhoneNumber;
  late TextEditingController fromPostalCode;
  late TextEditingController fromBusinessEmail;
  late TextEditingController fromBusinessPhoneNo;
  late TextEditingController fromAddress1;
  late TextEditingController fromAddress2;

  // For To Form
  late TextEditingController toFullName;
  late TextEditingController toEmail;
  late TextEditingController toPhoneNumber;
  late TextEditingController toPostalCode;
  late TextEditingController toBusinessEmail;
  late TextEditingController toBusinessPhoneNo;
  late TextEditingController toAddress1;
  late TextEditingController toAddress2;

  //Package Detail
  late TextEditingController description;
  late TextEditingController valueOfItem;

  var dropDownValue = 'New Member'.obs;
  var items = [
    'New Member',
    'Moyen Xpress Member',
  ];

  var dropDownValue1 = 'Documents'.obs;
  var items1 = [
    'Documents',
    'Parcels',
  ];

  var dropDownValue2 = 'Domestic'.obs;
  var items2 = [
    'Domestic',
    'International',
  ];

  var dropDownValue3 = 'Air Freight'.obs;
  var items3 = ['Air Freight', 'Ocean Freight', 'By Road'];

  RxList<Widget> generateAddOne = <Widget>[].obs;

  generateDynamicWidget() {
    int newIndex = generateAddOne.length;
    generateAddOne.add(ShipmentDescriptionForm(id: 'form_$newIndex'));
  }

  List<String> selectedProductNames = [];
  List<String> selectedWeights = [];
  List<String> selectedLengths = [];
  List<String> selectedWidths = [];
  List<String> selectedHeights = [];
  List<String> selectedQuantities = [];

  Future<void> contactData() async {
    await ShipWithMoyenRepository.shipWithMoyenForm(
      itemType: itemType,
      shipType: shipType,
      shipVia: shipVia,
      fromName: fromFullName.text,
      fromEmail: fromEmail.text,
      fromPhone: fromPhoneNumber.text,
      fromCountry: fromCountry,
      fromState: fromState,
      fromCity: fromCity,
      fromPostalCode: fromPostalCode.text,
      fromBusinessEmail: fromBusinessEmail.text,
      fromBusinessPhone: fromBusinessPhoneNo.text,
      fromAddress_1: fromAddress1.text,
      fromAddress_2: fromAddress2.text,
      toName: toFullName.text,
      toEmail: toEmail.text,
      toPhone: toPhoneNumber.text,
      toCountry: toCountry,
      toState: toState,
      toCity: toCity,
      toPostalCode: toPostalCode.text,
      toBusinessEmail: toBusinessEmail.text,
      toBusinessPhone: toBusinessPhoneNo.text,
      toAddress_1: toAddress1.text,
      toAddress_2: toAddress2.text,
      productName: selectedProductNames,
      weight: selectedWeights,
      length: selectedLengths,
      width: selectedWidths,
      height: selectedHeights,
      quantity: selectedQuantities,
      description: description.text,
      valueOfItems: valueOfItem.text,
      shipmentDate: dateController.text,
    );

    onClear();
    // Get.offAllNamed(Routes.DASHBOARD);
  }

  onClear() {
    fromFullName.clear();
    fromEmail.clear();
    fromPhoneNumber.clear();
    fromPostalCode.clear();
    fromBusinessEmail.clear();
    fromBusinessPhoneNo.clear();
    fromAddress1.clear();
    fromAddress2.clear();

    toFullName.clear();
    toEmail.clear();
    toPhoneNumber.clear();
    toPostalCode.clear();
    toBusinessEmail.clear();
    toBusinessPhoneNo.clear();
    toAddress1.clear();
    toAddress2.clear();

    productName.clear();
    weight.clear();
    length.clear();
    width.clear();
    height.clear();
    quantity.clear();

    description.clear();
    valueOfItem.clear();
  }

  TextEditingController dateController = TextEditingController();

  datePick(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));

    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      dateController.text = formattedDate;
    } else {
      if (kDebugMode) {
        print("Date is not selected");
      }
    }
  }

  var dropdownItems = <String>[].obs; // Observable list to hold dropdown items
  var selectedValues =
      <String?>[].obs; // Observable list to hold selected values for each form
  var formKeys = <GlobalKey<FormState>>[].obs;

  void addNewShippingForm() {
    if (dropdownItems.isNotEmpty) {
      selectedValues.add(
          dropdownItems.first); // Initialize with the first item if available
      formKeys.add(GlobalKey<FormState>()); // Add a new form key
    }
  }

  // Set selected value for a specific form
  void setSelectedValue(int index, String value) {
    selectedValues[index] = value;
  }

  @override
  void onInit() {
    productName = TextEditingController();
    weight = TextEditingController();
    length = TextEditingController();
    width = TextEditingController();
    height = TextEditingController();
    quantity = TextEditingController(text: "1");

    addNewShippingForm();
    fromFullName = TextEditingController();
    fromEmail = TextEditingController();
    fromPhoneNumber = TextEditingController();
    fromPostalCode = TextEditingController();
    fromBusinessEmail = TextEditingController();
    fromBusinessPhoneNo = TextEditingController();
    fromAddress1 = TextEditingController();
    fromAddress2 = TextEditingController();

    toFullName = TextEditingController();
    toEmail = TextEditingController();
    toPhoneNumber = TextEditingController();
    toPostalCode = TextEditingController();
    toBusinessEmail = TextEditingController();
    toBusinessPhoneNo = TextEditingController();
    toAddress1 = TextEditingController();
    toAddress2 = TextEditingController();

    description = TextEditingController();
    valueOfItem = TextEditingController();
    ever(pName, (_) => productName.text = pName.value);
    ever(pWeight, (_) => weight.text = pWeight.value);
    ever(pLength, (_) => length.text = pLength.value);
    ever(pWidth, (_) => width.text = pWidth.value);
    ever(pHeight, (_) => height.text = pHeight.value);

    super.onInit();
  }

  @override
  void dispose() {
    fromFullName.dispose();
    fromEmail.dispose();
    fromPhoneNumber.dispose();
    fromPostalCode.dispose();
    fromBusinessEmail.dispose();
    fromBusinessPhoneNo.dispose();
    fromAddress1.dispose();
    fromAddress2.dispose();

    toFullName.dispose();
    toEmail.dispose();
    toPhoneNumber.dispose();
    toPostalCode.dispose();
    toBusinessEmail.dispose();
    toBusinessPhoneNo.dispose();
    toAddress1.dispose();
    toAddress2.dispose();

    productName.dispose();
    weight.dispose();
    length.dispose();
    width.dispose();
    height.dispose();
    quantity.dispose();

    description.dispose();
    valueOfItem.dispose();
    super.dispose();
  }
}
