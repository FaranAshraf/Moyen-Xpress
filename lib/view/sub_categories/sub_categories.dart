import '../../../resources/exports/index.dart';

class SubCategories extends GetView<SubCategoryController> {
  const SubCategories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Sub Categories"),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomFutureBuilder(
          future: HomeRepository.getSubCategories(
              subId: controller.subCategoryId.toString()),
          customLoader: const CategoriesShimmer(),
          hasDataBuilder: (_, snapshot) => GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            itemCount: (snapshot.data ?? []).length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: Sizes.WIDTH_18,
              mainAxisSpacing: Sizes.HEIGHT_20,
              childAspectRatio: 0.5,
              mainAxisExtent: 150,
            ),
            itemBuilder: (context, index) => _buildCategory(
              context,
              (snapshot.data ?? [])[index],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, SuccessContent item) {
    return InkWell(
        onTap: () {
          controller.itemId.value=item.id;
          log.e(item.id);
          Get.toNamed(Routes.CHILD_CATEGORY,
              arguments: {"childCategoryId": item.id});
        },
        child: Column(
          children: [
            Container(
              height: 90.0,
              width: 90.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primaryColor,
                boxShadow: [
                  BoxShadow(
                    color: AppColors.shadow,
                    offset: const Offset(0.0, 4.0),
                    blurRadius: 6.0,
                  )
                ],
              ),
              child: ImageService.image(item.icon ?? ""),
            ),
            const SpaceH12(),
            Text(
              item.name,
              style: context.titleMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ],
        ));
  }
}
