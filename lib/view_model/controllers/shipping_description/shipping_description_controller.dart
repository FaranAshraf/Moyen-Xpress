import '../../../model/ship_with_moyen/ship_with_moyen_model.dart';
import '../../../repository/ship_with_moyen_repository.dart';
import '../../../resources/exports/index.dart';

class ShippingDescriptionController extends GetxController {
  final String? id;
  ShippingDescriptionController([this.id]);

  // var pName = ''.obs;
  // var pWeight = ''.obs;
  // var pLength = ''.obs;
  // var pWidth = ''.obs;
  // var pHeight = ''.obs;

  // late TextEditingController productName;
  // late TextEditingController weight;
  // late TextEditingController length;
  // late TextEditingController width;
  // late TextEditingController height;
  // late TextEditingController quantity;

  var shippingProducts = 'Nothing Selected'.obs;
  var shippingItems = <ShippingProducts>[].obs;

  Future<void> fetchShippingProducts() async {
    try {
      var response = await ShipWithMoyenRepository.getShippingProducts();
      if (response != null) {
        shippingItems.value = response;
        if (shippingItems.isNotEmpty) {
          shippingProducts.value = shippingItems.first.name ?? 'Nothing Selected';
        }
      } else {
        if (kDebugMode) {
          print('Error: Could not fetch shipping products.');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching shipping products: $e');
      }
    }
  }

  @override
  void onInit() {
    fetchShippingProducts();

    // productName = TextEditingController();
    // weight = TextEditingController();
    // length = TextEditingController();
    // width = TextEditingController();
    // height = TextEditingController();
    // quantity = TextEditingController(text: "1");

    // ever(pName, (_) => productName.text = pName.value);
    // ever(pWeight, (_) => weight.text = pWeight.value);
    // ever(pLength, (_) => length.text = pLength.value);
    // ever(pWidth, (_) => width.text = pWidth.value);
    // ever(pHeight, (_) => height.text = pHeight.value);

    super.onInit();
  }

  @override
  void dispose() {
    // productName.dispose();
    // weight.dispose();
    // length.dispose();
    // width.dispose();
    // height.dispose();
    // quantity.dispose();
    super.dispose();
  }
}