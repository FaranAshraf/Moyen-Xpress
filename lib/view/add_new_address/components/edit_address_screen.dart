import 'package:moyen_express/model/countries/city_model.dart';
import 'package:moyen_express/model/countries/countries_model.dart';
import 'package:moyen_express/model/countries/state_model.dart';
import 'package:dropdown_search/dropdown_search.dart';

import '../../../resources/exports/index.dart';

// ignore: must_be_immutable
class EditAddressScreen extends StatelessWidget {
  final AddressData address;
  int id;
  EditAddressScreen({super.key, required this.address, required this.id});

  @override
  Widget build(BuildContext context) {
    final LocationsController controller = Get.put(LocationsController());
    controller.editPhoneCtrl.text = address.phone ?? '';
    controller.editPostalCodeCtrl.text = address.postalCode ?? '';
    controller.editCompleteAddressCtrl.text = address.address ?? '';

    return Scaffold(
      appBar: const CustomAppBar(title: "Edit Address"),
      body: Center(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Strings.EDIT_ADDRESS.tr,
                style: context.headlineSmall.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
              Text(
                Strings.FILL_BELOW_FIELDS_EDIT.tr,
                style: context.titleMedium.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SpaceH36(),
              GetBuilder<LocationsController>(
                  id: "country_dropdown",
                  builder: (_) {
                    return DropdownSearch<Country>(
                      // Country Dropdown
                      popupProps: const PopupProps.menu(fit: FlexFit.loose),
                      validator: (value) {
                        if (value?.id == null) {
                          return "Country is required".tr;
                        }
                        return null;
                      },
                      selectedItem: Country(
                          id: address.country?.id, name: address.country?.name),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: AppColors.error),
                          ),
                          labelText: Strings.COUNTRY.tr,
                          labelStyle: const TextStyle(color: Colors.black),
                          enabledBorder: const OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: Colors.black),
                          ),
                        ),
                      ),
                    );
                  }),
              const SpaceH16(),
              GetBuilder<LocationsController>(
                  id: "state_dropdown",
                  builder: (_) {
                    return DropdownSearch<CountryState>(
                      // State Dropdown
                      popupProps: const PopupProps.menu(fit: FlexFit.loose),
                      validator: (value) {
                        if (value?.id == null) {
                          return Strings.STATE_IS_REQUIRED.tr;
                        }
                        return null;
                      },
                      selectedItem: CountryState(
                          id: address.state?.id, name: address.state?.name),
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
                  }),
              const SpaceH16(),
              GetBuilder<LocationsController>(
                  id: "city_dropdown",
                  builder: (_) {
                    return DropdownSearch<Cities>(
                      // City Dropdown
                      popupProps: const PopupProps.menu(fit: FlexFit.loose),
                      validator: (value) {
                        if (value?.id == null) {
                          return Strings.COUNTRY_IS_REQUIRED.tr;
                        }
                        return null;
                      },
                      selectedItem: Cities(
                          id: address.city?.id, name: address.city?.name),
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                        ),
                      ),
                    );
                  }),
              const SpaceH12(),
              CustomTextFormField(
                controller: controller.editPostalCodeCtrl,
                isRequired: true,
                borderRadius: 5.0,
                height: Sizes.HEIGHT_20,
                labelText: Strings.POSTAL_CODE,
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
              CustomTextFormField(
                controller: controller.editPhoneCtrl,
                isRequired: true,
                borderRadius: 5.0,
                height: Sizes.HEIGHT_20,
                labelText: Strings.PHONE,
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
              CustomTextFormField(
                controller: controller.editCompleteAddressCtrl,
                isRequired: true,
                borderRadius: 5.0,
                height: Sizes.HEIGHT_20,
                labelText: Strings.COMPLETE_ADDRESS,
                labelColor: AppColors.black,
                prefixIcon: EneftyIcons.code_circle_outline,
                prefixIconColor: AppColors.black,
                textColor: AppColors.black,
                cursorColor: AppColors.black,
                errorColor: AppColors.error,
                enableBorderColor: AppColors.black,
                focusBorderColor: AppColors.primaryColor,
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
              ),
              CustomButton.solid(
                margin: const EdgeInsets.only(top: 30.0),
                backgroundColor: AppColors.primaryColor,
                textColor: AppColors.white,
                text: Strings.SAVE,
                onTap: () async => controller.updateLocation(id),
                radius: Sizes.RADIUS_6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
