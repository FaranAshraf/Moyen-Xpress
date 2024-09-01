import 'package:moyen_express/model/technician/technician_detail_model.dart';
import 'package:moyen_express/model/technician/technician_model.dart';
import '../resources/exports/index.dart';

class TechnicianRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static Future<List<Service>?> fetchServiceResponse() async {
    final response = await apiService.getApi("/api/appV1/technicians");

    // Log the raw response
    // log.e('Raw Response: $response');

    if (response is List) {
      log.e(response);
      return response.map((json) => Service.fromJson(json)).toList();
    } else {
      // Handle the case where the response is not a list
      log.e('Invalid response format: $response');
      return null; // Or throw an error if needed
    }
  }

  static Future<TechnicianDetail?> getTechDetail({required String? id}) async {
    final response = await apiService.getApi(
      "/api/appV1/technician_details/$id",
    );

    if (response is bool) return null;
    if (kDebugMode) {
      print(response);
    }
    log.d(response);
    return TechnicianDetail.fromJson(response);
  }
}
