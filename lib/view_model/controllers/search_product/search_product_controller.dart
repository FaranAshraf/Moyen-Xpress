// import '../../../repository/search_repository.dart';
// import '../../../resources/exports/index.dart';

// class SearchProductController extends GetxController {
//   final TextEditingController searchController = TextEditingController();
//   RxBool displayText = false.obs;
// void onSearchTermSubmitted(String term) {
//  addToRecentSearches(term);
// getInfo(term);
// }
//     void onSearchTermSelected(String term) {
//     searchController.text = term;
//     addToRecentSearches(term);
//     getInfo(term);
//   }

//   final suggestions = [
//     'Smartphone',
//     'Watch',
//     'Laptop',
//     'Headphones',
//     'Camera',
//     'Television',
//     'Tablet',
//     'Speaker',
//     'Printer',
//     'Router',
//   ].obs;

//   var filteredSuggestions = <String>[].obs;

//   RxList searchResults = [].obs;

//   RxBool isLoading = false.obs;
//   final box = GetStorage();

//   @override
//   void onInit() {
//     super.onInit();
//     getSearchResults();
//     searchController.addListener(onSearchChanged);
//    if (box.hasData('recentSearches')) {
//   recentSearches = (box.read<List>('recentSearches') ?? []).map((item) => item.toString()).toList().obs;
// }

//   }

//   void onSearchChanged() {
//     String searchTerm = searchController.text.toLowerCase();
//     if (searchTerm.isEmpty) {
//       filteredSuggestions.clear();
//     } else {
//       //  addToRecentSearches(searchController.text);
//       getInfo(searchController.text);
//       filteredSuggestions.assignAll(suggestions
//           .where((suggestion) => suggestion.toLowerCase().contains(searchTerm))
//           .toList());
//     }
//   }

//    void clearAllRecentSearches() {
//     recentSearches.clear();
//     box.remove('recentSearches');
//   }

//    void deleteRecentSearch(int index) {
//     recentSearches.removeAt(index);
//     box.write('recentSearches', recentSearches.toList());
//   }

//    RxList<String> recentSearches = <String>[].obs;
// void addToRecentSearches(String term) {
//   if (!recentSearches.contains(term)) {
//     recentSearches.add(term);

//     box.write('recentSearches', recentSearches.toList());
//   }
// }

//   void getInfo(String infoProduct) async {
//     isLoading.value = true;

//     var results =
//         await SearchRepository.getSearchProduct(searchProduct: infoProduct);
//     if (results != null) {
//       searchResults.assignAll(results);
//     }

//     isLoading.value = false;
//   }

//   Future<void> getSearchResults()async{
//     await SearchRepository.productSearch(searchProduct:"ele");
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     searchController.dispose();
//   }
// }
import 'package:moyen_express/repository/search_repository.dart';

import '../../../model/search/search_model.dart';
import '../../../resources/exports/index.dart';
// Update with the correct path for your model files

class SearchProductController extends GetxController {
  var searchResults = Rx<SearchProducts?>(null);
  var isLoading = false.obs;
  String keywords = "";
  late TextEditingController searchController;

  @override
  void onInit() {
    super.onInit();
    searchController = TextEditingController();
    searchController.addListener(_performSearch);
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  void onSearchTermSubmitted(String term) {
    getInfo(term);
  }

  void getInfo(String infoProduct) async {
    isLoading.value = true;

    var results =
        await SearchRepository.productSearch(searchProduct: infoProduct);
    if (results != null) {
      searchResults.value = results;
    }

    isLoading.value = false;
  }

  void _performSearch() async {
    final query = searchController.text;
    if (query.isNotEmpty) {
      isLoading.value = true;
      final results =
          await SearchRepository.productSearch(searchProduct: query);
      searchResults.value = results;
      isLoading.value = false;
    } else {
      searchResults.value = null;
    }
  }
}
