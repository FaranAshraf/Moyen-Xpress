
import '../model/track_shipment/track_shipment_model.dart';
import '../resources/exports/index.dart';

class TrackShipmentRepository {
  static BaseApiServices apiService = NetworkApiServices();
    static Future<TrackShipment?> getShippingInfo({
    required String trackShipment,
  }) async {
    final response = await apiService.postApi(Urls.TRACK_SHIPMENT, {
      "tracking_id": trackShipment,
    });
    if (response is bool) return null;
    log.e(response);
    return TrackShipment.fromJson(response);
  }
}