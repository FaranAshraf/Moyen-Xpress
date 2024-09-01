import 'package:moyen_express/model/product_detail/product_detail_model.dart';
import 'package:moyen_express/model/technician/technician_detail_model.dart';
import 'package:moyen_express/repository/auction_repository.dart';
import 'package:moyen_express/repository/cart_repository.dart';
import 'package:moyen_express/repository/conversation_repository.dart';
import 'package:moyen_express/view_model/helpers/global_helper/currency_conversion.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../dummy/auction_product_info_data.dart';
import '../../../dummy/product_details_data.dart';
import '../../../dummy/q_a_data.dart';
import '../../../resources/exports/index.dart';

class ProductDetailsController extends GetxController
    with GetSingleTickerProviderStateMixin {
  late RxBool isTechnicianProduct = false.obs;
  late bool isAuctionProduct;
  late int proId;
  late String jsonData;
  late TabController tabCtrl;
  late Future<String> descriptionApiData;
  late Future<String> qaApiData;
  late TextEditingController bidAmountCtrl;
  late TextEditingController startBidAmountCtrl;
  late TextEditingController incrementPerBidCtrl;
  late TextEditingController maxBidAmountCtrl;
  late TextEditingController questionController;
  late TextEditingController proNameController;
  late TextEditingController yourQuestion;
  late GlobalKey<FormState> bidFormKey;
  late GlobalKey<FormState> autoBidFormKey;
  late GlobalKey<FormState> askQuestionForm;
  RxString newValue = "".obs;

  void updateId(String id) {
    newValue.value = id;
  }

  Future<void> postQuestion() async {
    await ConversationRepository.conversationSeller(
        productId: proId.toString(),
        title: proNameController.text,
        message: yourQuestion.text);
    onDone();
  }

  onDone() {
    yourQuestion.clear();
  }

 



  AuctionProductInfoModel info = AuctionProductInfoModel();

  Future<AuctionProductInfoModel> getAuctionProductInfo() async {
    return Future.delayed(const Duration(seconds: 1), () {
      return AuctionProductInfoModel.fromJson(auctionProductInfoData);
    });
  }

  void onBidSubmit(id) async {
    if (bidFormKey.currentState?.validate() ?? false) {
      await AuctionRepository.placeBid(
          productId: id, amount: bidAmountCtrl.text);
      Get.close(1);
    }
  }

  RxInt selectedColorIndex = 0.obs; // Initially selecting the first color

  void selectColor(int index) {
    selectedColorIndex.value = index;
    log.e(index);
    update(["Colors"]);
  }

RxInt selectedVarianceOptionIndex = 0.obs; // Index of the selected option
  RxInt selectedVarianceValueIndex = 0.obs; // Index of the selected value within the option

  void selectVariance(int optionIndex, int valueIndex) {
    selectedVarianceOptionIndex.value = optionIndex;
    selectedVarianceValueIndex.value = valueIndex;
    update(["variance"]);
  }

  void onLeftBtnTap(
      BuildContext context, String image, num? minBid, String id) {
    if (isAuctionProduct) {
      showModalBottomSheet(
        isScrollControlled: true,
        // constraints: BoxConstraints(
        //   maxHeight: Get.height * 0.7,
        //   maxWidth: 600.0,
        //   minWidth: 600.0,
        // ),
        context: context,
        builder: (_) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ProductBidBottomSheet(
            image: image,
            minimumBid: minBid!,
            id: id,
          ),
        ),
      ).then((_) => bidAmountCtrl.clear());
    } else {
      Get.toNamed(Routes.CART);
    }
  }

  void onAutoBidSubmit(id) async {
    if (autoBidFormKey.currentState?.validate() ?? false) {
      Get.close(1);
      await AuctionRepository.placeAutoBid(
          productId: id,
          increasePerBid: incrementPerBidCtrl.text,
          maxBidAmount: maxBidAmountCtrl.text,
          amount: startBidAmountCtrl.text);
    }
  }

  num bidAmt = 0;
  void onRightBtnTap(BuildContext context, String image, ProductData? product,
      num? minBid, String id) {
    if (isAuctionProduct) {
      showModalBottomSheet(
        isScrollControlled: true,
        // constraints: BoxConstraints(
        //   maxHeight: Get.height * 0.7,
        //   maxWidth: 600.0,
        //   minWidth: 600.0,
        // ),
        context: context,
        builder: (_) => Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: ProductAutoBidBottomSheet(
              image: image, minimumBid: minBid!, id: id),
        ),
      ).then(
        (_) {
          startBidAmountCtrl.clear();
          incrementPerBidCtrl.clear();
          maxBidAmountCtrl.clear();
        },
      );
    } else {
      onBuyNowTap(context, product);
    }
  }

  int? selectedImageIndex;

  void toggleSelectedImage(ProductData? product, int index) {
    selectedImageIndex = index;
    update(["product_preview_image"]);
  }

  void toggleSelectedImageTech(
    TechnicianDetail? product,
  ) {
    // Update selectedImageIndex
    // selectedImageIndex = index;
    // Refresh UI
    update(["product_preview_image"]);
  }

  Future<ProductDetailsModel> getProductDetails() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return ProductDetailsModel.fromJson(productDetails);
    });
  }

  Future<ProductDetailsModel> getTechDetails() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return ProductDetailsModel.fromJson(technicianDetail);
    });
  }

  RxString productDesc = "".obs;
  // Future<String> getDescription() async {
  //   return Future.delayed(const Duration(seconds: 3), () {
  //     return descriptionData['description'];
  //   });
  // }

  Future<String> getQAData() async {
    return Future.delayed(const Duration(seconds: 3), () {
      return qaData['qaData'];
    });
  }

  Future<ProductData?> getProductInfo(int proId) async {
    // Make API call to get product details
    ProductData? product = await HomeRepository.getProductDetail(proId);
    proNameController.text = product?.product.name.toString() ?? '';
    return product;
  }

  void onBuyNowTap(
    BuildContext context,
    ProductData? product,
  ) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      constraints: BoxConstraints(
        maxHeight: Get.height * 0.7,
        maxWidth: 600.0,
        minWidth: 600.0,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(14.0),
          topRight: Radius.circular(14.0),
        ),
      ),
      context: context,
      builder: (_) => AddToCartContent(
        title: CartRepository.responseApi,
        product: product),
    );
  }

  var isExpanded = false.obs;
  var showReadMoreButton = false.obs;

  void toggleExpansion() {
    isExpanded.value = !isExpanded.value;
  }

  Future<void> askQuestionProduct() async {
    if (askQuestionForm.currentState?.validate() ?? false) {
      await HomeRepository.askQuestions(
          question: questionController.text, productId: proId);
      CustomSnackBar.showSnackBar(message: "Question Send Successfully!");
    }
  }

  Future<void> launchURL(String url) async {
    // ignore: deprecated_member_use
    if (await canLaunch(url)) {
      // ignore: deprecated_member_use
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  void onInit() {
    proId = Get.arguments != null ? Get.arguments['proId'] : 0;
    isAuctionProduct =
        Get.arguments != null ? Get.arguments['isAuctionProduct'] : false;
    tabCtrl = TabController(length: isAuctionProduct ? 3 : 2, vsync: this);
    // descriptionApiData = getDescription();
    qaApiData = getQAData();
    autoBidFormKey = GlobalKey<FormState>();
    bidFormKey = GlobalKey<FormState>();
    askQuestionForm = GlobalKey<FormState>();
    bidAmountCtrl = TextEditingController();
    startBidAmountCtrl = TextEditingController(text: bidAmt.toString());
    incrementPerBidCtrl = TextEditingController();
    maxBidAmountCtrl = TextEditingController();
    questionController = TextEditingController();
    proNameController = TextEditingController();
    yourQuestion = TextEditingController();
    // getProductInfo();

    super.onInit();
  }

  @override
  void dispose() {
    proNameController.dispose();
    yourQuestion.dispose();
    super.dispose();
  }
}
