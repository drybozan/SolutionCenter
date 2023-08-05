class QuestionModel {
  String? sId;
  String? createdAt;
  String? updatedAt;
  String? questionTitle;
  String? questionDetails;
  List<String>? questionCategory;
  String? questionState;
  List<String>? userList;
  int? userCounter;

  QuestionModel({
    this.sId,
    this.createdAt,
    this.updatedAt,
    this.questionTitle,
    this.questionDetails,
    this.questionCategory,
    this.questionState,
    this.userList,
    this.userCounter,
  });

  QuestionModel.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    questionTitle = json['question_title'];
    questionDetails = json['question_details'];
    questionCategory = json['questionCategory'].cast<String>();
    questionState = json['question_state'];
    userList = json['user_list'].cast<String>();
    userCounter = json['userCounter'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['createdAt'] = createdAt ?? DateTime.now();
    data['updatedAt'] = updatedAt ?? DateTime.now();
    data['question_title'] = questionTitle;
    data['question_details'] = questionDetails;
    data['questionCategory'] = questionCategory ?? [];
    data['question_state'] = questionState ?? 'not_solved';
    data['user_list'] = userList ?? [];
    data['userCounter'] = userCounter ?? 0;
    return data;
  }
}
