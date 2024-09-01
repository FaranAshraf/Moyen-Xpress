import 'package:moyen_express/view_model/controllers/shipping_description/shipping_description_controller.dart';

import '../../../model/ship_with_moyen/ship_with_moyen_model.dart';
import '../../../repository/ship_with_moyen_repository.dart';
import '../../../resources/exports/index.dart';

class ShipmentDescriptionForm extends StatelessWidget {
  final String id;
  const ShipmentDescriptionForm({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ShippingDescriptionController(id), tag: id);
    final GetQuoteController getQuoteController = Get.put(GetQuoteController());
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
          child: Column(
        children: [
          Container(
            width: double.maxFinite,
            height: Sizes.HEIGHT_120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColor),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(Strings.SHIPPING_PRODUCTS.tr,
                        style: context.bodyLarge.copyWith(
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                            color: AppColors.white)),
                  ),
                  const SpaceH4(),
                  Obx(() => SizedBox(
                        width: double.maxFinite,
                        height: Sizes.HEIGHT_60,
                        child: Container(
                          padding:
                              const EdgeInsets.only(left: 10.0, right: 10.0),
                          margin: const EdgeInsets.only(
                              left: 10, right: 10.0, top: 10.0),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              menuMaxHeight: 300,
                              isExpanded: true,
                              iconSize: 30,
                              underline: const SizedBox(),
                              isDense: false,
                              alignment: Alignment.center,
                              dropdownColor: AppColors.white,
                              padding: const EdgeInsets.all(8),
                              value: controller.shippingProducts.value,
                              icon: const Icon(Icons.keyboard_arrow_down),
                              items: controller.shippingItems
                                  .map<DropdownMenuItem<String>>(
                                      (ShippingProducts item) {
                                return DropdownMenuItem<String>(
                                  value: item.name ?? '',
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        item.name ?? '',
                                        style: context.bodyLarge.copyWith(
                                          fontSize: 17,
                                          color:
                                              AppColors.black.withOpacity(0.7),
                                        ),
                                      ),
                                      Icon(
                                        Icons.check,
                                        color: item.name ==
                                                controller
                                                    .shippingProducts.value
                                            ? Colors.green
                                            : Colors.transparent,
                                      ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) async {
                                if (newValue != null) {
                                  controller.shippingProducts.value = newValue;
                                  ShippingProducts? selectedProduct = controller
                                      .shippingItems
                                      .firstWhereOrNull((product) =>
                                          product.name == newValue);
                                  if (selectedProduct != null) {
                                    getQuoteController.selectedProductNames
                                        .add(selectedProduct.name!);
                                    getQuoteController.selectedWeights
                                        .add(selectedProduct.weight.toString());
                                    getQuoteController.selectedLengths
                                        .add(selectedProduct.length.toString());
                                    getQuoteController.selectedWidths
                                        .add(selectedProduct.width.toString());
                                    getQuoteController.selectedHeights
                                        .add(selectedProduct.height.toString());
                                         getQuoteController.selectedQuantities
                                        .add(getQuoteController.quantity.text.toString());

                                        getQuoteController.pName.value=selectedProduct.name!;
                                        getQuoteController.pWeight.value=selectedProduct.weight.toString();
                                        getQuoteController.pLength.value=selectedProduct.length.toString();
                                        getQuoteController.pWidth.value=selectedProduct.width.toString();
                                        getQuoteController.pHeight.value=selectedProduct.height.toString();
                                  }
                                  await ShipWithMoyenRepository
                                      .getDataThroughShipping(
                                          id: selectedProduct!.id ?? 0);
                                }
                              },
                            ),
                          ),
                        ),
                      )),
                ],
              ),
            ),
          ),
          const SpaceH8(),
          fieldHeading(Strings.PRODUCT_NAME.tr, context),
          CustomTextFormField(
            readOnly: true,
            controller: getQuoteController.productName,
            isRequired: false,
            height: Sizes.HEIGHT_20,
            labelText: Strings.PRODUCT_NAME.tr,
            labelColor: AppColors.black.withOpacity(0.5),
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.error,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primaryColor,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            borderRadius: 5.0,
          ),
          fieldHeading(Strings.WEIGHT.tr, context),
          CustomTextFormField(
            readOnly: true,
            controller: getQuoteController.weight,
            isRequired: false,
            height: Sizes.HEIGHT_20,
            labelText: Strings.WEIGHT.tr,
            labelColor: AppColors.black.withOpacity(0.5),
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.error,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primaryColor,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            borderRadius: 5.0,
          ),
          fieldHeading(Strings.LENGTH.tr, context),
          CustomTextFormField(
            readOnly: true,
            controller: getQuoteController.length,
            isRequired: false,
            height: Sizes.HEIGHT_20,
            labelText: Strings.LENGTH.tr,
            labelColor: AppColors.black.withOpacity(0.5),
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.error,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primaryColor,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            borderRadius: 5.0,
          ),
          fieldHeading(Strings.WIDTH.tr, context),
          CustomTextFormField(
            readOnly: true,
            controller: getQuoteController.width,
            isRequired: false,
            height: Sizes.HEIGHT_20,
            labelText: Strings.WIDTH.tr,
            labelColor: AppColors.black.withOpacity(0.5),
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.error,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primaryColor,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            borderRadius: 5.0,
          ),
          fieldHeading(Strings.HEIGHT.tr, context),
          CustomTextFormField(
            readOnly: true,
            controller: getQuoteController.height,
            isRequired: false,
            height: Sizes.HEIGHT_20,
            labelText: Strings.HEIGHT.tr,
            labelColor: AppColors.black.withOpacity(0.5),
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.error,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primaryColor,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            borderRadius: 5.0,
          ),
          fieldHeading(Strings.QUANTITY.tr, context),
          CustomTextFormField(
            enabled: true,
            controller: getQuoteController.quantity,
            isRequired: false,
            height: Sizes.HEIGHT_20,
            labelText: Strings.QUANTITY.tr,
            labelColor: AppColors.black.withOpacity(0.5),
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.error,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primaryColor,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.emailAddress,
            borderRadius: 5.0,
          ),
        ],
      )),
    );
  }

  Align fieldHeading(String title, BuildContext context) {
    return Align(
        alignment: Alignment.topLeft,
        child: Text(title,
            style: context.bodyMedium
                .copyWith(fontSize: 16, fontWeight: FontWeight.w500)));
  }
}
