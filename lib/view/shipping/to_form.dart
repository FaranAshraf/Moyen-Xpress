import 'package:dropdown_search/dropdown_search.dart';
import 'package:moyen_express/resources/exports/index.dart';

import '../../model/countries/city_model.dart';
import '../../model/countries/countries_model.dart';
import '../../model/countries/state_model.dart';

class ToForm extends GetView<GetQuoteController> {
  const ToForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TechnicianController technicianController =
        Get.put(TechnicianController());
    return Scaffold(
      appBar: CustomAppBar(title: Strings.GET_A_QUOTE.tr),
      body: Form(
          key: controller.name2Key,
          child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(Strings.To.tr,
                          style: context.bodyLarge.copyWith(
                              color: AppColors.primaryColor,
                              fontSize: Sizes.HEIGHT_36,
                              decorationThickness: 1.5,
                              fontWeight: FontWeight.w600)),
                    ),
                    fieldHeading(Strings.FULL_NAME.tr, context),
                    CustomTextFormField(
                      controller: controller.toFullName,
                      isRequired: true,
                      height: Sizes.HEIGHT_20,
                      labelText: Strings.FULL_NAME.tr,
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
                    fieldHeading(Strings.EMAIL.tr, context),
                    CustomTextFormField(
                      controller: controller.toEmail,
                      isRequired: true,
                      height: Sizes.HEIGHT_20,
                      labelText: Strings.EMAIL.tr,
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
                    fieldHeading(Strings.PHONE_NUMBER.tr, context),
                    CustomTextFormField(
                      controller: controller.toPhoneNumber,
                      isRequired: true,
                      height: Sizes.HEIGHT_20,
                      labelText: Strings.PHONE_NUMBER.tr,
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
                    fieldHeading(Strings.CSC.tr, context),
                    GetBuilder<TechnicianController>(
                      id: "country_dropdown",
                      builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: DropdownSearch<Country>(
                            popupProps:
                                const PopupProps.menu(fit: FlexFit.loose),
                            validator: (value) {
                              if (value?.id == null) {
                                return "Country is required".tr;
                              }
                              return null;
                            },
                            selectedItem: technicianController.country,
                            asyncItems: (String filter) =>
                                technicianController.getCountries(),
                            itemAsString: (Country country) =>
                                country.name ?? Strings.SELECT_COUNTRY.tr,
                            onChanged: (Country? data) {
                              if (technicianController.country.id != data?.id) {
                                technicianController.country =
                                    data ?? Country();
                                technicianController.update([
                                  "state_dropdown",
                                  "city_dropdown",
                                ]);
                                controller.toCountry = data!.id.toString();
                                log.e("Country: ${controller.toCountry}");
                              }
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                prefixIcon: const Icon(
                                  EneftyIcons.global_outline,
                                  color: Colors.black,
                                ),
                                errorBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      BorderSide(color: AppColors.error),
                                ),
                                labelText: Strings.COUNTRY.tr,
                                labelStyle:
                                    const TextStyle(color: Colors.black),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide: BorderSide(color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SpaceH16(),
                    GetBuilder<TechnicianController>(
                      id: "state_dropdown",
                      builder: (_) {
                        return DropdownSearch<CountryState>(
                          popupProps: const PopupProps.menu(fit: FlexFit.loose),
                          validator: (value) {
                            if (value?.id == null) {
                              return Strings.STATE_IS_REQUIRED.tr;
                            }
                            return null;
                          },
                          selectedItem: technicianController.state,
                          enabled: technicianController.country.id != null,
                          asyncItems: (String filter) => technicianController
                              .getCountryState(technicianController.country.id),
                          itemAsString: (CountryState countries) =>
                              countries.name ?? Strings.SELECT_STATE.tr,
                          onChanged: (CountryState? data) {
                            if (technicianController.state.id != data?.id) {
                              technicianController.state = data!;
                              technicianController.update(["city_dropdown"]);
                              controller.toState = data.id.toString();
                              log.e("State: ${controller.toState}");
                            }
                          },
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              prefixIcon: Icon(
                                EneftyIcons.map_outline,
                                color: technicianController.country.id != null
                                    ? AppColors.black
                                    : Colors.grey,
                              ),
                              labelText: Strings.STATE.tr,
                              labelStyle: const TextStyle(color: Colors.black),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              errorBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: AppColors.error),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    const SpaceH16(),
                    GetBuilder<TechnicianController>(
                      id: "city_dropdown",
                      builder: (_) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 7.0),
                          child: DropdownSearch<Cities>(
                            popupProps:
                                const PopupProps.menu(fit: FlexFit.loose),
                            validator: (value) {
                              if (value?.id == null) {
                                return Strings.COUNTRY_IS_REQUIRED.tr;
                              }
                              return null;
                            },
                            selectedItem: technicianController.city,
                            enabled: technicianController.state.id != null,
                            asyncItems: (String filter) => technicianController
                                .getStateCities(technicianController.state.id),
                            itemAsString: (Cities countries) =>
                                countries.name ?? Strings.SELECT_CITY.tr,
                            onChanged: (Cities? data) async {
                              controller.toCity = data!.id.toString();
                              log.e(controller.toCity);
                            },
                            dropdownDecoratorProps: DropDownDecoratorProps(
                              dropdownSearchDecoration: InputDecoration(
                                prefixIcon: Icon(
                                  EneftyIcons.buildings_outline,
                                  color: technicianController.state.id != null
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                                labelText: Strings.CITY.tr,
                                labelStyle:
                                    const TextStyle(color: AppColors.black),
                                enabledBorder: const OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5.0)),
                                  borderSide:
                                      BorderSide(color: AppColors.black),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 7),
                      child: fieldHeading(Strings.POSTAL_CODE.tr, context),
                    ),
                    CustomTextFormField(
                      controller: controller.toPostalCode,
                      isRequired: true,
                      height: Sizes.HEIGHT_20,
                      labelText: Strings.POSTAL_CODE.tr,
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
                    fieldHeading(Strings.BUSINESS_EMAIL.tr, context),
                    CustomTextFormField(
                      controller: controller.toBusinessEmail,
                      isRequired: false,
                      height: Sizes.HEIGHT_20,
                      labelText: Strings.BUSINESS_EMAIL_DESC.tr,
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
                    fieldHeading(Strings.BUSINESS_PHONE_NO.tr, context),
                    CustomTextFormField(
                      controller: controller.toBusinessPhoneNo,
                      isRequired: false,
                      height: Sizes.HEIGHT_20,
                      labelText: Strings.BUSINESS_PHONE_NO_DESC.tr,
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
                    fieldHeading(Strings.ADDRESS1.tr, context),
                    CustomTextFormField(
                      controller: controller.toAddress1,
                      maxLines: 2,
                      isRequired: true,
                      height: Sizes.HEIGHT_20,
                      labelText: "Write Here",
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
                    fieldHeading(Strings.ADDRESS2.tr, context),
                    CustomTextFormField(
                      controller: controller.toAddress2,
                      maxLines: 2,
                      isRequired: false,
                      height: Sizes.HEIGHT_20,
                      labelText: "Write Here".tr,
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
                    CustomButton.solid(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      backgroundColor: AppColors.primaryColor,
                      textColor: AppColors.white,
                      text: Strings.NEXT.tr,
                      onTap: () {
                        if (controller.name2Key.currentState?.validate() ??
                            false) {
                          Get.toNamed(Routes.SHIPMENT_DESCRIPTION);
                        }
                      },
                      radius: Sizes.RADIUS_6,
                      constraints: const BoxConstraints(minHeight: 55),
                    ),
                  ],
                ),
              ))),
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
