class GalleryModel {
  List<Upload>? uploads;

  GalleryModel({
    this.uploads,
  });

  factory GalleryModel.fromJson(Map<String, dynamic> json) {
    var uploadsList = json['uploads'] as List;
    List<Upload> uploads = uploadsList.map((i) => Upload.fromJson(i)).toList();

    return GalleryModel(
      uploads: uploads,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uploads': uploads!.map((e) => e.toJson()).toList(),
    };
  }
}

class Upload {
  num? id;
  String? fileOriginalName;
  String? fileName;
  num? userId;
  num? fileSize;
  String? extension;
  String? type;
  String? downloadUrl;

  Upload({
    this.id,
    this.fileOriginalName,
    this.fileName,
    this.userId,
    this.fileSize,
    this.extension,
    this.type,
    this.downloadUrl,
  });

  factory Upload.fromJson(Map<String, dynamic> json) {
    return Upload(
      id: json['id'],
      fileOriginalName: json['file_original_name'],
      fileName: json['file_name'],
      userId: json['user_id'],
      fileSize: json['file_size'],
      extension: json['extension'],
      type: json['type'],
      downloadUrl: json['download_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'file_original_name': fileOriginalName,
      'file_name': fileName,
      'user_id': userId,
      'file_size': fileSize,
      'extension': extension,
      'type': type,
      'download_url': downloadUrl,
    };
  }
}
