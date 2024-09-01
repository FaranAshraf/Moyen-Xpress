import 'package:moyen_express/dummy/all_products_data.dart';
import 'package:moyen_express/resources/exports/index.dart';

class StoreHomeController extends GetxController {
  RxBool onDummyData = false.obs;
  String? storeImg = '';
  String? storeTitle;

  RxBool isPressed0 = false.obs;
  void toggleWishButton() {
    isPressed0.value = !isPressed0.value;
    Get.toNamed(Routes.CART);
  }

  RxBool isPressed1 = false.obs;
  void toggleWishButton1() {
    isPressed1.value = !isPressed1.value;
    Get.toNamed(Routes.CART);
  }

  RxSet<int> favorites = <int>{}.obs;

  // Method to add an item to favorites
  void addToFavorites(int itemId) {
    favorites.add(itemId);
  }

  // Method to remove an item from favorites
  void removeFromFavorites(int itemId) {
    favorites.remove(itemId);
  }

  // Method to check if an item is in favorites
  bool isInFavorites(int itemId) {
    return favorites.contains(itemId);
  }

  // Method to get all favorite items
  Set<int> getFavorites() {
    return favorites;
  }

  Map<String, dynamic> getItemById(int itemId) {
    // Assuming allProductsData is your list of products
    for (var item in allProductsData) {
      if (item['id'] == itemId) {
        return item;
      }
    }
    return {}; // Return an empty map if item not found
  }

  RxMap<int, bool> itemPressedState = <int, bool>{}.obs;

  // Method to toggle the pressed state of an item
  void toggleItemPressedState(int itemId) {
    if (itemPressedState.containsKey(itemId)) {
      itemPressedState[itemId] = !(itemPressedState[itemId] ?? false);
    } else {
      itemPressedState[itemId] = true;
    }
  }

  // Method to get pressed state of an item
  bool getItemPressedState(int itemId) {
    return itemPressedState[itemId] ?? false;
  }


}
