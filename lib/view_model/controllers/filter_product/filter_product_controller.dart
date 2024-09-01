
import '../../../model/countries/city_model.dart';
import '../../../model/countries/countries_model.dart';
import '../../../model/countries/state_model.dart';
import '../../../repository/country_state_city_repository.dart';
import '../../../resources/exports/index.dart';

class GridController extends GetxController {
  RxInt selectedRatingFilter = 0.obs;

  void updateRating(int rating) {
    if (kDebugMode) {
      print('Updating rating to: $rating');
    }
    selectedRatingFilter.value = rating;
  }

  void resetFilters() {
    selectedRatingFilter.value = 0;
    colorCode.value = '';
    minPrice.value = '';
    maxPrice.value = '';
    countryId = 0;
    stateId = 0;
    cityId = 0;
  }

  late Rx<RangeValues> values;
  late Rx<RangeLabels> labels;
  Cities city = Cities();
  Country country = Country();
  CountryState state = CountryState();
  int countryId = 0;
  int stateId = 0;
  int cityId = 0;
  RxString colorCode = ''.obs;
  RxString minPrice = ''.obs;
  RxString maxPrice = ''.obs;
  var showAll = false.obs;

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

  @override
  void onInit() {
    values = Rx<RangeValues>(const RangeValues(0.00, 10000.0));
    labels = Rx<RangeLabels>(
      RangeLabels(
        values.value.start.toStringAsFixed(2),
        values.value.end.toStringAsFixed(2),
      ),
    );

    super.onInit();
  }

  void toggleShowAll() {
    showAll.value = !showAll.value;
  }

  void updateLabels(RangeValues newValues) {
    values.value = newValues;
    labels.value = RangeLabels(
      newValues.start.toStringAsFixed(2),
      newValues.end.toStringAsFixed(2),
    );
  }
}
