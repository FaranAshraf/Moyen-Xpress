import 'package:moyen_express/model/view_cart/view_cart_model.dart';
import 'package:moyen_express/repository/cart_repository.dart';

import '../../../resources/exports/index.dart';

// ignore: must_be_immutable
class QtyContainer extends GetView<CartController> {
  final CartItem product;
  int? id;
  QtyContainer({Key? key, required this.product, this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.0,
      width: 120.0,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.iconGrey,
        borderRadius: BorderRadius.circular(5.0),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadow,
            offset: const Offset(0.0, 4.0),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () async {
              if (product.quantity! > 1) {
                controller.subtractQty(product);
                await CartRepository.cartQuantity(
                    productId: id, quantity: product.quantity);
              } else {
                // You can optionally add a message to the user indicating the action cannot be performed
                 CustomSnackBar.showSnackBar(
          message: 'Quantity cannot be less than 1', snackBarStyle: SnackBarStyle.failure);
              }
            },
            child: Icon(
              Icons.do_not_disturb_on_outlined,
              color: product.quantity == 1 ? Colors.white : AppColors.black,
            ),
          ),
          Center(
            child: GetBuilder<CartController>(
              id: "qty_container",
              builder: (_) => Text(
                (product.quantity ?? 1).toString(),
                style: context.titleMedium,
              ),
            ),
          ).expanded(),
          GestureDetector(
            onTap: () async {
              controller.addQty(product);
              await CartRepository.cartQuantity(
                  productId: id, quantity: product.quantity);
            },
            child: const Icon(
              Icons.add_circle_outline,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
