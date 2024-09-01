import 'package:moyen_express/dummy/order_overview_data.dart';
import 'package:moyen_express/dummy/quote_order_data.dart';
import 'package:moyen_express/dummy/shipping_detail_data.dart';
import 'package:moyen_express/model/shipping_detail/shipping_detail_model.dart';
import 'package:moyen_express/resources/exports/index.dart';

class MyOrdersController extends GetxController {
  int id = 0;
  RxBool isShippingQuote = false.obs;
  Future<OrderOverViewModel> getProductDetails() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return OrderOverViewModel.fromJson(orderOverviewData);
    });
  }

  Future<ShippingDetailModel> getShippingDetail() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return ShippingDetailModel.fromJson(shippingDetail);
    });
  }

  Future<QuoteOrdersModel> getQuoteDetails() async {
    return await Future.delayed(const Duration(seconds: 3), () {
      return QuoteOrdersModel.fromJson(quoteOrderDetail);
    });
  }

  @override
  void onInit() {
    id = Get.arguments != null ? Get.arguments["id"] : 0;
    log.e(id);
    super.onInit();
  }
}
