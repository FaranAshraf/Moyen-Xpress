import '../../resources/exports/index.dart';

class CustomRadioButton extends StatelessWidget {
  final dynamic title;
  final dynamic value;
  final dynamic groupValue;
  final dynamic onChanged;
  const CustomRadioButton(
      {super.key,
      required this.title,
      required this.value,
      required this.groupValue,
      required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return RadioListTile(
        contentPadding: EdgeInsets.zero,
        activeColor: AppColors.primaryColor,
        title: Text(
          title,
          style:
              context.bodyMedium.copyWith(fontSize: 17, color: AppColors.black),
        ),
        value: value,
        groupValue: groupValue,
        onChanged: onChanged);
  }
}
