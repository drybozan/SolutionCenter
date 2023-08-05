import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:soltion_center/models/answer_model.dart';
import 'package:soltion_center/models/category_model.dart';
import 'package:soltion_center/models/question_model.dart';
import 'package:soltion_center/models/user_model.dart';
import 'package:soltion_center/services/category_service.dart';

import 'auth_service.dart';

class QuestionServices {
  final _db = FirebaseFirestore.instance;

  ///get
//get all questions
  Future<List<QuestionModel>> getAllQuestions() async {
    List<QuestionModel> questionList = [];
    // Call the user's CollectionReference to add a new user
    await _db.collection("questions").get().then((event) {
      for (var doc in event.docs) {
        questionList.add(QuestionModel.fromJson(doc.data()));
      }
    });
    return questionList;
  }


  // get the users of the question
  Future<List<UserModel>> getQuestionUsers(String questionID) async {
    List<UserModel> list = [];
    await _db.collection("questions").doc(questionID).get().then((event) async {
      QuestionModel question = QuestionModel.fromJson(event.data()!);
      for (var userId in question.userList!) {
        UserModel? user = await AuthService().getUserInfo(userId);
        list.add(user!);
      }
    });
    return list;
  }

  ///search question by title & subTitile (String)

  //search question by categories (categories [])
  Future<List<QuestionModel>> searchQuestionsByCategory(
      List<CategoryModel> categories) async {
    List<QuestionModel> questionList = [];
    List<String> categoryIDs = [];

    // Add the categories id to the list
    for (CategoryModel cat in categories) {
      categoryIDs.add(cat.categoryId!);
    }

    //get the question Categories from thier id
    await _db
        .collection("questions")
        .where(
          "questionCategory",
          arrayContainsAny: categoryIDs,
        )
        .get()
        .then((event) {
      for (var doc in event.docs) {
        questionList.add(QuestionModel.fromJson(doc.data()));
      }
    });

    return questionList;
  }

  //update the answer counter
  Future<void> updateAnswerCounter(
      String qId, String answerID, int counter) async {
    AnswerModel? answerData;

    var connection = _db
        .collection("questions")
        .doc(qId)
        .collection("answers")
        .doc(answerID);

    await connection.get().then((value) {
      answerData = AnswerModel.fromJson(value.data()!);
    });

    if (answerData != null) {
      /// answerData!.answerCounter! <= -5 ==> delete (not answered)
      ///-5 :: 20                          ==> answered
      /// 20 >=                            ==> solved

      if (answerData!.answerCounter! <= -5) {
        connection.delete();
        // if all answers are deleted (no answer) status = {not solved}
        var answerList = await getAllAnswerOfQuestion(qId);
        if (answerList.isEmpty) {
          await _db
              .collection("questions")
              .doc(qId)
              .update({'question_state': 'not_solved'});
        }
      } else if (answerData!.answerCounter! > -5 &&
          answerData!.answerCounter! < 20) {
        await _db
            .collection("questions")
            .doc(qId)
            .update({'question_state': 'answered'});
        connection
            .update({'answer_counter': answerData!.answerCounter! + counter});
      } else if (answerData!.answerCounter! >= 20) {
        await _db
            .collection("questions")
            .doc(qId)
            .update({'question_state': 'solved'});
        connection
            .update({'answer_counter': answerData!.answerCounter! + counter});
      }

      // connection.update({'answer_counter': answerData!.answerCounter! + counter});
    }
  }

//search question by categories (categories [], current User ID)
  Future<List<QuestionModel>> getQuestionsByCategoryForTheUser(
      List<CategoryModel> categories, String userID) async {
    List<QuestionModel> questionList = [];
    List<String> categoryIDs = [];

    // Add the categories id to the list
    for (CategoryModel cat in categories) {
      categoryIDs.add(cat.categoryId!);
    }

    //get the question Categories from thier id
    await _db
        .collection("questions")
        .where(
          "questionCategory",
          arrayContainsAny: categoryIDs,
        )
        .get()
        .then((event) {
      for (var doc in event.docs) {
        questionList.add(QuestionModel.fromJson(doc.data()));
      }
    });

    for (var question in questionList) {
      if (!question.userList!.contains(userID)) {
        questionList.remove(question);
      }
    }
    return questionList;
  }

// get user question (User id)
  Future<List<QuestionModel>> getUserQuestions(String uId) async {
    List<QuestionModel> questionList = [];
    // Call the user's CollectionReference to add a new user
    await _db
        .collection("questions")
        .where("user_list", arrayContains: uId)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        questionList.add(QuestionModel.fromJson(doc.data()));
      }
    });
    return questionList;
  }

  //Get Categories of Question
  Future<List<CategoryModel>?> getAllCategoryOfQuestion(
      String questionID) async {
    List<CategoryModel>? categoryList = [];
    QuestionModel? question;
    // Call the user's CollectionReference to add a new user
    await _db.collection("questions").doc(questionID).get().then((event) {
      question = QuestionModel.fromJson(event.data()!);
    });

    if (question != null) {
      CategoryService categoryService = CategoryService();
      categoryList =
          await categoryService.getCategoryList(question!.questionCategory!);
    }
    return categoryList;
  }

// get question answers (QuestionID)

  ///add
//Add question
  Future<void> addQuestion(QuestionModel question) async {
    var connection = _db.collection("questions");
    await connection.add(question.toJson()).then((DocumentReference doc) async {
      // update the question id from the random ID that assigned bt firebase
      connection.doc(doc.id).update({'_id': doc.id});
    });
  }

  // add user to question (USer ID)
  //update the user list of the question
  Future<void> updateQuestionUsers(
      String questionID, List<String>? userList, String? currentUserID) async {
    if (currentUserID != null) {
      if (!userList!.contains(currentUserID)) {
        userList.add(currentUserID);
      }
    }
    var connection = _db.collection("questions");
    connection
        .doc(questionID)
        .update({'user_list': FieldValue.arrayUnion(userList!)});
  }

//add answer to question (questionID)
  Future<void> addQuestionAnswer(
    QuestionModel question,
    AnswerModel answer,
  ) async {
    var questionConnection = _db.collection("questions");
    var answerConnection =
        _db.collection("questions").doc(question.sId!).collection("answers");

    await answerConnection
        .add(answer.toJson())
        .then((DocumentReference doc) async {
      answerConnection.doc(doc.id).update({'_id': doc.id});
      await questionConnection
          .doc(question.sId!)
          .update({'question_state': 'answered'});

      //update the question users
      await questionConnection
          .doc(question.sId!)
          .update({'userCounter': question.userList!.length});
      await updateQuestionUsers(
          question.sId!, question.userList, AuthService().getUser()!.uid);
    });
  }

//vote for answer (1/-1) (answerID)
//update question status (questionID)
//get question Answers
  Future<List<AnswerModel>> getAllAnswerOfQuestion(String qId) async {
    List<AnswerModel> list = [];
    // Call the user's CollectionReference to add a new user
    await _db
        .collection("questions")
        .doc(qId)
        .collection("answers")
        .orderBy("answer_counter", descending: true)
        .get()
        .then((event) {
      for (var doc in event.docs) {
        list.add(AnswerModel.fromJson(doc.data()));
      }
    }).catchError((error) => print("Failed to add user: $error"));

    return list;
  }

  ///delete
  Future<void> deleteQuestion(String questionId) async {
    final questionDocRef = _db.collection("questions").doc(questionId);
    final questionSnapshot = await questionDocRef.get();

    if (questionSnapshot.exists) {
      // Eğer question varsa, silme işlemini gerçekleştir
      await questionDocRef.delete();
      print("Deleted question succesfully");
    } else {
      // Eğer question yoksa, hata mesajı ver
      print("The data to be deleted was not found");
    }
  }

//delete answer
  Future<void> deleteAnswerOfQuestion(
      String questionId, String answerId) async {
    final questionDocRef = _db
        .collection("questions")
        .doc(questionId)
        .collection("answers")
        .doc(answerId);
    final answerSnapshot = await questionDocRef.get();

    if (answerSnapshot.exists) {
      // Eğer data varsa, silme işlemini gerçekleştir
      await questionDocRef.delete();
      print("Deleted answer succesfully");
    } else {
      // Eğer data yoksa, hata mesajı ver
      print("The data to be deleted was not found");
    }
  }

//delete user from question  (userID)
  Future<void> deleteUserOfQuestion(String questionId, String userId) async {
    final questionDocRef = _db.collection("questions").doc(questionId);
    // Dizi elemanını sil
    await questionDocRef.update({
      'user_list': FieldValue.arrayRemove([userId])
    });
  }
  
//delete category from question (categoryID)
  Future<void> deleteCategoryOfQuestion(String questionId, String categoryId) async {
    final questionDocRef = _db.collection("questions").doc(questionId);
    // Dizi elemanını sil
    await questionDocRef.update({
      'questionCategory': FieldValue.arrayRemove([categoryId])
    });
  }
}
