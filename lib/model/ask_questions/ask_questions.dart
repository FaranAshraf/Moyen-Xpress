class AskQuestionModel {
  String? question;
  int? productId;
  
  AskQuestionModel({
    required this.question,
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'question': question,
      'productId': productId,
    };
  }

  factory AskQuestionModel.fromJson(Map<String, dynamic> map) {
    return AskQuestionModel(
      question: map['question'] as String?,
      productId: map['productId'] as int?,
    );
  }
}
