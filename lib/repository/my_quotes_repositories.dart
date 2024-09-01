import '../model/my_quotes/my_quotes_model.dart';
import '../model/my_quotes/my_quotes_replies.dart';
import '../resources/exports/index.dart';

class MyQuoteRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static Future<List<QuotationHistoryData>?> getQuotationHistory() async {
    final response = await apiService.getApi(Urls.QUOTATION_HISTORY);
    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      log.e("Response: $response");
      return response
          .map((item) => QuotationHistoryData.fromJson(item))
          .toList();
    } else {
      return null;
    }
  }
static Future<QuoteRepliesModel?> getQuoteReplies({required id}) async {
    final response = await apiService.getApi('/api/appV1/sellerQuoteRepliesToCustomer/$id');
    if (response != null && response is Map<String, dynamic>) {
      if (kDebugMode) {
        print(response);
      }
      log.e("Response trrrrrrr: $response");
      return QuoteRepliesModel.fromJson(response);
    } else {
      return null;
    }
  }
}
