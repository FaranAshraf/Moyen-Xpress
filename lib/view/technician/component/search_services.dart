import 'package:moyen_express/resources/exports/index.dart';

class SearchServices extends StatelessWidget {
  const SearchServices({super.key});

  @override
  Widget build(BuildContext context) {
    final TechnicianController technicianController=Get.put(TechnicianController());
    return Scaffold(
      appBar: const CustomAppBar(title: "Search Services"),
      body: SingleChildScrollView(
      physics: const NeverScrollableScrollPhysics(),
      child: PaginatedListView(
          showOnlyRightBtn: true,
          showTopSellerOrBrands: false,
          apiUrl: '/api/appV1/technicians',
          // dummyData: ListViewModel.listFromJson(technicianData),
          parameters: {
            "service_country": technicianController.countryId,
            "service_state": technicianController.stateId,
            "service_city": technicianController.cityId,
          },
          onCardTap: (id) {
            log.e(id);
            Get.toNamed(
              Routes.TECH_DETAIL,
              arguments: {
                "techId": id,
              },
            );
          }),
    ),
    );
  }
}