import '../../resources/exports/index.dart';

class Categories extends GetView<CategoriesController> {
  const Categories({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final CategoriesController categoriesController =
        Get.put(CategoriesController());
    return Scaffold(
      body: PagedGridView(
        addAutomaticKeepAlives: true,
        pagingController: controller.pagingController,
        padding: const EdgeInsets.only(
          left: 12,
          right: 12,
          top: 12,
          bottom: 100,
        ),
        addRepaintBoundaries: true,
        shrinkWrap: true,
        physics: const ClampingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: Sizes.WIDTH_18,
          mainAxisSpacing: Sizes.HEIGHT_20,
          childAspectRatio: 0.5,
          mainAxisExtent: 150,
        ),
        builderDelegate: PagedChildBuilderDelegate<HomeCategoriesModel>(
          firstPageProgressIndicatorBuilder: (context) =>
              const CategoriesShimmer(),
          newPageProgressIndicatorBuilder: (context) =>
              CustomLoading.spinKitThreeBouncePrimary,
          firstPageErrorIndicatorBuilder: (context) =>  Align(
            alignment: Alignment.center,
            child: NoContent(
               img: Assets.CART_EMPTY,
              title: Strings.CONTENT_NOT_FOUND.tr,
              subtitle: Strings.SOMETHING_WENT_WRONG.tr,
              padding: 32,
              showBackground: false,
            ),
          ),
          noItemsFoundIndicatorBuilder: (context) =>  Align(
            alignment: Alignment.center,
            child: NoContent(
               img: Assets.NO_HISTORY,
              title: Strings.CONTENT_NOT_FOUND.tr,
              subtitle: Strings.NO_ITEMS_FOUND.tr,
              padding: 32,
              showBackground: false,
            ),
          ),
          newPageErrorIndicatorBuilder: (context) => Align(
            alignment: Alignment.center,
            child: CustomLoading.spinKitThreeBouncePrimary,
          ),
          itemBuilder: (context, item, index) => _buildCategory(
            context,
            item,
          ),
        ),
      ),
    );
  }

  Widget _buildCategory(BuildContext context, HomeCategoriesModel item) {
    return InkWell(
      onTap: () {
        log.d(item.id);
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
          ).constrainedBox(maxWidth: 90),
        ],
      ),
    );
  }
}
