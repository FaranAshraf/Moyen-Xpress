import 'package:moyen_express/resources/exports/index.dart';
import '../../model/product_detail/product_detail_model.dart';
import '../../view_model/controllers/send_inquiry/send_inquiry_controller.dart';

class SendInquiry extends GetView<SendInquiryController> {
  const SendInquiry({super.key});

  @override
  Widget build(BuildContext context) {
    final SendInquiryController controller = Get.put(SendInquiryController());
    final LocationsController locationController =
        Get.put(LocationsController());

    return Scaffold(
      appBar: CustomAppBar(title: Strings.SEND_INQUIRY.tr),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextFormField(
                      readOnly: true,
                      controller: controller.product,
                      isRequired: true,
                      borderRadius: 7.0,
                      height: Sizes.HEIGHT_16,
                      labelText: Strings.PRODUCT_NAME.tr,
                      labelColor: AppColors.black,
                      prefixIconColor: AppColors.black,
                      textColor: AppColors.black,
                      cursorColor: AppColors.black,
                      errorColor: AppColors.error,
                      enableBorderColor: AppColors.black,
                      focusBorderColor: AppColors.primaryColor,
                      textInputAction: TextInputAction.next,
                    ),
                    const SpaceH4(),
                    CustomTextFormField(
                      controller: controller.quantity,
                      isRequired: true,
                      borderRadius: 7.0,
                      height: Sizes.HEIGHT_16,
                      labelText: Strings.QUANTITY.tr,
                      labelColor: AppColors.black,
                      prefixIconColor: AppColors.black,
                      textColor: AppColors.black,
                      cursorColor: AppColors.black,
                      errorColor: AppColors.error,
                      enableBorderColor: AppColors.black,
                      focusBorderColor: AppColors.primaryColor,
                      textInputAction: TextInputAction.next,
                    ),
                    const SpaceH4(),
                    CustomTextFormField(
                      controller: controller.deliveryAddress,
                      isRequired: true,
                      borderRadius: 7.0,
                      height: Sizes.HEIGHT_16,
                      labelText: Strings.DELIVERY_ADDRESS.tr,
                      labelColor: AppColors.black,
                      prefixIconColor: AppColors.black,
                      textColor: AppColors.black,
                      cursorColor: AppColors.black,
                      errorColor: AppColors.error,
                      enableBorderColor: AppColors.black,
                      focusBorderColor: AppColors.primaryColor,
                      textInputAction: TextInputAction.next,
                    ),
                    const SpaceH4(),
                    CustomTextFormField(
                      controller: controller.note,
                      isRequired: true,
                      borderRadius: 7.0,
                      maxLines: 3,
                      height: Sizes.HEIGHT_16,
                      labelText: Strings.NOTE.tr,
                      labelColor: AppColors.black,
                      prefixIconColor: AppColors.black,
                      textColor: AppColors.black,
                      cursorColor: AppColors.black,
                      errorColor: AppColors.error,
                      enableBorderColor: AppColors.black,
                      focusBorderColor: AppColors.primaryColor,
                      textInputAction: TextInputAction.next,
                    ),
                    CustomFutureBuilder<ProductData?>(
                      customLoader: const DropDownShimmer(),
                      future: controller.getProductInfo(controller.id!),
                      hasDataBuilder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const DropDownShimmer();
                        } else if (snapshot.hasError) {
                          return Center(
                              child: Text('Error: ${snapshot.error}'));
                        } else if (snapshot.data == null ||
                            snapshot.data!.product.choiceOptions == null ||
                            snapshot.data!.product.choiceOptions!.isEmpty ||
                            snapshot.data!.product.choiceOptions!
                                .any((option) => option.values.isEmpty) ||
                            snapshot.data!.product.colorsName == null ||
                            snapshot.data!.product.colorsName!.isEmpty) {
                          return const Text("");
                        } else if (snapshot.hasData) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SpaceH4(),
                              Container(
                                padding: const EdgeInsets.only(
                                    left: 10.0, right: 10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(7.0),
                                  border: Border.all(
                                      color: AppColors.black, width: 1),
                                ),
                                height: 50,
                                child: _buildDropdownButton(
                                    snapshot.data!.product.choiceOptions!,
                                    locationController),
                              ),
                              const SpaceH8(),
                              _buildColorDropdown(
                                  snapshot.data!, locationController),
                            ],
                          );
                        } else {
                          return const Center(child: Text('No data available'));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            CustomButton.solid(
              margin: const EdgeInsets.only(bottom: 20.0),
              backgroundColor: AppColors.primaryColor,
              textColor: AppColors.white,
              text: Strings.SEND.tr,
              radius: Sizes.RADIUS_6,
              onTapAsync: () => controller.postInquiries(),
              constraints: const BoxConstraints(minHeight: 55),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownButton(List<ChoiceOption> choiceOptions,
      LocationsController locationController) {
    String selectedValue = "Select a size";

    // Create a set to store unique values
    Set<String> uniqueValues = {"Select a size"};

    // Add unique values from choiceOptions to the set
    for (var option in choiceOptions) {
      uniqueValues.addAll(option.values);
    }

    return StatefulBuilder(
      builder: (context, setState) {
        return DropdownButton<String>(
          menuMaxHeight: 300,
          isExpanded: true,
          iconSize: 30,
          underline: const SizedBox(),
          isDense: false,
          alignment: Alignment.center,
          dropdownColor: AppColors.white,
          value: selectedValue,
          hint: const Text("Select a size"),
          items: uniqueValues.map((value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                selectedValue = value;
                controller.size = selectedValue;
              });
              if (value != "Select a size") {
                final selectedOption = choiceOptions.firstWhere(
                  (option) => option.values.contains(value),
                );
                locationController.attributeId.value =
                    selectedOption.attributeId;
                locationController.sizeValue.value = value;
              }
            }
          },
        );
      },
    );
  }

  Widget _buildColorDropdown(
      ProductData colors, LocationsController locationController) {
    String selectedColor = "Select a color";

    return StatefulBuilder(
      builder: (context, setState) {
        return Container(
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(7.0),
            border: Border.all(color: AppColors.black, width: 1),
          ),
          height: 50,
          child: DropdownButton<String>(
            menuMaxHeight: 300,
            isExpanded: true,
            iconSize: 30,
            underline: const SizedBox(),
            isDense: false,
            alignment: Alignment.center,
            dropdownColor: AppColors.white,
            value: selectedColor,
            hint: const Text("Select a color"),
            items: [
              const DropdownMenuItem<String>(
                value: "Select a color",
                child: Text("Select a color"),
              ),
              ...colors.product.colorsName!.map((color) {
                return DropdownMenuItem<String>(
                  value: color,
                  child: Text(
                    color.toString(),
                  ),
                );
              }).toList()
            ],
            onChanged: (value) {
              if (value != null) {
                setState(() {
                  selectedColor = value;
                  controller.color = selectedColor;
                });
                if (value != "Select a color") {
                  locationController.colorValue.value = value;
                }
              }
            },
          ),
        );
      },
    );
  }
}
