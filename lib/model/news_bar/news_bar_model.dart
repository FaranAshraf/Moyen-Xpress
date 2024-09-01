
class SuccessContents {
  String? newsBarActivation;
  String? newsBarText;

  SuccessContents({this.newsBarActivation, this.newsBarText});

  SuccessContents.fromJson(Map<String, dynamic> json) {
    newsBarActivation = json['news_bar_activation'];
    newsBarText = json['news_bar_text'];
  }

  Map<String, dynamic> toJson() {
    // ignore: prefer_collection_literals
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['news_bar_activation'] = newsBarActivation;
    data['news_bar_text'] = newsBarText;
    return data;
  }
}
