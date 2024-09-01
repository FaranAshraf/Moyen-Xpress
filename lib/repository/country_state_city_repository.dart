import 'package:moyen_express/model/countries/city_model.dart';
import 'package:moyen_express/model/countries/countries_model.dart';
import 'package:moyen_express/model/countries/state_model.dart';

import '../resources/exports/index.dart';

class CSCRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static Future<List<Country>> getCountriesName() async {
    final response = await apiService.getApi(Urls.COUNTRIES);

    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      return response.map((item) => Country.fromJson(item)).toList();
    } else {
      return response;
    }
  }

  static Future<List<CountryState>> getCountryState({required id}) async {
    final response = await apiService.getApi(
      "/api/v2/states-by-country/$id",
    );
    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      return response.map((item) => CountryState.fromJson(item)).toList();
    } else {
      return response;
    }
  }

  static Future<List<Cities>> getStateCity({required id}) async {
    final response = await apiService.getApi(
      "/api/v2/cities-by-state/$id",
    );
    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      return response.map((item) => Cities.fromJson(item)).toList();
    } else {
      return response;
    }
  }

  static Future<void> location({
    required String address,
    required int countryId,
    required int stateId,
    required int cityId,
    required String postalCode,
    required String phone,
  }) async {
    try {
      final response = await apiService.postUpdatedAPI(Urls.ADD_NEW_ADDRESS, {
        "address": address,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "postal_code": postalCode,
        "phone": phone,
      });
      if (response is bool) return;
      CustomSnackBar.showSnackBar(
          message: response, snackBarStyle: SnackBarStyle.success);
      // log.e(response);
      return response;
    } catch (e) {
      log.e(e.toString());
    }
  }

  static Future<List<AddressData>> seeAddress() async {
    final response = await apiService.getApi(Urls.SEE_LOCATIONS);
    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      return response.map((item) => AddressData.fromJson(item)).toList();
    } else {
      return response;
    }
  }

  static Future<void> deleteLocation({
    required productId,
  }) async {
    try {
      final response =
          await apiService.getCheck("/api/v2/user/shipping/delete/$productId");
      if (response is bool) return;
      CustomSnackBar.showSnackBar(
          message: response, snackBarStyle: SnackBarStyle.success);
      if (kDebugMode) {
        print(response);
      }
    } catch (e) {
      CustomSnackBar.showSnackBar(
          message: e.toString(), snackBarStyle: SnackBarStyle.warning);
      log.e(e);
    }
  }

  static Future<void> updateAddress({
    required int id,
    required String address,
    required int countryId,
    required int stateId,
    required int cityId,
    required String postalCode,
    required String phone,
  }) async {
    try {
      final response = await apiService.postUpdatedAPI(Urls.UPDATE_LOCATION, {
        "id":id,
        "address": address,
        "country_id": countryId,
        "state_id": stateId,
        "city_id": cityId,
        "postal_code": postalCode,
        "phone": phone,
      });
      if (response is bool) return;
      CustomSnackBar.showSnackBar(
          message: response, snackBarStyle: SnackBarStyle.success);
      // log.e(response);
      return response;
    } catch (e) {
      log.e(e.toString());
    }
  }
}
