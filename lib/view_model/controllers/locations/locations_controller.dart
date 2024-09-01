import 'package:moyen_express/model/countries/city_model.dart';
import 'package:moyen_express/model/countries/countries_model.dart';
import 'package:moyen_express/model/countries/state_model.dart';
import 'package:moyen_express/model/delivery_info/delivery_info_model.dart';
import 'package:moyen_express/repository/cart_repository.dart';

import 'package:moyen_express/repository/country_state_city_repository.dart';
import '../../../dummy/locations_data.dart';
import '../../../resources/exports/index.dart';

class LocationsController extends GetxController {
  AddressModel data = AddressModel();
  final box = GetStorage();
  RxInt addressId = 0.obs;
  Cities city = Cities();
  Country country = Country();
  CountryState state = CountryState();

  late TextEditingController phoneCtrl;
  late TextEditingController postalCodeCtrl;
  late TextEditingController completeAddressCtrl;
  late TextEditingController editPhoneCtrl;
  late TextEditingController editPostalCodeCtrl;
  late TextEditingController editCompleteAddressCtrl;

  late GlobalKey<FormState> addressForm;

  Future<LocationsModel> getLocationData() async {
    return Future.delayed(const Duration(microseconds: 3), () {
      return LocationsModel.fromJson(locationsData);
    });
  }

  Future<List<Country>> getCountries() async {
    List<Country> countries = await CSCRepository.getCountriesName();
    update(["country_dropdown"]);
    return countries;
  }

  Future<List<CountryState>> getCountryState(int? id) async {
    List<CountryState> states = await CSCRepository.getCountryState(id: id);
    update(["state_dropdown"]);
    return states;
  }

  Future<List<Cities>> getStateCities(int? id) async {
    List<Cities> cities = await CSCRepository.getStateCity(id: id);
    update(["city_dropdown"]);
    return cities;
  }

  Future<void> getAddresses() async {
    await CSCRepository.seeAddress();
  }

  int get selectedLocationId => box.read('selectedLocationId') ?? 0;

  // Setter for selected location ID
  set selectedLocationId(int id) {
    box.write('selectedLocationId', id);
    update();
  }

  // Toggle selected location
  void toggleSelected(int id) {
    selectedLocationId = id;
  }

  // Load selected location ID from storage
  void loadSelectedLocation() {
    selectedLocationId = box.read('selectedLocationId') ?? 0;
  }

  // void toggleSelected(int id) {
  //   selectedLocations.forEach((key, value) {
  //     if (key != id) {
  //       selectedLocations[key] = false;
  //     }
  //   });

  //   selectedLocations[id] = !(selectedLocations[id] ?? false);
  //   if (kDebugMode) {
  //     print('Toggled selected for ID: $id');
  //   }
  //   update();
  // }

// In LocationsController
  // void toggleSelected(int id) {
  //   if (selectedLocations.containsKey(id)) {
  //     selectedLocations.remove(id);
  //   } else {
  //     selectedLocations[id] = true;
  //   }
  //   update();
  // }

  List<AddressData> address = [];
  Future<void> deleteLocation(int? id) async {
    await CSCRepository.deleteLocation(productId: id);
    Get.toNamed(Routes.CART);
    update();
  }

  int countryId = 0;
  int stateId = 0;
  int cityId = 0;

  Future<void> getLocation() async {
    await CSCRepository.location(
        address: completeAddressCtrl.text,
        countryId: countryId,
        stateId: stateId,
        cityId: cityId,
        postalCode: postalCodeCtrl.text,
        phone: phoneCtrl.text);
    onClear();
    Get.toNamed(Routes.LOCATIONS);
  }

  Future<void> updateLocation(int addressId) async {
    await CSCRepository.updateAddress(
        id: addressId,
        address: editCompleteAddressCtrl.text,
        countryId: countryId,
        stateId: stateId,
        cityId: cityId,
        postalCode: editPostalCodeCtrl.text,
        phone: editPhoneCtrl.text);
    onClear();
    Get.toNamed(Routes.LOCATIONS);
  }

  RxInt selectedId = 0.obs;
  Future<List<SuccessContentInfo>?> deliveryCartInfo({required int id}) async {
    await CartRepository.deliveryInfoCart(addressId: id);
    return null;
  }

  RxString colorValue = "".obs;
  RxString sizeValue = "".obs;
  RxString attributeId = "".obs;

  RxString directColorValues = "".obs;
  RxString directSizeValues = "".obs;

  void resetValue() {
    colorValue.value = "";
    sizeValue.value = "";
    attributeId.value = "";
  }

  @override
  void onInit() {
    loadSelectedLocation();
    // getAddresses();
    addressForm = GlobalKey<FormState>();
    phoneCtrl = TextEditingController();
    postalCodeCtrl = TextEditingController();
    completeAddressCtrl = TextEditingController();
    editPhoneCtrl = TextEditingController();
    editPostalCodeCtrl = TextEditingController();
    editCompleteAddressCtrl = TextEditingController();
    super.onInit();
  }

  @override
  void dispose() {
    phoneCtrl.dispose();
    postalCodeCtrl.dispose();
    completeAddressCtrl.dispose();
    editPhoneCtrl.dispose();
    editPostalCodeCtrl.dispose();
    editCompleteAddressCtrl.dispose();
    super.dispose();
  }

  void onClear() {
    country = Country();
    state = CountryState();
    city = Cities();
    phoneCtrl.clear();
    postalCodeCtrl.clear();
    completeAddressCtrl.clear();
    update([
      "country_dropdown",
      "state_dropdown",
      "city_dropdown",
    ]);
  }
}
