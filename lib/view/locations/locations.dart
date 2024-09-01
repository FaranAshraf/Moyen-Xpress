import 'package:moyen_express/repository/country_state_city_repository.dart';
import '../../resources/exports/index.dart';

class Locations extends GetView<LocationsController> {
  const Locations({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: Strings.MY_ADDRESS.tr,
        actions: GestureDetector(
          onTap: () {
            Get.toNamed(Routes.ADD_NEW_SCREEN);
          },
          child: const Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: Icon(
              EneftyIcons.location_add_outline,
              color: AppColors.primaryColor,
              size: 35,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: CSCRepository.seeAddress(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: SizedBox(
                  width: Sizes.WIDTH_24,
                  height: Sizes.HEIGHT_24,
                  child: CircularProgressIndicator(
                      strokeWidth: 2.0, color: AppColors.primaryColor)),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == [] || GetUtils.isBlank(snapshot.data)!) {
            return _buildLocations(snapshot.data!, controller, true);
          } else if (snapshot.hasData) {
            final List<AddressData> data = snapshot.data!;
            return _buildLocations(data, controller, false);
          } else {
            return const Center(child: Text('No data available'));
          }
        },
      ),
    );
  }

  Widget _buildLocations(
      List<AddressData> data, LocationsController locationsController, bool showData) {
    final CartController controller = Get.put(CartController());
    return Column(
      children: [
        if (showData) ...[
          const Center(
            child: NoContent(
              img: Assets.NO_HISTORY,
              title: "No Address Found !!",
              subtitle: "Add New Location by tapping on Top Right Button",
              padding: 32,
              showBackground: true,
            ),
          )
        ],
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16.0),
            itemCount: data.length,
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return LocationCard(
                id: data[index].id ?? 0,
                address: data[index].address ?? 'No Text',
                postalCode: data[index].postalCode ?? 'No Text',
                cityName: data[index].city?.name.toString() ?? 'No Text',
                stateName: data[index].state?.name.toString() ?? 'No Text',
                phoneNo: data[index].phone ?? 'No Text',
                addressValue: data[index],
                onSelect: (id) {
                  if (kDebugMode) {
                    print('Selected ID: $id');
                  }
                  controller.selectedId.value = id;
                  log.e(controller.selectedId.value);
                },
              );
            },
            separatorBuilder: (_, __) => const SizedBox(height: 20),
          ),
        ),
        CustomButton.solid(
          margin: const EdgeInsets.all(10.0),
          backgroundColor: AppColors.primaryColor,
          textColor: AppColors.white,
          text: Strings.DELIVERY_INFO.tr,
          onTapAsync: () async {
            // ignore: unnecessary_null_comparison
          //   if (controller.selectedId.value == null || controller.selectedId.value == 0) {
          //     CustomSnackBar.showSnackBar(
          // message: 'Select a Location before Proceeding', snackBarStyle: SnackBarStyle.failure);
          //   } else {
              await Future.delayed(
                const Duration(seconds: 1),
                () => Get.toNamed(Routes.ORDER_CONFIRMATION, arguments: {
                  "addressId": controller.selectedId.value,
                }),
              );
            // }
          },
          radius: Sizes.RADIUS_6,
          constraints: const BoxConstraints(minHeight: 55),
        ),
      ],
    );
  }
}
