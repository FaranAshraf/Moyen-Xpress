import 'package:moyen_express/model/technician/technician_detail_model.dart';

import '../../../resources/exports/index.dart';
import 'package:moyen_express/model/countries/city_model.dart';
import 'package:moyen_express/model/countries/countries_model.dart';
import 'package:moyen_express/model/countries/state_model.dart';
import 'package:moyen_express/repository/country_state_city_repository.dart';

class TechnicianController extends GetxController
    with GetSingleTickerProviderStateMixin {
  RxBool searchResult = false.obs;
  RxBool isTechProducts = false.obs;


  Cities city = Cities();
  Country country = Country();
  CountryState state = CountryState();
  int countryId = 0;
  int stateId = 0;
  int cityId = 0;
  Future<List<Country>> getCountries() async {
    List<Country> countries = await CSCRepository.getCountriesName();
    update(["country_dropdown"]);
    return countries;
  }

  void toggleSelectedImageTech(
    TechnicianDetail? product,
  ) {
    // Update selectedImageIndex
    // selectedImageIndex = index;
    // Refresh UI
    update(["product_preview_image"]);
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


}
