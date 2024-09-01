import 'package:moyen_express/utils/no_login_widget.dart';

import '../resources/exports/index.dart';

class CustomFutureCartBuilderEmpty<T> extends StatelessWidget {
  final Future<T> future;
  final AsyncWidgetBuilder<T> hasDataBuilder;
  final Function(T?)? data;
  final double loaderSize;
  final Widget? customLoader;
  final String? errorTitle;
  final String? errorSubtitle;
  final double? noContentPadding;
  final Widget? reloadWidget;
  final bool showNoContentBackground;

  const CustomFutureCartBuilderEmpty({
    Key? key,
    required this.future,
    required this.hasDataBuilder,
    this.data,
    this.loaderSize = 30,
    this.customLoader,
    this.errorTitle,
    this.errorSubtitle = 'Failed to Retrieve your data.',
    this.noContentPadding,
    this.reloadWidget,
    this.showNoContentBackground = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if user is logged in
    bool isLoggedIn =
        AuthManager.instance.isLoggedIn; // You need to implement this method

    if (!isLoggedIn) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            NoLoginWidget(
              title: errorTitle ?? "Please Sign In First!!",
              subtitle: "You have to Sign In to See Data",
              padding: noContentPadding ?? 32,
              showBackground: showNoContentBackground,
            ).expanded(),
           CustomButton.solid(
            margin: const EdgeInsets.all(16.0),
            text: Strings.SIGN_IN.tr,
            textColor: AppColors.white,
            onTap: () => Get.toNamed(Routes.SIGN_IN),
            radius: 0.5,
           ),
          ],
        ),
      );
    }

    return FutureBuilder<T>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return customLoader ??
              const Center(
                child: SizedBox(
                    width: Sizes.WIDTH_24,
                    height: Sizes.HEIGHT_24,
                    child: CircularProgressIndicator(
                        strokeWidth: 2.0, color: AppColors.primaryColor)),
              );
        } else if (snapshot.connectionState == ConnectionState.active ||
            snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError || snapshot.data == null) {
            return reloadWidget ??
                NoContent(
                  img: Assets.NO_HISTORY,
                  title: errorTitle ?? "Content Not Found !!",
                  subtitle: errorSubtitle!,
                  padding: noContentPadding ?? 32,
                  showBackground: showNoContentBackground,
                );
          } else if (snapshot.hasData) {
            if (snapshot.data == [] || GetUtils.isBlank(snapshot.data)!) {
              return reloadWidget ??
                  NoContent(
                     img: Assets.CART_EMPTY,
                    title: errorTitle ?? "Your Cart is Empty !!",
                    subtitle: "No Data Found",
                    padding: noContentPadding ?? 32,
                    showBackground: showNoContentBackground,
                  );
            } else {
              if (data != null) data!.call(snapshot.data);
              return hasDataBuilder(context, snapshot);
            }
          } else {
            return Center(
              child: Text(
                errorSubtitle!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }
        } else {
          return Center(
            child: Text(
              'State: ${snapshot.connectionState}',
              style: const TextStyle(color: AppColors.primaryColor),
            ),
          );
        }
      },
    );
  }
}
