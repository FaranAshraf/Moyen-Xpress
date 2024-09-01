import 'package:moyen_express/utils/custom_future_product_builder.dart';

import '../../../resources/exports/index.dart';

class ChildCategory extends GetView<ChildCategoryController> {
  const ChildCategory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: GestureDetector(
          onTap: Get.back,
          child: const Icon(Icons.arrow_back_ios, color: Colors.black),
        ),
        title: const Text("Sub Categories / Products"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(4.0),
        child: CustomFutureProduct(
          future: HomeRepository.getSubCategories(
              subId: controller.childCategoryId.toString()),
          customLoader: const CategoriesShimmer(),
          hasDataBuilder: (_, snapshot) => GridView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 7.0),
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
          Get.toNamed(Routes.CATEGORIES_PRODUCT,
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
