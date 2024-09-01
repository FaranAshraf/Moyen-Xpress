import '../../../repository/my_quotes_repositories.dart';
import '../../../resources/exports/index.dart';

class  QuotationHistoryController extends GetxController{
  Future<void> quotationHistory()async{
    await MyQuoteRepository.getQuotationHistory();
  }


  @override
  void onInit() {
    quotationHistory();
    super.onInit();
  }
}