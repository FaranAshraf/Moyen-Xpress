import '../../../resources/exports/index.dart';

class HomeCategoriesShimmer extends GetView<HomeController> {
  const HomeCategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) => _buildCategory(),
      separatorBuilder: (_, __) => const SpaceW12(),
    );
  }

  Widget _buildCategory() {
    return Column(
      children: [
        Container(
          height: 90.0,
          width: 90.0,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.white,
          ),
        ).shimmerWidget,
        const SpaceH12(),
        Container(
          width: 80.0,
          height: 20.0,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(10.0),
          ),
        ).shimmerWidget,
      ],
    );
  }
}
