import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/models/answer_model.dart';
import 'package:soltion_center/models/category_model.dart';
import 'package:soltion_center/models/question_model.dart';
import 'package:soltion_center/services/question_service.dart';

class ProfileModel {
  String? name;
  IconData? icon;
  String? route;
  Function? onPressed;

  ProfileModel({ this.name,  this.icon,  this.route, this.onPressed});


  
  List<ProfileModel> getProfileList(BuildContext context){
    final lang = Provider.of<LocalizationController>(context, listen: true)
        .getLanguage();

    return [
      ProfileModel(name: lang.profileInfo!, icon: Icons.person_outline, route: '/Profile/Info',onPressed: () async{
         QuestionServices service = QuestionServices();
        // service.addQuestion(QuestionModel(
        //   createdAt: '${DateTime.now()}',
        //   updatedAt: '${DateTime.now()}',
        //   questionState: 'not_solved',
        //   userCounter: 0,
        //   userList: [
        //    'IDaAHS8iC4MCnPMUhDrPO5KuRE83',
        //   ],
        //   questionCategory: ['software'],
        //   questionTitle:'Test Titile',
        //   questionDetails: 'Test Details',
        // ));

         //List<QuestionModel> test =  await service.getAllQuestions();

         // service.addQuestionAnswer(test.first,AnswerModel(
         //   answerCounter: 0,
         //   userId: 'IDaAHS8iC4MCnPMUhDrPO5KuRE83',
         //   createdAt: '${DateTime.now()}',
         //   questionId: test.first.sId,
         //   updatedAt: '${DateTime.now()}',
         //   answerDescription:'Answer test',
         //   answerTitle:
         //   'Answer test test',
         // ),);

        //service.updateAnswerCounter(test.first.sId!,'kEEeWYand6ZJiGQDWAQT', -1);

      }),

      ProfileModel(name: lang.history!, icon: Icons.history_outlined, route: '/Profile/History',onPressed: (){
        Navigator.pushNamed(context, '/Profile/History');
      }),
      ProfileModel(name: lang.categories!, icon: Icons.list, route: '/Profile/Categories',onPressed: (){
        Navigator.pushNamed(context, '/Profile/Category');
      }),
      ProfileModel(name: lang.language!, icon: Icons.translate_outlined, route: '/Profile/Language',onPressed: (){
        Provider.of<LocalizationController>(context, listen: false).getLanguageDialog(context);
      }),
    ];
  }
}