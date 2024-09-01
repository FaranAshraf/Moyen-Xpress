import '../../resources/exports/index.dart';

class Promotions extends GetView<HomeController> {
  const Promotions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  CustomAppBar(title: Strings.PROMOTIONS.tr),
      body: PaginatedListView(
        apiUrl: Urls.PROMOTIONS,
        borderRadius: 0.0,
        showOnlyImage: true,
        onCardTap: (id) => log.f(id),
      ),
    );
  }
}
