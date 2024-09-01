

import '../../../resources/exports/index.dart';
import '../../controllers/track_ship/track_shipment_controller.dart';

class TrackShippingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => TrackShipmentController());
  }
}
