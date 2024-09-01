import 'package:moyen_express/resources/exports/index.dart';

class SettingController extends GetxController {
  List<String> currencyListNew = [
    "AED",
    "AFN",
    "ALL",
    "AMD",
    "ANG",
    "AOA",
    "ARS",
    "AUD",
    "AWG",
    "AZN",
    "BAM",
    "BBD",
    "BDT",
    "BGN",
    "BHD",
    "BIF",
    "BMD",
    "BND",
    "BOB",
    "BRL",
    "BSD",
    "BTN",
    "BWP",
    "BYN",
    "BZD",
    "CAD",
    "CDF",
    "CHF",
    "CLP",
    "CNY",
    "COP",
    "CRC",
    "CUP",
    "CVE",
    "CZK",
    "DJF",
    "DKK",
    "DOP",
    "DZD",
    "EGP",
    "ERN",
    "ETB",
    "EUR",
    "FJD",
    "FKP",
    "FOK",
    "GBP",
    "GEL",
    "GGP",
    "GHS",
    "GIP",
    "GMD",
    "GNF",
    "GTQ",
    "GYD",
    "HKD",
    "HNL",
    "HRK",
    "HTG",
    "HUF",
    "IDR",
    "ILS",
    "IMP",
    "INR",
    "IQD",
    "IRR",
    "ISK",
    "JEP",
    "JMD",
    "JOD",
    "JPY",
    "KES",
    "KGS",
    "KHR",
    "KID",
    "KMF",
    "KRW",
    "KWD",
    "KYD",
    "KZT",
    "LAK",
    "LBP",
    "LKR",
    "LRD",
    "LSL",
    "LYD",
    "MAD",
    "MDL",
    "MGA",
    "MKD",
    "MMK",
    "MNT",
    "MOP",
    "MRU",
    "MUR",
    "MVR",
    "MWK",
    "MXN",
    "MYR",
    "MZN",
    "NAD",
    "NGN",
    "NIO",
    "NOK",
    "NPR",
    "NZD",
    "OMR",
    "PAB",
    "PEN",
    "PGK",
    "PHP",
    "PKR",
    "PLN",
    "PYG",
    "QAR",
    "RON",
    "RSD",
    "RUB",
    "RWF",
    "SAR",
    "SBD",
    "SCR",
    "SDG",
    "SEK",
    "SGD",
    "SHP",
    "SLE",
    "SOS",
    "SRD",
    "SSP",
    "STN",
    "SYP",
    "SZL",
    "THB",
    "TJS",
    "TMT",
    "TND",
    "TOP",
    "TRY",
    "TTD",
    "TVD",
    "TWD",
    "TZS",
    "UAH",
    "UGX",
    "USD",
    "UYU",
    "UZS",
    "VES",
    "VND",
    "VUV",
    "WST",
    "XAF",
    "XCD",
    "XDR",
    "XOF",
    "XPF",
    "YER",
    "ZAR",
    "ZMW",
    "ZWL",
  ];
late RxString currentCurrency = "USD".obs;
  void getSettings() {
    Get.defaultDialog(
      title: "Currency Converter",
      titleStyle: const TextStyle(color: AppColors.primaryColor),
      content: Form(
        // key: sendRequestFormKey,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),

              // change Currency
              DropdownButton<String>(
                dropdownColor: AppColors.black,
                value: currentCurrency.value,
                items: currencyListNew
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(value),
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    currentCurrency.value = newValue;
                    update();
                    // Get.put(dependency);
                    // controller.setSelectedCity(val);
                  }
                },
              ),

              // Dropdown(
              //   color: textFieldColor,
              //   dropdown: DropdownSearch<String>(
              //     emptyBuilder: (context, searchEntry) => Center(
              //       child: Material(
              //         child: Text(
              //           noDataSUtil.tr,
              //           style: med16.copyWith(color: customGreyColor),
              //         ),
              //       ),
              //     ),
              //     dropDownButton: Icon(Icons.keyboard_arrow_down_outlined,
              //         color: Colors.grey, size: sizeW(20)),
              //     dropdownSearchDecoration: InputDecoration(
              //         border: InputBorder.none,
              //         icon: Icon(Icons.currency_exchange_outlined,
              //             color: customPrimaryColor, size: sizeW(15))),
              //     mode: Mode.BOTTOM_SHEET,
              //     // enabled: controller.isCityEnabled.value,
              //     showSelectedItem: true,
              //     showSearchBox: true,
              //     selectedItem: currentCurrency,
              //     items: currencyListNew,
              //     //currencyList.map((e) => e.entries).toList(),
              //     hint: selectCurrencySUtil.tr,
              //     onChanged: (val) {
              //       currentCurrency = val!;
              //       // Get.put(dependency);
              //       // controller.setSelectedCity(val);
              //     },
              //     // selectedItem: "Brazil"
              //   ),
              // ),

              const SizedBox(height: 20),
              // SizedBox(
              //   height: Get.height * 0.06,
              //   width: Get.width * 0.9,
              //   child: CustomButton(
              //     label: updateSUtil.tr,
              //     isSelected: false,
              //     onTap: () {
              //       final cc = Get.put(CurrencyConversionController());
              //       cc.changeCurrentCurrency(currentCurrency);
              //       _getStorage.write(
              //           languageLocalePUtil, languageList[currentLanguage]!);
              //       Get.updateLocale(Locale(languageList[currentLanguage]!));

              //       Get.back();
              //       // sendAskAmountRequest();
              //     },
              //   ),
              // )
            ],
          ),
        ),
      ),
    );
  }
}
