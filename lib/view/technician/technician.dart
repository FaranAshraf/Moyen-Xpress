import 'package:dropdown_search/dropdown_search.dart';
import 'package:moyen_express/model/countries/city_model.dart';
import 'package:moyen_express/model/countries/countries_model.dart';
import 'package:moyen_express/model/countries/state_model.dart';

import '../../resources/exports/index.dart';

class TechnicianView extends StatefulWidget {
  const TechnicianView({Key? key}) : super(key: key);

  @override
  State<TechnicianView> createState() => _TechnicianViewState();
}

class _TechnicianViewState extends State<TechnicianView> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final TechnicianController controller = Get.put(TechnicianController());

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: CustomAppBar(title: Strings.TECHNICIAN.tr),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Container(
                height: 250.0,
                width: double.maxFinite,
                margin: const EdgeInsets.all(12.0),
                child: ImageService.image(Assets.TECHNICIAN_HEADER, scale: 1.1),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Strings.SELECT_AREA.tr,
                    style: context.headlineMedium.copyWith(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              GetBuilder<TechnicianController>(
                id: "country_dropdown",
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: DropdownSearch<Country>(
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
                    ),
                  );
                },
              ),
              const SpaceH16(),
              GetBuilder<TechnicianController>(
                id: "state_dropdown",
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: DropdownSearch<CountryState>(
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
                        if (controller.state.id != data?.id) {
                          controller.state = data!;
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
                    ),
                  );
                },
              ),
              const SpaceH16(),
              GetBuilder<TechnicianController>(
                id: "city_dropdown",
                builder: (_) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 7.0),
                    child: DropdownSearch<Cities>(
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
                            borderRadius:
                                BorderRadius.all(Radius.circular(5.0)),
                            borderSide: BorderSide(color: AppColors.black),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: CustomButton(
                  radius: 5,
                  text: Strings.SEARCH.tr,
                  textStyle: context.headlineMedium.copyWith(
                    color: AppColors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                  onTap: () {
                    if (_formKey.currentState!.validate()) {
                      controller.isTechProducts.value = true;
                      controller.searchResult.value =
                          !controller.searchResult.value;
                      Get.toNamed(Routes.SEARCH_SERVICES);
                    }
                  },
                ),
              ),
              if (controller.searchResult.value == false)
                Padding(
                  padding: const EdgeInsets.only(left: 15, top: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      Strings.ALL_SERVICES.tr,
                      style: context.bodyLarge.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                        color: AppColors.tagGrey,
                      ),
                    ),
                  ),
                ),
              PaginatedListView(
                  showOnlyRightBtn: true,
                  showTopSellerOrBrands: false,
                  apiUrl: Urls.TECHNICIAN,
                
                  onCardTap: (id) {
                    log.e(id);
                    Get.toNamed(
                      Routes.TECH_DETAIL,
                      arguments: {
                        "techId": id,
                      },
                    );
                  },
                  onSecondaryButtonTap: (id) => Get.toNamed(
                        Routes.TECH_DETAIL,
                        arguments: {
                          "techId": id,
                        },
                      )),
            ],
          ),
        ),
      ),
    );
  }
}
