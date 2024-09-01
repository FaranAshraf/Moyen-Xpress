import 'package:moyen_express/model/recently_views/recently_views_model.dart';

import '../resources/exports/index.dart';

class RecentlyViewRepository {
  static BaseApiServices apiService = NetworkApiServices();

  static Future<RecentViewData?> getDailyDeals() async {
    final response = await apiService.getApi(
      Urls.RECENTLY_VIEWS,
    );
    if (response is bool) return null;
    log.e(response);
    return RecentViewData.fromJson(response);
  }
}
