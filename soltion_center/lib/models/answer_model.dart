class AnswerModel {
  String? sId;
  String? createdAt;
  String? updatedAt;
  String? answerTitle;
  String? answerDescription;
  String? questionId;
  int? answerCounter;
  String? userId;

  AnswerModel({
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.answerTitle,
    this.answerDescription,
    this.questionId,
    this.answerCounter,
    this.userId,
  });

  AnswerModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    answerTitle = json['answer_title'];
    answerDescription = json['answer_description'];
    questionId = json['question_id'];
    answerCounter = json['answer_counter'];
    userId = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['answer_title'] = answerTitle;
    data['answer_description'] = answerDescription;
    data['question_id'] = questionId;
    data['answer_counter'] = answerCounter;
    data['user'] = userId;
    return data;
  }
}
