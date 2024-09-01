import 'package:moyen_express/model/track_shipment/track_shipment_model.dart';
import 'package:moyen_express/repository/quote_detail_repository.dart';

import '../../../resources/exports/index.dart';

class TrackShipmentController extends GetxController {
  late GlobalKey<FormState> loginFormKey= GlobalKey<FormState>();
  var trackShipment = TextEditingController();
  var shippingInfo = Rx<TrackShipment?>(null);
  var isLoading = false.obs;

  void fetchShippingInfo() async {
    if (trackShipment.text.isEmpty) {
      return;
    }
    isLoading.value = true;
    shippingInfo.value = await TrackShipmentRepository.getShippingInfo(
        trackShipment: trackShipment.text.toString());
        log.e("Test ${shippingInfo.value}");
    isLoading.value = false;
    update(["data"]);
  }
}
