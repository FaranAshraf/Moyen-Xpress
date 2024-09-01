import 'package:moyen_express/resources/exports/index.dart';

import '../../../model/filter_model/filter_model.dart';
import '../filter_product/filter_product_controller.dart';

class NewArrivalController extends GetxController {
  var dropDownValue = 'newest'.obs;
  var items = ['newest', 'oldest', 'cheapest', 'expensive'];

  void updateSortBy(String value) {
    dropDownValue.value = value;
    updateProducts();
  }

  GridController gridController = Get.find<GridController>();
  late final PagingController<int, HomeCategoriesModel> pagingController;
  RxList<CarBrand?> brands = <CarBrand?>[].obs;
  Rx<CarBrand?> selectedBrand = Rx<CarBrand?>(null);
  RxString valueItem = "All Brands".obs;
  Future<void> fetchBrands() async {
    try {
      brands.value = await HomeRepository.getFilters();
      if (brands.isNotEmpty) {
        selectedBrand.value = valueItem.value as CarBrand?;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error fetching data: $e');
      }
    }
  }

  void onBrandSelected(CarBrand? brand) {
    selectedBrand.value = brand;
    updateProducts();
  }

  void updateProducts() {
    pagingController.refresh();
  }

  static BaseApiServices apiService = NetworkApiServices();

  _getList(int pageIndex) async {
    try {
      List<HomeCategoriesModel> itemsList = [];
      Map<String, dynamic> queryParameters = {};

      queryParameters["page"] = pageIndex.toString();
      queryParameters["limit"] = Urls.PAGESIZE.toString();
      queryParameters["sort_by"] = dropDownValue.value;
      queryParameters["brand"] = selectedBrand.value?.name ?? "";

      var apiResponse = await apiService.getApi(
        Urls.CATEGORIES,
        quaryParameters: queryParameters,
      );

      if (apiResponse is bool) return [];
      itemsList = HomeCategoriesModel.listFromJson(apiResponse);

      return itemsList;
    } catch (e) {
      log.e(e.toString());
    }
  }

  Future<void> _fetchPage(int pageKey) async {
    try {
      final newItems = await _getList(pageKey);
      final isLastPage = newItems.length < Urls.PAGESIZE;
      if (isLastPage) {
        pagingController.appendLastPage(newItems);
      } else {
        final nextPageKey = pageKey + 1;
        pagingController.appendPage(newItems, nextPageKey.toInt());
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  @override
  void onInit() {
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener(_fetchPage);
    fetchBrands();
    gridController.resetFilters();
    super.onInit();
  }
}
