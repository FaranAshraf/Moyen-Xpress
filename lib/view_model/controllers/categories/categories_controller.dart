import 'package:moyen_express/resources/exports/index.dart';

class CategoriesController extends GetxController {
  late final PagingController<int, HomeCategoriesModel> pagingController;
  final OnBoardingController onBoardingController =
      Get.put(OnBoardingController());
  static BaseApiServices apiService = NetworkApiServices();
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

  _getList(int pageIndex) async {
    try {
      List<HomeCategoriesModel> itemsList = [];
      Map<String, dynamic> quaryParameters = {};

      quaryParameters["page"] = pageIndex.toString();
      quaryParameters["limit"] = Urls.PAGESIZE.toString();

      var apiResponse = await apiService.getApi(
        Urls.CATEGORIES,
        quaryParameters: quaryParameters,
      );

      if (apiResponse is bool) return [];
      itemsList = HomeCategoriesModel.listFromJson(apiResponse);

      return itemsList;
    } catch (e) {
      log.e(e.toString());
    }
  }

  DashboardController instance = Get.find();
  @override
  void onInit() {
    super.onInit();
Future.delayed(const Duration(seconds: 7), () {
    // Check if the controller is initialized and of type CategoriesController
    if (Get.isRegistered<CategoriesController>()) {
      CustomDialog.showDialog(
          width: 350,
          height: 600,
          content: const BannerView(img: Assets.ANIMATED_BANNER3));
    }
  });

    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener(_fetchPage);
  }
}
