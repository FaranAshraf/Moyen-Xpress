import '../../../resources/exports/index.dart';
import '../../controllers/my_quote_replies/quotation_replies_controller.dart';


class QuoteRepliesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuoteRepliesController());
  }
}
