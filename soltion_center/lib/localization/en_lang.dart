import 'package:soltion_center/controllers/localization_controller.dart';

import 'Localization.dart';

class ENLocalization implements Localization {
  @override
  String? appDescription = 'Solution Center application is a mobile application designed as a solidarity and information sharing platform among university students by targeting them.  University life presents many opportunities and experiences for students, as well as a variety of challenges and problems. Thanks to this application, which aims to provide a connection point between students who want to make university life easier and help each other, students can find faster and more effective solutions to the problems encountered.';


  @override
  String? appTitle = 'Solution Center';

  @override
  String? email = 'Email';

  @override
  LangDirection langDirection = LangDirection.left;

  @override
  Map<String, String>? languageTitles = {
    'en': 'English',
    'tr': 'Turkish'
  };
  @override
  String? logOut = 'Log Out';

  @override
  String? login = 'Log In';

  @override
  String? loginText = 'Do you have an account';

  @override
  String? password = 'Password';

  @override
  String? register = 'Register';

  @override
  String? registerText = 'Already have an account?';

  @override
  String? userName = 'User Name';

  @override
  String? userNotFound = 'User not found';

  @override
  String? alreadyHaveAnAccount = 'Already have an account?';
  
  @override
  String? onlyLettersAndNoSpaces = 'Please only use letters and no spaces';

  @override
  String? validSchoolEmail = 'Please enter a valid school email';

  @override
  String? passwordRules = 'Password must have at least 8 characters, 1 number, 1 capital and 1 small letter';

  @override
  String? accept = 'Accept';

  @override
  String? dark = 'Dark';

  @override
  String? done = 'Done';

  @override
  String? language = 'Language';

  @override
  String? light = 'Light';

  @override
  String? system = 'System';

  @override
  String? theme ='Theme';

  @override
  String? languageCode = 'English';

  @override
  String? languageDialogDescription = 'Press the desired language button to change the app\'s language';

  @override
  String? languageDialogDoneButtonText = 'Done';

  @override
  String? noInternetWarningDialogText =
      'No internet connection detected at this time. The application needs an internet connection to constantly update your data data. Please reconnect to continue';

  @override
  String? largeWebViewError =
      "This device is not supported. Please play the application only on your mobile browser.";

  // App Messages
  @override
  String? alreadyExistMessage = 'The account already exists';

  @override
  String? loginMessage = 'You have successfully entered';

  @override
  String? registerMessage = 'registration successful';

  @override
  String? wrongPasswordMessage =
      'You have entered the wrong information, please check again';

  @override
  String? signOutMessage = 'Signed out successfully';

  @override
  String? signOutErrorMessage = 'Error in signing out';

  // Logout Dialog
  @override
  String? logoutDialogDescriptionText =
      'Are you sure that you want to log out?';

  @override
  String? logoutDialogCancelButtonText = 'Cancel';

  @override
  String? logoutDialogLogoutButtonText = 'Log out';

  @override
  String? profile = 'Profile';

  @override
  String? enterYourEmail = 'Enter Your Email';

  @override
  String? enterYourNameAndSurname = 'Enter Your Name & Surname';

  @override
  String? enterYourPassword = 'Enter Your Password';

  @override
  String? nameSurname = 'Name & Surname';

  @override
  String? createNewAccount = 'Create a new account?';

  @override
  String? profileInfo = 'Profile Info';

  @override
  String? categories = 'Categories';

  @override
  String? category = 'Category';

  @override
  String? history = ' Question History ';
  
  // Homepage
  @override
  String? homeTitle = 'Home';
  
  @override
  String? welcomeMessage = 'Welcome ';
  
  @override
  String? writeIssue = 'Write issue, please.';
  
  @override
  String? search = 'Search';

  @override
  String? homePageSubTitle = 'Please feel free to search for the issue that you have, if you did not find you can create a new issue';

  @override
  String? homePageTitle = 'Please tell us what is your problem';

  @override
  String? searchForCategory = 'Search for the category';

  @override
  String? searchForCategoryDes = 'Please to add category you need to search here';

  @override
  String? yourCategories = 'Your Categories';

  @override
  String? loading = 'Loading.....';

  @override
  String? addCategory= ' Add Category';

  @override
  String? error = 'Error!';

  @override
  String? noDataRecorded = 'No Data recorded';

  @override
  String? addCategoryToQuestion = 'Add Category to the question';

  @override
  String? addDetailsToQuestion = 'Add details to the Question';

  @override
  String? addNewQuestion = 'Add new question';

  @override
  String? addSolutionToQuestion = 'Add a solution to the question';

  @override
  String? question = 'Question';

  @override
  String? questionHistory = 'Questions History';

  @override
  String? questions = 'Questions';

  @override
  String? addAnswer = 'Add Answer';

  @override
  String? addNewAnswer = 'Add New Answer';

  @override
  String? addYourself = 'Add yourself';

  @override
  String? answer = 'Answer';

  @override
  String? answerInformation = 'Answer Information';

  @override
  String? answers = 'Answers';

  @override
  String? cancel = 'Cancel';

  @override
  String? details = 'Details';

  @override
  String? notFind = 'Not Find';

  @override
  String? notWorking = 'Not working';

  @override
  String? pleaseEnterText = 'Please Enter Text';

  @override
  String? pleaseEnterYourAnswerDescription = 'Please Enter Your Answer Details';

  @override
  String? pleaseEnterYourAnswerTitle = 'Please Enter Your Answer Title';

  @override
  String? pleaseEnterYourQuestionDetails = ' Please Enter your Question Details';

  @override
  String? pleaseEnterYourQuestionTitle = 'Please Enter Your Question Title';

  @override
  String? pleaseFillTheFields = 'Please fill the fields';

  @override
  String? questionInformation = 'Question Information';

  @override
  String? save ='Save';

  @override
  String? selectCategory = 'Select Category';

  @override
  String? selectCategoryDescription ='Please select the categories that can be useful for the question';

  @override
  String? thereIsNoAnswerYet = 'There is no answer Yet';

  @override
  String? thereIsNoUser = 'There is no User';

  @override
  String? thereIsNothingFounded = 'There is Nothing Founded';

  @override
  String? title = 'Title';

  @override
  String? vote = 'Vote';

  @override
  String? voteForTheAnswer = 'Vote For The answer';

  @override
  String? voteForTheAnswerDescription = 'If this answer is working please vote for working';

  @override
  String? whoHasTheSameQuestion = 'Who has the same question';

  @override
  String? working = 'Working';
  
}
