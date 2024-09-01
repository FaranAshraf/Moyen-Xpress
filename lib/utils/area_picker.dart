

import '../resources/exports/index.dart';

// ignore: must_be_immutable
class AreaPicker extends StatelessWidget {
  AreaPicker({super.key});
  TextEditingController country = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController city = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CountryStateCityPicker(
        country: country,
        state: state,
        city: city,
        dialogColor: Colors.grey.shade200,
        textFieldDecoration: InputDecoration(
            hintStyle: TextStyle(color: AppColors.black.withOpacity(0.5)),
            fillColor: Colors.transparent,
            filled: true,
            suffixIcon: Icon(Icons.keyboard_arrow_down,
                color: AppColors.black.withOpacity(0.5)),
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
                borderRadius: BorderRadius.circular(5))));
  }
}
