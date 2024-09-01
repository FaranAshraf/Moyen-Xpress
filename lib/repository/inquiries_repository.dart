import '../model/inquiries/inquiries_detail_model.dart';
import '../model/inquiries/inquiries_model.dart';
import '../model/inquiries/inquiries_notes_model.dart';
import '../resources/exports/index.dart';

class InquiriesRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static Future<List<Inquiries>?> getInquiries() async {
    final response = await apiService.getApi(Urls.INQUIRIES);
    if (response is List) {
      if (kDebugMode) {
        print(response);
      }
      log.e("Response: $response");
      return response.map((item) => Inquiries.fromJson(item)).toList();
    } else {
      return null;
    }
  }

  static Future<InquiryDetailModel?> getInquiriesDetail({required id}) async {
    final response = await apiService
        .getApi(Urls.INQUIRY_DETAIL, quaryParameters: {"id": id});

    log.e("Response Detail: $response");
    return InquiryDetailModel.fromJson(response);
  }

  static Future<InquiryNotesModel?> getInquiriesNotes({required id}) async {
    final response = await apiService.getApi('/api/appV1/getInquiryNotes/$id');

    log.e("Response Detail: $response");
    return InquiryNotesModel.fromJson(response);
  }

  static Future<void> postInquiryNotes(
      {required note, required productId, required receiveId}) async {
    final response = await apiService.postUpdatedAPI(Urls.POST_NOTE, {
      "note": note,
      "product_inquiry_id": productId,
      "receiver_id": receiveId,
    });
    log.w(response);
    if (response is bool) return;
    CustomSnackBar.showSnackBar(
        message: response, snackBarStyle: SnackBarStyle.success);
  }

  static Future<void> sendInquiries(
      {required note,
      required productId,
      required productQty,
      required size,
      required color,
      required deliveryAddress}) async {
    final response = await apiService.postUpdatedAPI(Urls.SEND_INQUIRY, {
      "product_id": productId,
      "product_qty": productQty,
      "user_note": note,
      "size": size,
      "colour": color,
      "delivery_address": deliveryAddress,
    });
    log.w(response);
    if (response is bool) return;
    CustomSnackBar.showSnackBar(
        message: response, snackBarStyle: SnackBarStyle.success);
  }
}
