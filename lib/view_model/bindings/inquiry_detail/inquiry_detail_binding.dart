
import '../../../resources/exports/index.dart';
import '../../controllers/inquiry_detail/inquiry_detail_controller.dart';

class InquiryDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => InquiryDetailController());
  }
}
