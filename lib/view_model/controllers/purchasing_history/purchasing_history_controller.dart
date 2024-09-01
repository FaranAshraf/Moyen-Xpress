import 'package:moyen_express/dummy/shipping_detail_data.dart';
import 'package:moyen_express/model/shipping_detail/shipping_detail_model.dart';
import 'package:moyen_express/repository/purchase_repository.dart';
import 'package:moyen_express/resources/exports/index.dart';

class PurchasingHistoryController extends GetxController{
   RxBool isPurchaseHistory = false.obs;
  Future<ShippingDetailModel> getShippingDetail() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return ShippingDetailModel.fromJson(shippingDetail);
    });
  }

  Future<void> getDetail()async{
    await PurchaseRepository.getPurchaseHistory();
  }
  @override
  void onInit() {
    
    getShippingDetail();
    super.onInit();
  }
}