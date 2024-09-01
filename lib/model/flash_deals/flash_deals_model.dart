import '../../resources/exports/index.dart';

class FlashDealsModel {
  int? discountPer;
  DateTime? duration;
  List<ListViewModel>? items;

  FlashDealsModel({this.discountPer, this.duration, this.items});

  factory FlashDealsModel.fromJson(Map<String, dynamic> json) {
    List<DateTime?> parseDuration(String duration) {
      try {
        var dates = duration.split(' - ');
        if (dates.length == 2) {
          DateTime? start = DateFormat('yyyy/MM/dd HH:mm:ss').parse(dates[0]);
          DateTime? end = DateFormat('yyyy/MM/dd HH:mm:ss').parse(dates[1]);
          return [start, end];
        }
      } catch (e) {
        // Handle parsing error, e.g., log or throw an exception
      }
      return [null, null];
    }

    var durationList = parseDuration(json['duration'] as String);
    // ignore: unused_local_variable
    DateTime? start = durationList[0];
    DateTime? end = durationList[1];
    return FlashDealsModel(
      discountPer: json['discount'] as int?,
      // TODO :: For production we only need this part -> " DateTime.tryParse(json['duration']) "
      duration: end,
      // duration: json['duration'] is DateTime
      //     ? json['duration']
      //     : DateTime.tryParse(json['duration']),
      items: ListViewModel.listFromJson(json['items']),
    );
  }
}
