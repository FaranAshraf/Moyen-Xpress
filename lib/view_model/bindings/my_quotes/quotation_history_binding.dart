import '../../../resources/exports/index.dart';
import '../../controllers/my_quote/quotation_history.dart';


class QuotationHistoryBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuotationHistoryController());
  }
}
