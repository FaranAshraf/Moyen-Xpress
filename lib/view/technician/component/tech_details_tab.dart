import 'package:moyen_express/view_model/controllers/technician_detail/technician_detail_controller.dart';

import '../../../resources/exports/index.dart';

class TechnicianDetailsTabs extends GetView<TechnicianDetailController> {
  final List<Widget> tab;
  final List<Widget> children;

  const TechnicianDetailsTabs({
    super.key,
    required this.tab,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TabBar(
          controller: controller.tabCtrl,
          isScrollable: true,
          padding: EdgeInsets.zero,
          indicatorPadding: EdgeInsets.zero,
          tabAlignment: TabAlignment.start,
          dividerColor: AppColors.shadow,
          labelPadding: const EdgeInsets.only(right: 22.0),
          tabs: tab.map((e) => e).toList(),
        ),
        TabBarView(
          controller: controller.tabCtrl,
          children: List.generate(children.length, (index) => children[index]),
        ).expanded(),
      ],
    );
  }
}
