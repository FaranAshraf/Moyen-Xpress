// LocationCard widget
import 'package:moyen_express/view/add_new_address/components/edit_address_screen.dart';

import '../resources/exports/index.dart';

class LocationCard extends StatelessWidget {
  final String? address;
  final String? postalCode;
  final String? cityName;
  final String? stateName;
  final String? phoneNo;
  final int? id;
  final AddressData? addressValue;
  final Function(int)? onSelect;

  const LocationCard({
    Key? key,
    this.address,
    this.postalCode,
    this.cityName,
    this.stateName,
    this.phoneNo,
    this.id,
    this.addressValue,
    this.onSelect,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final LocationsController controller = Get.put(LocationsController());

    return GetBuilder<LocationsController>(
      builder: (_) {
        bool isSelected = controller.selectedLocationId == id;
        return GestureDetector(
          onTap: () {
            controller.toggleSelected(id!);
            onSelect!(id!);
          },
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: AppColors.white,
              border: Border.all(
                color: isSelected ? AppColors.primaryColor : AppColors.white,
              ),
              borderRadius: BorderRadius.circular(10.0),
              boxShadow: [
                BoxShadow(
                  color: AppColors.shadow,
                  offset: const Offset(0.0, 8.0),
                  blurRadius: 8.0,
                ),
              ],
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      flex: 2,
                      child: _buildAddressText(
                        context,
                        Strings.ADDRESS.tr,
                        address,
                      ),
                    ),
                    Flexible(
                      child: SizedBox(
                        height: Sizes.HEIGHT_16,
                        child: Radio(
                          value: true,
                          groupValue: isSelected,
                          onChanged: (value) {
                            controller.toggleSelected(id!);
                            onSelect!(id!);
                          },
                          activeColor: AppColors.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                _buildAddressText(
                  context,
                  Strings.POSTAL_CODE.tr,
                  postalCode,
                ),
                const SizedBox(height: 8),
                _buildAddressText(
                  context,
                  Strings.CITY.tr,
                  cityName,
                ),
                const SizedBox(height: 8),
                _buildAddressText(
                  context,
                  Strings.STATE.tr,
                  stateName,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildAddressText(
                      context,
                      Strings.PHONE.tr,
                      phoneNo,
                    ).expanded(),
                    const SizedBox(width: 10),
                    InkWell(
                      onTap: () async {
                        await controller.deleteLocation(id!);
                        controller.update();
                      },
                      child: const Icon(
                        Icons.delete_outline_outlined,
                        color: AppColors.error,
                      ),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: () => Get.to(
                        EditAddressScreen(
                          address: addressValue!,
                          id: id!,
                        ),
                      ),
                      child: const Icon(Icons.edit_outlined),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAddressText(
    BuildContext context,
    String title,
    String? subTitle,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$title : "),
        Text(
          subTitle ?? "-",
          style: context.titleSmall.copyWith(
            fontWeight: FontWeight.w600,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ).expanded(),
      ],
    );
  }
}


