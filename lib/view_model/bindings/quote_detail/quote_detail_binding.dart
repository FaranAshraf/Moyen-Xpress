
import 'package:moyen_express/view_model/controllers/quote_detail/quote_detail_controller.dart';

import '../../../resources/exports/index.dart';

class QuoteDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => QuoteDetailController());
  }
}
