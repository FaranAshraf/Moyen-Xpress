import 'package:moyen_express/model/upload_images/upload_images.dart';

import '../resources/exports/index.dart';
import 'package:http/http.dart' as http;

import 'package:path_provider/path_provider.dart';

class GalleryRepository {
  static BaseApiServices apiService = NetworkApiServices();
  static Future<GalleryModel?> getGalleryData({
    String? search,
    String? sort,
  }) async {
    final response =
        await apiService.getApi(Urls.GALLERY_DATA, quaryParameters: {
      if (search != null) "search": search,
      if (sort != null) "sort": sort,
    });

    if (response is bool) return null;
    log.e(response);
    return GalleryModel.fromJson(response);
  }

   static Future<void> getPackageImage(File? image) async {
    try {
      if (image != null) {
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = tempDir.path;
        String fileName = image.path.split('/').last; // Get original file name
        String filePath = '$tempPath/$fileName';
        File profileImageFile = File(filePath);
        await profileImageFile.writeAsBytes(await image.readAsBytes());

        var request = http.MultipartRequest(
          'POST',
          Uri.https(FlutterConfig.get('baseUrl'), Urls.POST_IMAGE),
        );

        request.headers.addAll(NetworkApiServices.generateHeaders());
        request.files.add(
          await http.MultipartFile.fromPath('image', profileImageFile.path,
              filename: fileName), // Use original file name
        );

        http.StreamedResponse response = await request.send();
        String responseBody = await response.stream.bytesToString();

        if (kDebugMode) {
          print('Response Body: $responseBody');
        } // Print response for debugging

        if (response.statusCode == 200) {
          // Check if the response is JSON and handle accordingly
          try {
            Map<String, dynamic> responseData = json.decode(responseBody);
            String message = responseData['message'] ?? 'Unknown message';
            if (kDebugMode) {
              print("Response from server: $message");
            }
          } catch (e) {
            if (kDebugMode) {
              print('Invalid JSON format in response');
            }
          }
        } else {
          if (kDebugMode) {
            print('Error: ${response.reasonPhrase}');
          }
        }
      } else {
        throw Exception("Image is null");
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading profile image: $e');
      }
    }
  }
}
