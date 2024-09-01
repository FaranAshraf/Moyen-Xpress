
import '../resources/exports/index.dart';
import '../view_model/controllers/filter_product/filter_product_controller.dart';

class ColorGrid extends StatelessWidget {
  final List<String?> colors;

  const ColorGrid({Key? key, required this.colors}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final GridController controller = Get.put(GridController());

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Obx(() {
            int rowCount =
                controller.showAll.value ? (colors.length / 5).ceil() : 5;
            return GridView.builder(
              itemCount:
                  rowCount * 5 > colors.length ? colors.length : rowCount * 5,
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
                childAspectRatio: 1,
              ),
              itemBuilder: (context, index) {
                if (index >= colors.length) return const SizedBox.shrink();
                Color containerColor =
                    Color(int.parse(colors[index]!.replaceAll('#', '0xFF')));
                
                // Compare the current color with the selected color directly in Obx
                return GestureDetector(
                  onTap: () {
                    controller.colorCode.value = colors[index]!;
                  },
                  child: Obx(() {
                    bool isSelected = controller.colorCode.value == colors[index];
                    return Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? AppColors.primaryColor : Colors.transparent, // Adjusted border color logic
                        ),
                        color: containerColor,
                      ),
                      child: isSelected
                          ? const Center(
                              child:  Icon(
                                Icons.check,
                                color: Colors.white,
                              ),
                            )
                          : null,
                    );
                  }),
                );
              },
            );
          }),
          const SizedBox(height: 10),
          Obx(
            () => CustomButton.solid(
              backgroundColor: AppColors.primaryColor,
              textColor: AppColors.white,
              text: controller.showAll.value ? 'Show Less' : 'Show All',
              onTap: controller.toggleShowAll,
              radius: Sizes.RADIUS_6,
              constraints: const BoxConstraints(minHeight: 55),
            ),
          ),
        ],
      ),
    );
  }
}
