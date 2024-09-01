import 'package:moyen_express/model/view_cart/view_cart_model.dart';
import 'package:moyen_express/repository/cart_repository.dart';

import '../../../dummy/cart_data.dart';
import '../../../model/test_model/test_model.dart';
import '../../../resources/exports/index.dart';

class CartController extends GetxController {
  List<int?> sellerIds = [];
  List<String?> defaultIds = [];
  List<String?> selectedIds = [];
  List<int?> defaultShipIds = [];

  var selectedPickupAddresses = <String, int?>{}.obs;
  final LocationsController locationsController =
      Get.put(LocationsController());
  var selectedShipMoyenByShop = <String, int?>{}.obs;
  var selectedExpressByShop = <String, int?>{}.obs;
  late int addressId;
  RxMap<String, int> selectedIndexes = <String, int>{}.obs;
  late int addressSecondId;
  List<CartModel> cartItems = [];
  RxInt selectedOrderId = 0.obs;
  RxInt selectedId = 0.obs;
  RxInt selectedIndex = 0.obs;
  List<int> deliveryTypes = [0, 1, 2];
  LocationsDataModel? defaultLocation;
  RxList<CartItem> cartProducts = <CartItem>[].obs;
  List<DeliveryContent> apiData = [];
  Map<String, int?> selectedDeliveryTypes = {};
  List<Map<String, String>> selectedDeliveryTypesList = [];

  void toggleSelectedIndex(int index) {
    selectedIndex.value = index;
    log.e(index);
    update(["update_selected_index"]);
  }

  void toggleStoreSelection(CartModel item) {
    item.isSelected = !(item.isSelected ?? false);
    update(["update_store_selection"]);
  }

  void getDefaultLocation() {
    if (AuthManager.instance.user?.defaultLocationId != null) {
      defaultLocation = LocationsDataModel(
        id: AuthManager.instance.user?.defaultLocationId,
        completeAddress: AuthManager.instance.user?.address,
        cityName: AuthManager.instance.user?.city,
        countryName: AuthManager.instance.user?.country,
        postalCode: AuthManager.instance.user?.zipCode != null
            ? int.tryParse(AuthManager.instance.user?.zipCode ?? '')
            : null,
        phoneNo: AuthManager.instance.user?.phoneNo != null
            ? int.tryParse(AuthManager.instance.user?.phoneNo ?? '')
            : null,
        stateName: AuthManager.instance.user?.state,
      );
      log.f(defaultLocation?.toJson());
    }
  }

  Future<List<CartModel>> getCartData() async {
    return Future.delayed(const Duration(milliseconds: 3), () {
      return CartModel.listFromJson(cartData);
    });
  }

  void initializePickupAddresses(
      Map<String, DeliveryContent> deliveryContents) {
    final Set<String> newPickupIds = {};

    for (var entry in deliveryContents.entries) {
      String shopName = entry.key;
      var products = entry.value.products;

      if (products != null && products.isNotEmpty) {
        for (var product in products) {
          var pickupAddresses = product.deliveryMethods?.pickupAddress;

          if (pickupAddresses != null && pickupAddresses.isNotEmpty) {
            log.e(
                "Pickup addresses for $shopName: ${pickupAddresses.map((a) => '${a.type}_${a.id}').toList()}");

            var freePickupAddresses = pickupAddresses
                .where((address) =>
                    address.type?.trim().toLowerCase() == 'free_pickup')
                .toList();

            log.e(
                "Free pickup addresses for $shopName: ${freePickupAddresses.map((a) => '${a.type}_${a.id}').toList()}");

            if (freePickupAddresses.isNotEmpty) {
              selectedPickupAddresses[shopName] = freePickupAddresses.first.id;
              String concatenatedId =
                  "${freePickupAddresses.first.type}_${freePickupAddresses.first.id}";
              log.f('testy ${selectedPickupAddresses[shopName]}');
              if (!newPickupIds.contains(concatenatedId)) {
                newPickupIds.add(concatenatedId);
                log.e("Added Pickup ID to newPickupIds: $concatenatedId");
              }
            }
          } else {
            log.e("No pickup addresses found for $shopName");
          }
        }
      }
    }

    defaultIds.addAll(newPickupIds);
    log.e("Updated Default IDs with pickups: $defaultIds");
    update(["_index"]);
  }

  void toggleSelectedPickupAddress(String shopName, int addressId) {
    if (selectedPickupAddresses[shopName] == addressId) {
      selectedPickupAddresses[shopName] = null;
    } else {
      selectedPickupAddresses[shopName] = addressId;
      log.e(selectedPickupAddresses[shopName]);
    }
    update(["_index"]);
  }

  void initializeShipWithMoyen(List<DeliveryContent> deliveryContents) {
    final Map<String, int?> shipMoyenByShop = {};
    final Set<int?> sellersWithShipWithMoyen = {};
    final Set<int?> allSellers = {};
    final Set<String> processedShopNames = {};

    for (var deliveryContent in deliveryContents) {
      for (var product in deliveryContent.products ?? []) {
        final shopName = product.shopName;
        final sellerId = product.sellerId;
        final shipWithMoyenId = product.deliveryMethods?.shipWithMoyen?.id;

        if (shipWithMoyenId != null && sellerId != null) {
          allSellers.add(sellerId);
          if (shopName != null) {
            if (!processedShopNames.contains(shopName)) {
              processedShopNames.add(shopName);
            }
            if (!shipMoyenByShop.containsKey(shopName)) {
              shipMoyenByShop[shopName] = shipWithMoyenId;
            }
            sellersWithShipWithMoyen.add(sellerId);
          }
        }
      }
    }

    log.w("Sellers with ship_with_moyen: $sellersWithShipWithMoyen");
    log.d("All sellers: ${allSellers.toList()}");
    log.i("Ship moyen by shop: $shipMoyenByShop");

    final List<String> mergedIds = [];

    for (var entry in shipMoyenByShop.entries) {
      final shopName = entry.key;
      final defaultId = entry.value;
      if (defaultId != null) {
        String concatenatedId = "ship_with_moyen";
        if (!defaultIds.contains(concatenatedId)) {
          mergedIds.add(concatenatedId);
          selectedShipMoyenByShop[shopName] = defaultId;
        }
      }
    }

    log.i("Merged IDs before adding to defaultIds: $mergedIds");

    defaultIds.addAll(mergedIds);

    log.e("Updated Default IDs with ship moyen: $sellerIds");
    log.e("Updated Default IDs with ship moyen: $defaultIds");
  }

  void toggleShipMoyen(String shopName, int id) {
    if (selectedShipMoyenByShop[shopName] == id) {
      selectedShipMoyenByShop[shopName] = null;
    } else {
      selectedShipMoyenByShop[shopName] = id;
    }
    log.e(
        "Selected Ship With Moyen for $shopName: ${selectedShipMoyenByShop[shopName]}");
    update(['update_index']);
  }

  void initializeExpressDelivery(List<DeliveryContent> deliveryContents) {
    final Map<String, int?> shipMoyenByShop = {};
    final Set<int?> sellersWithExpressDelivery = {};
    final Set<int?> allSellers = {};
    final Set<String> processedShopNames = {};

    for (var deliveryContent in deliveryContents) {
      for (var product in deliveryContent.products ?? []) {
        final shopName = product.shopName;
        final sellerId = product.sellerId;
        final shipWithMoyenId = product.deliveryMethods?.expressDelivery?.id;

        if (shipWithMoyenId != null && sellerId != null) {
          allSellers.add(sellerId);
          if (shopName != null) {
            if (!processedShopNames.contains(shopName)) {
              processedShopNames.add(shopName);
            }
            if (!shipMoyenByShop.containsKey(shopName)) {
              shipMoyenByShop[shopName] = shipWithMoyenId;
            }
            sellersWithExpressDelivery.add(sellerId);
          }
        }
      }
    }

    log.w("Sellers with Express Delivery: $sellersWithExpressDelivery");
    log.d("All sellers: ${allSellers.toList()}");
    log.i("express Delivery by shop: $shipMoyenByShop");

    final List<String> mergedIds = [];

    for (var entry in shipMoyenByShop.entries) {
      final shopName = entry.key;
      final defaultId = entry.value;
      if (defaultId != null) {
        String concatenatedId = "express_delivery";
        if (!selectedIds.contains(concatenatedId)) {
          mergedIds.add(concatenatedId);
          selectedShipMoyenByShop[shopName] = defaultId;
        }
      }
    }

    log.i("Merged IDs before adding to defaultIds: $mergedIds");

    defaultIds.addAll(mergedIds);

    log.e("Updated Default IDs with Express Delivery: $sellerIds");
    log.e("Updated Default IDs with Express Delivery: $defaultIds");
  }

  void toggleExpressDelivery(String shopName, int id) {
    if (selectedExpressByShop[shopName] == id) {
      selectedExpressByShop[shopName] = null;
    } else {
      selectedExpressByShop[shopName] = id;
    }
    log.e(
        "Selected Express Delivery for $shopName: ${selectedExpressByShop[shopName]}");
    update(['update_']);
  }

  void addQty(CartItem data) {
    data.quantity = (data.quantity ?? 0) + 1;
    data = data.copyWith(price: (data.price ?? 0.0) * (data.quantity ?? 1));
    update(["qty_container", "item_price"]);
  }

  void subtractQty(CartItem data) {
    if ((data.quantity ?? 0) > 1) {
      data.quantity = (data.quantity ?? 0) - 1;
      data = data.copyWith(price: (data.price ?? 0.0) * (data.quantity ?? 1));
      update(["qty_container", "item_price"]);
    }
  }

  void toggleDeliveryType(int index, int subIndex) {
    cartItems[index] = cartItems[index].copyWith(
      selectedDeliveryType: subIndex,
    );
    update(["cart_delivery_option"]);
  }

  Future<void> getCartItem() async {
    await CartRepository.getCartProducts();
  }

  Future<void> removeCartItem(int? id) async {
    await CartRepository.deleteCartProduct(productId: id);
    cartItems.removeWhere((item) => item.id == id);
    update();
  }

  Future<void> updateAndDeleteProduct(int? id) async {
    await CartRepository.updateAndDeleteCart(productId: id);
    cartItems.removeWhere((item) => item.id == id);
    update(["Remove"]);
  }

  Future<void> getPayment() async {
    apiData = await CartRepository.deliveryInfoCart(
        addressId: selectedId.value == 0
            ? locationsController.selectedLocationId
            : selectedId.value);

    // Extract seller IDs
    sellerIds.clear(); // Clear previous IDs
    for (var content in apiData) {
      for (var product in content.products ?? []) {
        if (product.sellerId != null) {
          sellerIds.add(product.sellerId!);
        }
      }
    }

    removeDuplicatesFromSellerIds();

    log.e("Seller IDs: $sellerIds"); // Log seller IDs

    // Initialize the pickup addresses and ship with moyen after fetching the data
    initializePickupAddresses(
        apiData.asMap().map((i, content) => MapEntry(i.toString(), content)));
    initializeShipWithMoyen(apiData);
    // initializeExpressDelivery(apiData);
  }

  Future<List<CartModel>> getPostData() async {
    return Future.delayed(const Duration(milliseconds: 3), () {
      return CartModel.listFromJson(cartData);
    });
  }

  Map<int, int>? initializeWithMoyen(List<DeliveryContent> deliveryContents) {
    final Map<int, int> sellerShipWithMoyen = {}; // {sellerId: shipWithMoyenId}

    for (var deliveryContent in deliveryContents) {
      for (var product in deliveryContent.products ?? []) {
        final sellerId = product.sellerId;
        final shipWithMoyenId = product.deliveryMethods?.shipWithMoyen
            ?.id; // Access shipWithMoyen through deliveryMethods

        if (sellerId != null && shipWithMoyenId != null) {
          sellerShipWithMoyen[sellerId] = shipWithMoyenId;
        }
      }
    }

    log.d('Seller Ship With Moyen: $sellerShipWithMoyen');
    return sellerShipWithMoyen;
  }

  Map<int, int>? initializeExpress(List<DeliveryContent> deliveryContents) {
    final Map<int, int> sellerExpressDelivery =
        {}; // {sellerId: shipWithMoyenId}

    for (var deliveryContent in deliveryContents) {
      for (var product in deliveryContent.products ?? []) {
        final sellerId = product.sellerId;
        final shipWithMoyenId = product.deliveryMethods?.expressDelivery
            ?.id; // Access shipWithMoyen through deliveryMethods

        if (sellerId != null && shipWithMoyenId != null) {
          sellerExpressDelivery[sellerId] = shipWithMoyenId;
        }
      }
    }

    log.d('Seller Ship With Moyen: $sellerExpressDelivery');
    return sellerExpressDelivery;
  }

  void removeDuplicatesFromSellerIds() {
    sellerIds = sellerIds.toSet().toList();
  }

  void selectDeliveryType(
      String shopName, int deliveryTypeId, int id, String type) {
    // Determine the type of delivery and create a concatenated ID
    String concatenatedValue =
        type == 'free_pickup' ? '${type}_$deliveryTypeId' : type;

    // Deselect the currently selected delivery type for this shop
    if (selectedDeliveryTypes.containsKey(shopName)) {
      String previousType = selectedDeliveryTypes[shopName].toString();
      if (previousType != concatenatedValue) {
        // Remove the previous delivery type from default IDs
        defaultIds.removeWhere((id) => id == previousType);
      }
    }

    // Add the new delivery type to selected delivery types
    selectedDeliveryTypes[shopName] = deliveryTypeId;
    defaultIds.add(concatenatedValue);

    // Update selected delivery types list
    bool exists = false;
    for (var entry in selectedDeliveryTypesList) {
      if (entry.containsKey(shopName)) {
        entry[shopName] = concatenatedValue;
        exists = true;
        break;
      }
    }

    if (!exists) {
      selectedDeliveryTypesList.add({shopName: concatenatedValue});
    }

    // Log and update UI
    logSelectedDeliveryTypes();
    update(["delivery_type_selection"]);
  }

  void updateSelectedDeliveryTypes() {
    // Clear the previous selected delivery types
    selectedDeliveryTypes.clear();

    // Iterate through the selected delivery types list and update the map
    for (var entry in selectedDeliveryTypesList) {
      entry.forEach((shopName, deliveryType) {
        selectedDeliveryTypes[shopName] = deliveryType.toInt();
      });
    }

    // Log after update
    logSelectedDeliveryTypes();
  }

  void logSelectedDeliveryTypes() {
    log.f("Selected Delivery Types: $selectedDeliveryTypesList");
    final List<String> cleanedIds = [];

    for (var select in selectedDeliveryTypesList) {
      // Extract values from the map
      for (var value in select.values) {
        // Remove parentheses and any other unwanted characters
        final cleanedValue = value.replaceAll('(', '').replaceAll(')', '');
        cleanedIds.add(cleanedValue);
      }
    }

    // Log the cleaned IDs
    log.d("Cleaned Selected IDs: $cleanedIds");
    selectedIds = cleanedIds;
  }

  check() {
    for (var item in selectedDeliveryTypesList) {
      item.forEach((key, value) {
        log.f("shipping_type_$key : $value");
        log.d("shipping_config_$key : $value");
      });
    }
  }

  final Map<int, int?> expressDeliveries = {};
  final Map<int, int?> shipWithMoyens = {};
  void initializeDeliveryMethods(List<DeliveryContent> deliveryContents) {
    for (var deliveryContent in deliveryContents) {
      for (var product in deliveryContent.products ?? []) {
        final sellerId = product.seller_id;
        final expressDelivery = product.deliveryMethods?.expressDelivery;
        final shipWithMoyen = product.deliveryMethods?.shipWithMoyen;

        if (expressDelivery != null && sellerId != null) {
          expressDeliveries[sellerId] = expressDelivery.id;
        }
        if (shipWithMoyen != null && sellerId != null) {
          shipWithMoyens[sellerId] = shipWithMoyen.id;
        }
      }
    }

    // Clear previously set default IDs that are related to these delivery methods
    defaultIds.removeWhere((id) =>
        id!.startsWith('express_delivery') || id.startsWith('ship_with_moyen'));

    log.d('Express Deliveries: $expressDeliveries');
    log.d('Ship With Moyen: $shipWithMoyens');

    // Add the currently available delivery methods to default IDs
    expressDeliveries.forEach((shopName, id) {
      defaultIds.add('express_delivery_$id');
    });

    shipWithMoyens.forEach((shopName, id) {
      defaultIds.add('ship_with_moyen_$id');
    });

    // Store or update your state with these maps as needed
  }

  void selectDeliveryMethod(String shopName, int deliveryTypeId, String type) {
    final deliveryInfo =
        type == 'express_delivery' ? expressDeliveries : shipWithMoyens;

    // Determine which map to use based on type
    String concatenatedValue =
        type == 'express_delivery' ? '${type}_$deliveryTypeId' : type;

    if (deliveryInfo.isNotEmpty) {
      // Remove any previously set delivery methods for this type
      defaultIds.removeWhere((id) => id!.startsWith(type));
      selectedDeliveryTypes[shopName] = deliveryTypeId;
      defaultIds.add(concatenatedValue);
    } else {
      // If no delivery info, use defaults
      selectedIds.add(concatenatedValue);
    }

    // Log and update UI
    logSelectedDeliveryTypes();
    update(["delivery_type_selection"]);
  }

  @override
  void onInit() {
    addressId = Get.arguments != null ? Get.arguments['addressId'] : 0;
    getPayment();
    check();
    updateSelectedDeliveryTypes(); // Ensure delivery types are updated on init
    super.onInit();
  }
}
