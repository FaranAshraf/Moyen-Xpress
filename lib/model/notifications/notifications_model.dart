import 'package:intl/intl.dart'; // Assuming this is used for date formatting

enum NotificationType {
  order(id: 0, value: "OrderNotification"),
  auction(id: 1, value: "AuctionNotification"),
  refundRequestStatus(id: 2, value: "RefundRequestStatusNotification"),
  shippingQuote(id: 3, value: "ShippingQuoteNotification"),
  orderShipQuoteReply(id: 4, value: "OrderShipQuoteReplyNotification"),
  messageNotification(id: 5, value: "MessageNotification"),
  customNotification(id: 6, value: "CustomNotification"),
  inquiryReplyNotification(id: 7, value: "InquiryReplyNotification"),
  inquiryNoteNotification(id: 8, value: "InquiryNoteNotification");

  final int id;
  final String value;

  const NotificationType({required this.id, required this.value});

  String idToString(int id) {
    NotificationType data = NotificationType.values.firstWhere(
      (element) => element.id == id,
      orElse: () => NotificationType.order,
    );

    return data.value;
  }

  int stringToId(String value) {
    NotificationType data = NotificationType.values.firstWhere(
      (element) => element.value == value,
      orElse: () => NotificationType.order,
    );

    return data.id;
  }
}

class NotificationsModel {
  int? id;
  int? type;
  String? message;
  String? dateTime;
  int? orderId;

  NotificationsModel({
    this.id,
    this.type,
    this.message,
    this.dateTime,
    this.orderId,
  });

  static List<NotificationsModel> listFromJson(List jsonList) {
    return jsonList.map((e) => NotificationsModel.fromJson(e)).toList();
  }

  static List<Map<String, dynamic>> listToJson(
      List<NotificationsModel> jsonList) {
    return jsonList.map((e) => e.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'type': type,
      'message': message,
      'dateTime': dateTime,
      'orderId': orderId,
    };
  }

  factory NotificationsModel.fromJson(Map<String, dynamic> map) {
    return NotificationsModel(
      id: map['id'] as int?,
      type: NotificationType.values
          .firstWhere(
            (element) => element.value == map['type'],
            orElse: () => NotificationType.order,
          )
          .id,
      message: map['message'] as String?,
      dateTime: map['created_at'],
      orderId: map['order_id'] as int?,
    );
  }

  // ignore: unused_element
  static DateTime? _parseDateTime(String? dateStr) {
    if (dateStr == null) return null;
    try {
      return DateFormat("yyyy-MM-ddTHH:mm:ss").parse(dateStr);
    } catch (e) {
      return null;
    }
  }
}
