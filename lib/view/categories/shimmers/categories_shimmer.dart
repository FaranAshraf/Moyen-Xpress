import 'package:moyen_express/resources/exports/index.dart';

class CategoriesShimmer extends StatelessWidget {
  const CategoriesShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(18.0),
      child: GridView.builder(
        itemCount: 50,
        shrinkWrap: true,
        addRepaintBoundaries: true,
        physics: const BouncingScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisExtent: 150.0,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
        ),
        itemBuilder: (context, index) => _buildCategory(),
      ),
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
