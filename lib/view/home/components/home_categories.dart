import '../../../resources/exports/index.dart';

class HomeCategories extends GetView<HomeController> {
  const HomeCategories({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomFutureBuilder(
      future: HomeRepository.getCategories(),
      customLoader: const HomeCategoriesShimmer(),
      hasDataBuilder: (_, snapshot) => ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 12.0),
        itemCount:
            (snapshot.data ?? []).length > 8 ? 8 : (snapshot.data ?? []).length,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => _buildCategory(
          context,
          (snapshot.data ?? [])[index],
        ),
        separatorBuilder: (_, __) => const SpaceW12(),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, HomeCategoriesModel item) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.SUB_CATEGORIES,
            arguments: {"subCategoryId": item.id});
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
            child: ImageService.image(item.image ?? ""),
          ),
          const SpaceH12(),
          Text(
            item.title ?? "",
            style: context.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ).constrainedBox(maxWidth: 90),
    );
  }
}
