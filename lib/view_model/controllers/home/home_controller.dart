import 'package:moyen_express/repository/region_seller_repository.dart';
import '../../../model/filter_model/filter_model.dart';
import '../../../resources/exports/index.dart';
import '../filter_product/filter_product_controller.dart';

class HomeController extends GetxController {
  TechnicianController technicianController = Get.put(TechnicianController());
  GridController gridController = Get.put(GridController());

  var dropDownValue = 'newest'.obs;
  var items = ['newest', 'oldest', 'smallest', 'largest'];
  void updateProducts() {
    pagingController.refresh();
  }

  void updateSortBy(String value) {
    dropDownValue.value = value;
    updateProducts();
  }

  late final PagingController<int, HomeCategoriesModel> pagingController;
  static BaseApiServices apiService = NetworkApiServices();

  BannersModel banners = BannersModel();
  RxBool isLoading = true.obs;
  List<HomeCategoriesModel> homeCategories = [];

  Future<void> getBanners() async {
    isLoading.value = true;
    banners = await HomeRepository.getBanners() ?? BannersModel();
    isLoading.value = false;
  }

  Future<SuccessContents?> getNews() async {
    await HomeRepository.newsBar();
    return null;
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

  Rx<CarBrand?> selectedBrand = Rx<CarBrand?>(null);
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

  RxBool colorChange = false.obs;
  void toggleColor() {
    colorChange.value = !colorChange.value;
  }

  RxBool textChange = false.obs;
  void toggleText() {
    textChange.value = !textChange.value;
  }

  Future<void> getProduct() async {
    await RegionSellerRepository.getRegionSeller();
  }

  Future<void> getProductFilter() async {
    await HomeRepository.getFilters();
  }


  @override
  void onInit() {
    gridController.resetFilters();
    
    // authManager.checkLoginStatus();
    Timer.periodic(const Duration(milliseconds: 1000), (_) {
      toggleColor();
    });
    getProductFilter();
    getBanners();
    getNews();
    getProduct();
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener(_fetchPage);
    super.onInit();
    Timer.periodic(const Duration(seconds: 2), (_) {
      toggleText();
    });
  }
}
