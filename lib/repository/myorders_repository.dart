import 'package:moyen_express/model/my_orders/quote_orders_model.dart';

import '../model/my_orders/quote_order_detail_model.dart';
import '../model/my_orders/shipping_orders.dart';
import '../model/my_orders/shipping_quote_detail_model.dart';
import '../model/my_orders/shipping_quote_model.dart';
import '../resources/exports/index.dart';

class MyOrderRepository {
  static BaseApiServices apiService = NetworkApiServices();
   static Future<List<QuoteOrders>?> getQuoteHistory() async {
    final response = await apiService.getApi(Urls.QUOTE_ORDERS);
    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      log.e("Response: $response");
      return response.map((item) => QuoteOrders.fromJson(item)).toList();
    } else {
      return null;
    }
  }

 static Future<List<QuoteOrderDetail>?> getQuoteHistoryDetail({required int id}) async {
    final response = await apiService.getApi("/api/appV1/customer_quotes_orders/$id");
    if (response is List) {
      if (kDebugMode) {
        // print(response);
      }
      return response.map((item) => QuoteOrderDetail.fromJson(item)).toList();
    } else {
      return null;
    }
  }

//Shipping Quote Function
static Future<List<ShipmentQuotes>?> getShippingQuote() async {
    final response = await apiService.getApi(Urls.SHIPPING_QUOTES);
    if (response is List) {
      if (kDebugMode) {
        // print(response);
      }
      // log.e("Response test: $response");
      return response.map((item) => ShipmentQuotes.fromJson(item)).toList();
    } else {
      return null;
    }
  }
  

static Future<QuoteDetail?> getQuoteDetail({required int id}) async {
  try {
    final response = await apiService.getApi("/api/appV1/customer_shipping_quote_details/$id");
    if (kDebugMode) {
      print('API Response: $response');
    }
    return QuoteDetail.fromJson(response);
  } catch (e) {
    return null;
  }
}



 static Future<List<ShippingOrders>?> getShippingOrders() async {
    final response = await apiService.getApi(Urls.SHIPPING_ORDERS);
    if (response is List) {
      if (kDebugMode) {
        // print(response);
      }
      log.e("Response: $response");
      return response.map((item) => ShippingOrders.fromJson(item)).toList();
    } else {
      return null;
    }
  }
}