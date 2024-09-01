
import 'package:moyen_express/resources/exports/index.dart';

class CustomCountryPicker extends GetView<DashboardController> {
  const CustomCountryPicker({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(30),
      width: double.maxFinite,
      height: Sizes.HEIGHT_60,
      color: AppColors.white,
      child: CountryCodePicker(
        showFlag: true,
        showFlagDialog: true,
        alignLeft: true,
        textStyle: const TextStyle(
            color: AppColors.primaryColor,
            fontSize: 18,
            fontWeight: FontWeight.normal),
        textOverflow: TextOverflow.ellipsis,
        searchDecoration: InputDecoration(
            contentPadding: const EdgeInsets.only(left: 20),
            hintText: "Search",
            fillColor: AppColors.white,
            filled: true,
            suffix: const Icon(
              Icons.keyboard_arrow_down,
              color: AppColors.cartBtn,
            ),
            enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: AppColors.black),
                borderRadius: BorderRadius.circular(5)),
            border: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: AppColors.black),
                borderRadius: BorderRadius.circular(5)),
            focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: AppColors.black),
                borderRadius: BorderRadius.circular(5)),
            errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(width: 1, color: AppColors.black),
                borderRadius: BorderRadius.circular(5))),
        // initialSelection: 'US',
        showCountryOnly: true,
        showOnlyCountryWhenClosed: true,
        onChanged: (value) {
          controller.selectedCountry.value=value.toString();
         Get.toNamed(Routes.STORE);
        },
      ),
    );
  }
}
