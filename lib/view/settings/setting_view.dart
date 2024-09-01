
import 'package:moyen_express/resources/exports/index.dart';
import 'package:moyen_express/view_model/controllers/settings/setting_controller.dart';

class Settings extends GetView<SettingController> {
  const Settings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: Strings.SETTING.tr),
      body: Column(
        children: [
          DropdownButton<String>(
            dropdownColor: AppColors.cartBtn,
            value: controller.currentCurrency.value,
            items: controller.currencyListNew
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Row(
                    children: [
                      Text(value),
                    ],
                  ),
                ),
              );
            }).toList(),
            onChanged: (String? newValue) {
              if (newValue != null) {
                controller.currentCurrency.value = newValue;
                controller.update();
                // You can add any logic here upon changing the currency
              }
            },
          ),
         
        ],
      ),
    );
  }
}
