import 'package:dropdown_search/dropdown_search.dart';
import 'package:moyen_express/resources/exports/index.dart';
import '../../model/countries/city_model.dart';
import '../../model/countries/countries_model.dart';
import '../../model/countries/state_model.dart';
import '../../utils/color_pick.dart';
import '../../view_model/controllers/filter_product/filter_product_controller.dart';

class FiltersView extends GetView<GridController> {
  const FiltersView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GridController controller = Get.put(GridController());

    return Scaffold(
      appBar: AppBar(
        title: Text(Strings.SELECT_FILTERS.tr),
        centerTitle: true,
        leadingWidth: 50.0,
        leading: GestureDetector(
          onTap: () => Get.toNamed(Routes.NEW_ARRIVALS),
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Fetching colors and displaying them in a grid
                  CustomFutureBuilder(
                    future: HomeRepository.getColors(),
                    hasDataBuilder: (context, snapshot) {
                      List<String?> colors = snapshot.data?.map((colorBrand) {
                            return colorBrand?.code;
                          }).toList() ??
                          [];

                      return ColorGrid(colors: colors);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        Strings.PRICE_REGION.tr,
                        style: context.bodyLarge.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Center(
                    child: Obx(
                      () => RangeSlider(
                        labels: controller.labels.value,
                        values: controller.values.value,
                        min: 0.00,
                        max: 97000000.0,
                        divisions: 10,
                        onChanged: (newValues) {
                          controller.updateLabels(newValues);
                          controller.minPrice.value =
                              newValues.start.toString();
                          controller.maxPrice.value = newValues.end.toString();
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        Strings.FILTER_REGION.tr,
                        style: context.bodyLarge.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GetBuilder<GridController>(
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
                          asyncItems: (String filter) =>
                              controller.getCountries(),
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
                              log.e(controller.countryId);
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
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                    child: GetBuilder<GridController>(
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
                            if (controller.state.id != data?.id) {
                              controller.state = data!;
                              controller.update(["city_dropdown"]);
                              controller.stateId = data.id!;
                              log.e(controller.stateId);

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
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: GetBuilder<GridController>(
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
                              labelStyle:
                                  const TextStyle(color: AppColors.black),
                              enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5.0)),
                                borderSide: BorderSide(color: AppColors.black),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        Strings.FILTER_RATINGS.tr,
                        style: context.bodyLarge.copyWith(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  for (int i = 5; i >= 1; i--)
                    Obx(
                      () => Row(
                        children: [
                          Checkbox(
                            key: UniqueKey(),
                            value: controller.selectedRatingFilter.value == i,
                            onChanged: (value) {
                                    controller.updateRating(i);
                                  }
                              
                          ),
                          Row(
                            children: List.generate(5, (index) {
                              return Icon(
                                index < i ? Icons.star : Icons.star_border,
                                color: Colors.orange,
                                size: 30.0,
                              );
                            }),
                          ),
                          const SizedBox(width: 3),
                          Text('($i)'),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
       CustomButton.solid(
  margin: const EdgeInsets.all(10.0),
  backgroundColor: AppColors.primaryColor,
  textColor: AppColors.white,
  text: Strings.SEARCH,
  onTap: () {
    // Check the previous route
    String previousRoute = Get.previousRoute;

    // Conditionally navigate based on the previous route
    if (previousRoute == Routes.ALL_PRODUCTS) {
      Get.toNamed(Routes.ALL_PRODUCTS);
    } else if (previousRoute == Routes.NEW_ARRIVALS) {
      Get.toNamed(Routes.NEW_ARRIVALS);
    } else {
      // Default navigation fallback
      Get.toNamed(Routes.NEW_ARRIVALS);
    }
  },
  radius: Sizes.RADIUS_6,
  constraints: const BoxConstraints(minHeight: 55),
),
  
        ],
      ),
    );
  }

  // ignore: unused_element
  Widget _buildRatingRow(int rating) {
    return Obx(
      () => Row(
        children: [
          Checkbox(
            key: UniqueKey(),
            value: controller.selectedRatingFilter.value == rating,
            onChanged: (value) {
              controller.updateRating(rating);
              controller.onInit();
            },
          ),
          Row(
            children: List.generate(5, (index) {
              return Icon(
                index < rating ? Icons.star : Icons.star_border,
                color: Colors.orange,
                size: 30.0,
              );
            }),
          ),
          const SizedBox(width: 3),
          Text('($rating)'),
        ],
      ),
    );
  }
}
