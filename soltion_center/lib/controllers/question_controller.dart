import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:soltion_center/services/auth_service.dart';
import 'package:soltion_center/services/question_service.dart';

import '../models/answer_model.dart';
import '../models/category_model.dart';
import '../models/question_model.dart';
import '../models/user_model.dart';

class QuestionController with ChangeNotifier {
  final questionSearchTextField = TextEditingController();

  final answerTitleController = TextEditingController();
  final answerDetailsController = TextEditingController();

  final questionTitleController = TextEditingController();
  final questionDetailsController = TextEditingController();

  final QuestionServices questionService = QuestionServices();
  final ScrollController scrollController = ScrollController();

  List<QuestionModel> _allQuestions = [];
  List<QuestionModel> findQuestionList = [];
  List<CategoryModel> selectedCategory = [];
  List<CategoryModel> newQuestionSelectedCategory = [];

  final String currentUserID = AuthService().getCurrentUser()!.uid;

  bool checkSelectedCategory(List<CategoryModel> list, CategoryModel category) {
    for (int i = 0; i < list.length; i++) {
      if (list[i].categoryId!.compareTo(category.categoryId!) == 0) {
        return true;
      }
    }
    return false;
  }

  void updateNewQuestionSelectedCategory(CategoryModel category) {
    if (newQuestionSelectedCategory.contains(category)) {
      newQuestionSelectedCategory.remove(category);
      notifyListeners();
    } else {
      newQuestionSelectedCategory.add(category);
      notifyListeners();
    }
  }


  void updateSelectedCategoryList(CategoryModel category) {
    if (checkSelectedCategory(selectedCategory, category)) {
      for (int i = 0; i < selectedCategory.length; i++) {
        if (selectedCategory[i].categoryId!.compareTo(category.categoryId!) == 0) {
          selectedCategory.removeAt(i);
          notifyListeners();
        }
      }
    } else {
      selectedCategory.add(category);
      notifyListeners();
    }
  }

  //
  Future<List<QuestionModel>> searchQuestionByInput(String input) async {
    List<QuestionModel> findQuestionList = [];
    List<QuestionModel> allQuestions =_allQuestions;

    if(allQuestions.isNotEmpty){


      for(QuestionModel question in allQuestions){
        //titile
        if (question.questionTitle!.toLowerCase().contains(input.toLowerCase())){
          findQuestionList.add(question);

          //subtitle
        }else if (question.questionDetails!.toLowerCase().contains(input.toLowerCase())){
          findQuestionList.add(question);
        }

      }
    }else {
      print('there is no question list');
    }

    findQuestionList.forEach((element) {
      print(element.questionTitle);
      print(element.questionDetails);
    });
    return findQuestionList;
  }


  // get all questions
  Future<List<QuestionModel>> getAllQuestions() async {
    _allQuestions = await questionService.getAllQuestions();
    return _allQuestions;
  }

   // get the users of the question
  Future<List<UserModel>> getQuestionUsers(String questionID) async {
    return await questionService.getQuestionUsers(questionID);
  }


//search question by categories (categories [])
   Future<List<QuestionModel>> searchQuestionsByCategory(List<CategoryModel> categories) async {
    return await questionService.searchQuestionsByCategory(categories);
   }

//update the answer counter
  Future<void> updateAnswerCounter(String qId, String answerID, int counter) async {
    return await questionService.updateAnswerCounter(qId, answerID, counter);
  }

//search question by categories (categories [], current User ID)
  Future<List<QuestionModel>> getQuestionsByCategoryForTheUser(List<CategoryModel> categories) async {

    if (categories.isEmpty) {
      return await getUserQuestions();
    }else {
      return await questionService.getQuestionsByCategoryForTheUser(categories, currentUserID);
    }
  }


// get user question (User id)
  Future<List<QuestionModel>> getUserQuestions() async {
    return await questionService.getUserQuestions(currentUserID);
  }

//Get Categories of Question
Future<List<CategoryModel>?> getAllCategoryOfQuestion(String questionID) async {
  return await questionService.getAllCategoryOfQuestion(questionID);
}

//Add question
  Future<void> addQuestion(QuestionModel question) async {
    return await questionService.addQuestion(question);
  }

  //update the user list of the question
  Future<void> updateQuestionUsers(String questionID, List<String>? userList) async {
    return await questionService.updateQuestionUsers(questionID, userList, currentUserID);
  }

//add answer to question (questionID)
  Future<void> addQuestionAnswer(QuestionModel question,AnswerModel answer,) async {

    return await questionService.addQuestionAnswer(question, answer);
  }

//get question Answers
  Future<List<AnswerModel>> getAllAnswerOfQuestion(String qId) async {

    return await questionService.getAllAnswerOfQuestion(qId);
  }

 ///delete
  Future<void> deleteQuestion(String questionId) async {
    return await questionService.deleteQuestion(questionId);
  }

//delete answer
  Future<void> deleteAnswerOfQuestion(String questionId, String answerId) async {
        return await questionService.deleteAnswerOfQuestion(questionId, answerId);
      }

//delete user from question  (userID)
  Future<void> deleteUserOfQuestion(String questionId) async {

    return await questionService.deleteUserOfQuestion(questionId, currentUserID);
  }

//delete category from question (categoryID)
  Future<void> deleteCategoryOfQuestion(String questionId, String categoryId) async {

    return await questionService.deleteCategoryOfQuestion(questionId, categoryId);
  }
}
