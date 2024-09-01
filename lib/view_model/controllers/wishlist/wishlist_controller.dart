
import 'package:moyen_express/model/wishlist/wishlist_model.dart';
import 'package:moyen_express/repository/wishlist_repository.dart';

import '../../../resources/exports/index.dart';

class WishListController extends GetxController{

Future<void> wishListItem()async{
  await WishlistRepository.getWishListProduct();
}
 List<CartModel> cartItems = [];
RxList<WishItemProduct> cartProducts = <WishItemProduct>[].obs;
  Future<void> removeCartItem(int? id) async {
    await WishlistRepository.deleteWishlistProduct(productId: id);
    cartItems.removeWhere((item) => item.id == id);
    update(["delete"]);
  }
 

  // Future<void> getTechDetail() async {
  //   await TechnicianRepository.getTechDetail();
  // }
@override
  void onInit() {
    // getTechDetail();
    wishListItem();
    super.onInit();
  }
}