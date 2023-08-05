// ignore: file_names
import 'package:soltion_center/controllers/localization_controller.dart';

abstract class Localization {
  late LangDirection langDirection;

  // App name
  late String? appTitle;
  late String? appDescription;

  // App Language Titles
  late Map<String, String>? languageTitles;


  //Auth
  late String? login;
  late String? register;
  late String? logOut;
  late String? email;
  late String? userName;
  late String? password;
  late String? registerText;
  late String? loginText;
  late String? userNotFound;
  late String? profile;
  late String? alreadyHaveAnAccount;

  //Validation messages
  late String? onlyLettersAndNoSpaces;
  late String? validSchoolEmail;
  late String? passwordRules;

  //buttons
  late String? accept;
  late String? theme;
  late String? system;
  late String? light;
  late String? dark;
  late String? done;

  //lang
  late String? language;
  late String? languageCode;


  // App Language Dialog

  late String? languageDialogDescription;
  late String? languageDialogDoneButtonText;

  // Internet Dialog
  late String? largeWebViewError;
  late String? noInternetWarningDialogText;

  // App Messages
  late String? loginMessage;
  late String? registerMessage;
  late String? alreadyExistMessage;
  late String? wrongPasswordMessage;
  late String? signOutMessage;
  late String? signOutErrorMessage;
  late String? createNewAccount;

  // Logout Dialog
  late String? logoutDialogDescriptionText;
  late String? logoutDialogCancelButtonText;
  late String? logoutDialogLogoutButtonText;


  //Auth
  late String? nameSurname;
  late String? enterYourPassword;
  late String? enterYourEmail;
  late String? enterYourNameAndSurname;

  late String? profileInfo;
  late String? history;
  late String? categories;
  late String? yourCategories;
  late String? category;
  late String? addCategory;
  late String? searchForCategory;
  late String? searchForCategoryDes;
  late String? selectCategory;
  late String? selectCategoryDescription; // 'Please select the categories that can be useful for the question'

  //Homepage
  late String? homeTitle;
  late String? welcomeMessage;
  late String? writeIssue;
  late String? search;

  late String? homePageTitle;
  late String? homePageSubTitle;

  late String? loading;
  late String? error;
  late String? noDataRecorded;

  late String? question;
  late String? questions;
  late String? addNewQuestion;
  late String? addCategoryToQuestion;
  late String? addDetailsToQuestion;
  late String? addSolutionToQuestion;
  late String? questionHistory;
  late String? details;
  late String? questionInformation;

  late String? pleaseEnterYourQuestionTitle;
  late String? pleaseEnterText;
  late String? pleaseEnterYourQuestionDetails;
  late String? title;
  late String? cancel;
  late String? save;

  late String? voteForTheAnswer; //'Vote for the  answer'
  late String? voteForTheAnswerDescription; //'If this answer is working please vote for working and if it is not wokring vote'
  late String? working;
  late String? notWorking;
  late String? vote;

  late String? addNewAnswer;
  late String? answer;
  late String? answers;
  late String? answerInformation;
  late String? pleaseEnterYourAnswerTitle;
  late String? addAnswer;
  late String? pleaseEnterYourAnswerDescription;
  late String? thereIsNoAnswerYet; //"there is no answers yet"

  late String? pleaseFillTheFields; //'Please fill the fields'
  late String? whoHasTheSameQuestion; //'Who has the same question'
  late String? thereIsNoUser; //"There is no users"
  late String? addYourself; //'Add yourself'
  late String? notFind;
  late String? thereIsNothingFounded;//There is nothing founded'



}
