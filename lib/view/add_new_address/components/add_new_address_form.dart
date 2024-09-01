import 'package:moyen_express/model/countries/city_model.dart';
import 'package:moyen_express/model/countries/countries_model.dart';
import 'package:moyen_express/model/countries/state_model.dart';

import '../../../resources/exports/index.dart';

import 'package:dropdown_search/dropdown_search.dart';

class AddNewAddressForm extends GetView<LocationsController> {
  const AddNewAddressForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Form(
      key: controller.addressForm,
      child: Column(
        children: [
          GetBuilder<LocationsController>(
            id: "country_dropdown",
            builder: (_) {
              return DropdownSearch<Country>(
                popupProps: const PopupProps.menu(fit: FlexFit.loose),
                validator: (value) {
                  if (value?.id == null) {
                    return "Country is required".tr;
                  }
                  return null;
                },
                selectedItem: controller.country,
                asyncItems: (String filter) => controller.getCountries(),
                itemAsString: (Country country) =>
                    country.name ?? Strings.SELECT_COUNTRY.tr,
                onChanged: (Country? data) {
                  if (controller.country.id != data?.id) {
                    controller.country = data ?? Country();
                    controller.update([
                      "state_dropdown",
                      "city_dropdown",
                    ]);
                    controller.countryId = data!.id!;
                    log.e(controller.country.id);
                  }
                },
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    prefixIcon: const Icon(
                      EneftyIcons.global_outline,
                      color: Colors.black,
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: AppColors.error),
                    ),
                    labelText: Strings.COUNTRY.tr,
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                ),
              );
            },
          ),
          const SpaceH16(),
          GetBuilder<LocationsController>(
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
                selectedItem: controller.state,
                enabled: controller.country.id != null,
                asyncItems: (String filter) =>
                    controller.getCountryState(controller.country.id),
                itemAsString: (CountryState countries) =>
                    countries.name ?? Strings.SELECT_STATE.tr,
                onChanged: (CountryState? data) {
                  // ignore: unrelated_type_equality_checks
                  if (controller.state.name != data?.id) {
                    controller.state = data!;
                    // controller.city =  Cities as Cities;
                    controller.update(["city_dropdown"]);
                    controller.stateId = data.id!;
                    log.e(controller.state.id);
                  }
                },
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    prefixIcon: Icon(
                      EneftyIcons.map_outline,
                      color: controller.country.id != null
                          ? AppColors.black
                          : Colors.grey,
                    ),
                    labelText: Strings.STATE.tr,
                    labelStyle: const TextStyle(color: Colors.black),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                    errorBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: AppColors.error),
                    ),
                  ),
                ),
              );
            },
          ),
          const SpaceH16(),
          GetBuilder<LocationsController>(
            id: "city_dropdown",
            builder: (_) {
              return DropdownSearch<Cities>(
                popupProps: const PopupProps.menu(fit: FlexFit.loose),
                validator: (value) {
                  if (value?.id == null) {
                    return Strings.COUNTRY_IS_REQUIRED.tr;
                  }
                  return null;
                },
                selectedItem: controller.city,
                enabled: controller.state.id != null,
                asyncItems: (String filter) =>
                    controller.getStateCities(controller.state.id),
                itemAsString: (Cities countries) =>
                    countries.name ?? Strings.SELECT_CITY.tr,
                onChanged: (Cities? data) async {
                  controller.city = data!;
                  controller.cityId = data.id!;

                  log.e(controller.cityId);
                },
                dropdownDecoratorProps: DropDownDecoratorProps(
                  dropdownSearchDecoration: InputDecoration(
                    prefixIcon: Icon(
                      EneftyIcons.buildings_outline,
                      color: controller.state.id != null
                          ? Colors.black
                          : Colors.grey,
                    ),
                    labelText: Strings.CITY.tr,
                    labelStyle: const TextStyle(color: AppColors.black),
                    enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5.0)),
                      borderSide: BorderSide(color: AppColors.black),
                    ),
                  ),
                ),
              );
            },
          ),
          const SpaceH12(),
          CustomTextFormField(
            controller: controller.postalCodeCtrl,
            isRequired: true,
            borderRadius: 5.0,
            height: Sizes.HEIGHT_20,
            labelText: Strings.POSTAL_CODE.tr,
            labelColor: AppColors.black,
            prefixIcon: EneftyIcons.code_circle_outline,
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.error,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primaryColor,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
          ),
          const SpaceH4(),
          CustomTextFormField(
            controller: controller.phoneCtrl,
            isRequired: true,
            height: Sizes.HEIGHT_20,
            borderRadius: 5.0,
            labelText: Strings.PHONE.tr,
            labelColor: AppColors.black,
            prefixIcon: EneftyIcons.mobile_outline,
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.error,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primaryColor,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.number,
          ),
          const SpaceH4(),
          CustomTextFormField(
            controller: controller.completeAddressCtrl,
            isRequired: true,
            height: Sizes.HEIGHT_20,
            borderRadius: 5.0,
            labelText: Strings.COMPLETE_ADDRESS.tr,
            labelColor: AppColors.black,
            prefixIcon: EneftyIcons.location_outline,
            prefixIconColor: AppColors.black,
            textColor: AppColors.black,
            cursorColor: AppColors.black,
            errorColor: AppColors.error,
            enableBorderColor: AppColors.black,
            focusBorderColor: AppColors.primaryColor,
            textInputAction: TextInputAction.next,
            keyboardType: TextInputType.text,
          ),
          const SpaceH20(),
        ],
      ),
    );
  }
}
