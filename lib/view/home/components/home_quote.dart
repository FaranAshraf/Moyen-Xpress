import '../../../resources/exports/index.dart';
import '../../../view_model/controllers/track_ship/track_shipment_controller.dart';

class HomeQuote extends StatelessWidget {
  const HomeQuote({super.key});

  @override
  Widget build(BuildContext context) {
    final TrackShipmentController controller = Get.put(TrackShipmentController());
    // ignore: no_leading_underscores_for_local_identifiers
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    RxBool isError = false.obs; // Flag to check for errors

    return Column(
      children: [
        const SpaceH8(),
        Container(
          height: 250.0,
          width: double.maxFinite,
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(Assets.QUOTE), 
              fit: BoxFit.fill
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(left: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  Strings.SHIP_WITH_MOYEN.tr,
                  style: context.bodyLarge.copyWith(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primaryColor,
                  ),
                ),
                Text(
                  Strings.QUOTE_HOME.tr,
                  maxLines: 2,
                  style: context.bodyLarge.copyWith(
                    fontSize: 22,
                    height: 1.3,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
                const SpaceH4(),
                SizedBox(
                  width: 150.0,
                  child: CustomButton.solid(
                    backgroundColor: AppColors.primaryColor,
                    textColor: AppColors.white,
                    text: Strings.GET_A_QUOTE.tr,
                    fontWeight: FontWeight.w700,
                    icon: const Icon(
                      Icons.arrow_forward_sharp,
                      color: AppColors.white,
                    ),
                    iconSpacing: 2.0,
                    showIconOnRight: true,
                    onTap: () => Get.toNamed(Routes.GET_QUOTE),
                    radius: Sizes.RADIUS_6,
                    constraints: const BoxConstraints(
                      minHeight: 55, 
                      maxWidth: 150.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 10.0, right: 10.0),
          width: double.maxFinite,
          padding: const EdgeInsets.all(10.0),
          color: AppColors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const SpaceH10(),
                        ImageService.image(Assets.SUPPORT.tr, scale: 1.8),
                        Text(
                          Strings.CUSTOMER_SUPPORT,
                          style: context.bodyLarge.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const SpaceH10(),
                        ImageService.image(Assets.QUOTATION.tr, scale: 1.8),
                        Text(
                          Strings.QUICK_QUOTATION,
                          style: context.bodyLarge.copyWith(
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            color: AppColors.black,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  const SpaceH10(),
                  ImageService.image(Assets.FAST_SERVICE.tr, scale: 1.8),
                  Text(
                    Strings.FAST_SERVICE,
                    style: context.bodyLarge.copyWith(
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
              const SpaceH4(),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  Strings.TRACK_SHIPPING.tr,
                  style: context.bodyLarge.copyWith(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                height: 50.0,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      flex: 2,
                      child: Form(
                        key: _formKey,
                        child: TextFormField(
                          controller: controller.trackShipment,
                          decoration: InputDecoration(
                            hintText: Strings.ENTER_CODE,
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: AppColors.black.withOpacity(0.5),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: AppColors.black.withOpacity(0.5),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: AppColors.black.withOpacity(0.5),
                              ),
                            ),
                            errorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: AppColors.error, // Error border color
                                width: 1.0,
                              ),
                            ),
                            focusedErrorBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.zero,
                              borderSide: BorderSide(
                                color: AppColors.error, // Focused error border color
                                width: 1.0,
                              ),
                            ),
                            errorStyle: const TextStyle(height: 0), // Hide error text
                          ),
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              
                                isError.value = false;
                           
                            }
                          },
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 1,
                      child: CustomButton.solid(
                        backgroundColor: AppColors.primaryColor,
                        textColor: AppColors.white,
                        text: Strings.SEARCH.tr,
                        fontWeight: FontWeight.w700,
                        onTap: () {
                          if (controller.trackShipment.text.isEmpty) {
                        
                              isError.value = true;
                          
                            CustomSnackBar.showSnackBar(
                              message: "Please enter your tracking code",
                              snackBarStyle: SnackBarStyle.failure,
                            );
                          } else {
                           
                              isError.value = false;
                         
                            controller.fetchShippingInfo();
                            Get.toNamed(Routes.TRACK_SHIPPING);
                          }
                        },
                        radius: 0,
                        constraints: const BoxConstraints(
                          minHeight: 55, 
                          maxWidth: 150.0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
