import 'package:moyen_express/model/product_detail/product_detail_model.dart';

import '../model/filter_model/filter_model.dart';
import '../resources/exports/index.dart';

class HomeRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<List<ListViewModel>> getAllProducts() async {
    final response = await apiService.getApi(
      Urls.PRODUCT_LISTING,
      quaryParameters: {"page": 1, "limit": 4},
    );
    if (response is bool) return [];

    return ListViewModel.listFromJson(response);
  }

  static Future<List<HomeCategoriesModel>> getCategories() async {
    final response = await apiService.getApi(
      Urls.CATEGORIES,
      quaryParameters: {"page": 1, "limit": 8},
    );
    if (response is bool) return [];

    return HomeCategoriesModel.listFromJson(response);
  }

  static Future<List<ListViewModel>> getTopBrands() async {
    final response = await apiService.getApi(
      Urls.TOP_BRANDS,
      quaryParameters: {"page": 1, "limit": 8},
    );
    if (response is bool) return [];

    return ListViewModel.listFromJson(response);
  }

  static Future<List<ListViewModel>> getTopSellers() async {
    final response = await apiService.getApi(
      Urls.TOP_SELLERS,
      quaryParameters: {"page": 1, "limit": 8},
    );
    if (response is bool) return [];

    return ListViewModel.listFromJson(response);
  }

  static Future<List<ListViewModel>> getPromotions() async {
    final response = await apiService.getApi(
      Urls.PROMOTIONS,
      quaryParameters: {"page": 1, "limit": 8},
    );
    if (response is bool) return [];

    return ListViewModel.listFromJson(response);
  }

  static Future<List<ListViewModel>> getNewArrivals() async {
    final response = await apiService.getApi(
      Urls.NEW_ARRIVALS,
      quaryParameters: {"page": 1, "limit": 8},
    );
    if (response is bool) return [];

    return ListViewModel.listFromJson(response);
  }

  static Future<List<ListViewModel>> getDailyDeals() async {
    final response = await apiService.getApi(
      Urls.DAILY_DEALS,
      quaryParameters: {"page": 1, "limit": 8},
    );
    if (response is bool) return [];

    return ListViewModel.listFromJson(response);
  }

  static Future<FlashDealsModel?> getFlashDeals() async {
    final response = await apiService.getApi(
      Urls.FLASH_DEAL,
      quaryParameters: {"page": 1, "limit": 10},
    );
    if (response is bool) return null;

    return FlashDealsModel.fromJson(response);
  }

  static Future<BannersModel?> getBanners() async {
    final response = await apiService.getApi(Urls.HOME_BANNERS);
    if (response is bool) return null;
    return BannersModel.fromJson(response);
  }

  static Future<SuccessContents?> newsBar() async {
    final response = await apiService.getApi(Urls.NEWS_BAR);
    if (response is bool) return null;
    return SuccessContents.fromJson(response);
  }

  static Future<ProductData?> getProductDetail(int productId) async {
    final response = await apiService.getApi(
      Urls.PRODUCT_DETAIL,
      quaryParameters: {"product_id": productId.toString()},
    );
    if (response is bool) return null;
    if (kDebugMode) {
      print(response);
      print(response["id"]);
    }
    return ProductData.fromJson(response);
  }

  static Future<void> askQuestions({
    required question,
    required productId,
  }) async {
    final response = await apiService.postApi(Urls.ASK_QUESTIONS, {
      "question": question,
      "product_id": productId,
    });
    if (response is bool) return;
  }

  static Future<List<SuccessContent>?> getSubCategories(
      {required subId}) async {
    final response = await apiService.getApi("/api/v2/sub-categories/$subId");

    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      return response.map((item) => SuccessContent.fromJson(item)).toList();
    } else {
      return null;
    }
  }

  static Future<List<ListViewModel>> getTechnician() async {
    final response = await apiService.getApi(
      Urls.TECHNICIAN,
      quaryParameters: {"page": 1, "limit": 8},
    );
    if (response is bool) return [];

    return ListViewModel.listFromJson(response);
  }

  static Future<List<ListViewModel>> getAuction() async {
    final response = await apiService.getApi(
      Urls.AUCTION,
      quaryParameters: {"page": 1, "limit": 8},
    );
    if (response is bool) return [];

    return ListViewModel.listFromJson(response);
  }

  static Future<List<CarBrand?>> getFilters() async {
    final response = await apiService.getApi(Urls.BRANDS);

    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      return response.map((item) => CarBrand.fromJson(item)).toList();
    } else {
      print('why asynchronious suspension');
      return [];
    }
  }

  static Future<List<ColorsBrand?>> getColors() async {
    final response = await apiService.getApi(Urls.COLORS);

    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      return response.map((item) => ColorsBrand.fromJson(item)).toList();
    } else {
      return response;
    }
  }

  static Future<List<ListViewModel>> getWholeSaleProducts() async {
    final response = await apiService.getApi(
      Urls.WHOLESALES_PRODUCTS,
    );
    if (response is bool) return [];

    return ListViewModel.listFromJson(response);
  }
}
