import '../../../resources/exports/index.dart';

class FlashDealsController extends GetxController {
  late final PagingController<int, ListViewModel> pagingController;
  static BaseApiServices baseApiService = NetworkApiServices();
  FlashDealsModel flashDeal = FlashDealsModel();

  Future<void> fetchPage(int pageKey) async {
    try {
      final newItems = await getList(pageKey);
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

  getList(int pageIndex, {bool dummyData = true}) async {
    try {
      Map<String, dynamic> quaryParameters = {};

      quaryParameters["page"] = pageIndex.toString();
      quaryParameters["limit"] = Urls.PAGESIZE.toString();

      var apiResponse = await baseApiService.getApi(
        Urls.FLASH_DEAL,
        quaryParameters: quaryParameters,
      );

      if (apiResponse is bool) return [];
      flashDeal = FlashDealsModel.fromJson(apiResponse);
      return flashDeal.items;
    } catch (e) {
      log.e(e.toString());
    }
  }

  @override
  void onInit() {
    flashDeal.duration =
        Get.arguments != null ? Get.arguments["duration"] : null;
    flashDeal.discountPer =
        Get.arguments != null ? Get.arguments["discountPer"] : null;
    update(["flash_deals_timer"]);
    pagingController = PagingController(firstPageKey: 1);
    pagingController.addPageRequestListener(fetchPage);
    super.onInit();
  }
}
