import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/controllers/localization_controller.dart';
import 'package:soltion_center/controllers/question_controller.dart';
import 'package:soltion_center/models/answer_model.dart';
import 'package:soltion_center/models/question_model.dart';
import 'package:soltion_center/models/user_model.dart';
import 'package:soltion_center/services/auth_service.dart';

import 'answer/add_answer_screen.dart';
import 'answer/answer_card_body.dart';
import 'question_card/widget/questionCategories.dart';
import 'question_card/widget/question_detils.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({Key? key, required this.question})
      : super(key: key);
  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    final questionProvider = Provider.of<QuestionController>(context);
    final theme = Theme.of(context);
    final lang = Provider.of<LocalizationController>(context).getLanguage();
    return Scaffold(
      backgroundColor: theme.colorScheme.background,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        bottom: false,
        child: FutureBuilder<List<AnswerModel>>(
          future: questionProvider.getAllAnswerOfQuestion(question.sId!),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  '${lang.error}: ${snapshot.error}',
                  style: theme.textTheme.bodyLarge,
                ),
              );
            } else if (!snapshot.hasData) {
              return Text(
                lang.loading!,
                style: theme.textTheme.bodyLarge,
              );
            } else if (snapshot.data!.isEmpty) {
              return CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: theme.colorScheme.surfaceVariant,
                    pinned: true,
                    snap: false,
                    floating: false,
                    expandedHeight: 100.0,
                    elevation: 4,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,

                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${question.questionTitle}',
                            style: theme
                                .textTheme
                                .titleMedium,
                          ),
                        ],
                      ),
                      //centerTitle: true,
                      //background: FlutterLogo(),
                    ),
                    actions: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          IconButton(
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                scrollable: true,
                                backgroundColor: theme.colorScheme.background,
                                title: Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.person_search_outlined,
                                        color: theme.colorScheme.onBackground,
                                      ),
                                      Text(
                                        lang.whoHasTheSameQuestion!,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FutureBuilder<List<UserModel>>(
                                      future: questionProvider
                                          .getQuestionUsers(question.sId!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data!.isNotEmpty) {
                                            return Column(
                                              children: [
                                                for (var user in snapshot.data!)
                                                  ListTile(
                                                    title: Text(
                                                      '${user.username}',
                                                      // 'Add user name',
                                                      style: theme.textTheme
                                                          .bodyMedium,
                                                    ),
                                                    subtitle: Text(
                                                      '${user.email}',
                                                      maxLines: 1,
                                                      style: theme.textTheme
                                                          .bodySmall,
                                                    ),
                                                    leading: Icon(
                                                      Icons
                                                          .account_circle_outlined,
                                                      color: theme.colorScheme
                                                          .onBackground,
                                                    ),
                                                  ),
                                              ],
                                            );
                                          } else {
                                            return Center(
                                              child: Text(
                                                lang.thereIsNoUser!,
                                                style: theme.textTheme
                                                    .bodyLarge,
                                              ),
                                            );
                                          }
                                        } else {
                                          return Center(
                                            child: Text(
                                              lang.loading!,
                                              style: theme.textTheme
                                                  .bodyLarge,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        style: TextButton.styleFrom(
                                          //padding: const EdgeInsets.all(16.0),
                                          backgroundColor:
                                          theme.colorScheme.primary,
                                          // shape: RoundedRectangleBorder(
                                          //   borderRadius: BorderRadius.circular(8.0),
                                          // ),
                                        ),
                                        onPressed: () async {
                                          //TODO add the question to the user
                                          await questionProvider
                                              .updateQuestionUsers(question.sId!,question.userList!);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          lang.addYourself!,
                                          style: theme.textTheme
                                              .bodyMedium!
                                              .copyWith(
                                              color: theme.colorScheme
                                                  .onPrimary),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                //actionsOverflowButtonSpacing: 4,

                                alignment: Alignment.center,
                              ),
                            ),
                            icon: Icon(
                              Icons.person_outline,
                              color: theme.colorScheme.onBackground,
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: CircleAvatar(
                              maxRadius: 7,
                              backgroundColor: theme.colorScheme.error,
                              child: Text(
                                '${question.userList!.length}',
                                style: theme.textTheme
                                    .overline!
                                    .copyWith(
                                    color: theme.colorScheme.onError),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: ColoredBox(
                      color: theme.colorScheme.surfaceVariant,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            QuestionCategoryBuilder(
                              question: question,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            QuestionDetails(
                              question: question,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 24,
                              ),
                              Text(
                                lang.thereIsNoAnswerYet!,
                                style: theme.textTheme.bodyLarge,
                              ),
                              const SizedBox(
                                height: 24,
                              ),
                              ElevatedButton(
                                style: TextButton.styleFrom(
                                  primary: theme.colorScheme.onPrimary,
                                  onSurface: theme.colorScheme.onBackground,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 38.0, vertical: 12),
                                  backgroundColor:
                                  theme.colorScheme.primary,
                                  // shape: RoundedRectangleBorder(
                                  //   borderRadius: BorderRadius.circular(8.0),
                                  // ),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => AddAnswerScreen(
                                        question: question,
                                      ),
                                    ),
                                  );
                                },
                                child: Text(
                                  lang.addAnswer!,
                                  style: theme.textTheme
                                      .bodyMedium!
                                      .copyWith(
                                      color: theme
                                          .colorScheme.onPrimary),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      childCount: 1,
                    ),
                  ),
                ],
              );
            } else {
              return CustomScrollView(
                physics: const ClampingScrollPhysics(),
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: theme.colorScheme.surfaceVariant,
                    pinned: true,
                    snap: false,
                    floating: false,
                    expandedHeight: 100.0,
                    elevation: 4,
                    flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,

                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            '${question.questionTitle}',
                            style:theme
                                .textTheme
                                .titleMedium,
                          ),
                        ],
                      ),
                      //centerTitle: true,
                      //background: FlutterLogo(),
                    ),
                    actions: [
                      Stack(
                        alignment: AlignmentDirectional.center,
                        children: [
                          IconButton(
                            onPressed: () => showDialog<String>(
                              context: context,
                              builder: (BuildContext context) => AlertDialog(
                                scrollable: true,
                                backgroundColor: theme.colorScheme.background,
                                title: Center(
                                  child: Column(
                                    children: [
                                      Icon(
                                        Icons.person_search_outlined,
                                        color: theme.colorScheme.onBackground,
                                      ),
                                      Text(
                                        lang.whoHasTheSameQuestion!,
                                        textAlign: TextAlign.center,
                                        style: theme.textTheme
                                            .headlineSmall,
                                      ),
                                    ],
                                  ),
                                ),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    FutureBuilder<List<UserModel>>(
                                      future: questionProvider
                                          .getQuestionUsers(question.sId!),
                                      builder: (context, snapshot) {
                                        if (snapshot.hasData) {
                                          if (snapshot.data!.isNotEmpty) {
                                            return Column(
                                              children: [
                                                for (var user in snapshot.data!)
                                                  ListTile(
                                                    title: Text(
                                                      '${user.username}',
                                                      // 'Add user name',
                                                      style: theme.textTheme
                                                          .bodyMedium,
                                                    ),
                                                    subtitle: Text(
                                                      '${user.email}',
                                                      maxLines: 1,
                                                      style: theme.textTheme
                                                          .bodySmall,
                                                    ),
                                                    leading: Icon(
                                                      Icons
                                                          .account_circle_outlined,
                                                      color: theme.colorScheme
                                                          .onBackground,
                                                    ),
                                                  ),
                                              ],
                                            );
                                          } else {
                                            return Center(
                                              child: Text(
                                                lang.thereIsNoUser!,
                                                style: theme.textTheme
                                                    .bodyLarge,
                                              ),
                                            );
                                          }
                                        } else {
                                          return Center(
                                            child: Text(
                                              lang.loading!,
                                              style: theme.textTheme
                                                  .bodyLarge,
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    const SizedBox(
                                      height: 8,
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: ElevatedButton(
                                        style: TextButton.styleFrom(
                                          primary:
                                          theme.colorScheme.onPrimary,
                                          onSurface:
                                          theme.colorScheme.onBackground,
                                          //padding: const EdgeInsets.all(16.0),
                                          backgroundColor:
                                          theme.colorScheme.primary,
                                          // shape: RoundedRectangleBorder(
                                          //   borderRadius: BorderRadius.circular(8.0),
                                          // ),
                                        ),
                                        onPressed: () async {
                                          //TODO add the question to the user
                                          await questionProvider
                                              .updateQuestionUsers(question.sId!,question.userList);
                                          Navigator.pop(context);
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          lang.addYourself!,
                                          style: theme.textTheme
                                              .bodyMedium!
                                              .copyWith(
                                              color: theme.colorScheme
                                                  .onPrimary),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),

                                //actionsOverflowButtonSpacing: 4,

                                alignment: Alignment.center,
                              ),
                            ),
                            icon: Icon(
                              Icons.person_outline,
                              color: theme.colorScheme.onBackground,
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: CircleAvatar(
                              maxRadius: 7,
                              backgroundColor: theme.colorScheme.error,
                              child: Text(
                                '${question.userList!.length}',
                                style: theme.textTheme
                                    .overline!
                                    .copyWith(
                                    color: theme.colorScheme.onError),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: ColoredBox(
                      color: theme.colorScheme.surfaceVariant,
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            QuestionCategoryBuilder(
                              question: question,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            QuestionDetails(
                              question: question,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                        final ln = snapshot.data!.length;
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(16, 16, 8, 0),
                          child: Column(
                            children: [
                              Card(
                                color: theme.colorScheme.surfaceVariant,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color:
                                        theme.colorScheme.surfaceVariant,
                                        borderRadius: const BorderRadius.only(
                                          topRight: Radius.circular(8),
                                          topLeft: Radius.circular(8),
                                        ),
                                      ),
                                      width: MediaQuery.of(context).size.width,
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                          left: 16,
                                          right: 16,
                                          top: 16,
                                          bottom: 16,
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.account_circle_outlined,
                                              color: theme
                                                  .colorScheme.onBackground,
                                              size: 36,
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            FutureBuilder<UserModel?>(
                                              future: AuthService().getUserInfo(snapshot.data![index].userId!),
                                              builder: (context, userSnapshot) {
                                                if (userSnapshot.hasData) {
                                                  return Column(
                                                    crossAxisAlignment:
                                                    CrossAxisAlignment
                                                        .start,
                                                    children: [
                                                      Text(
                                                        '${userSnapshot.data!.username}',
                                                        style: theme.textTheme
                                                            .bodyMedium,
                                                      ),
                                                      Text(
                                                        '${snapshot.data![index].updatedAt}',
                                                        style: theme.textTheme
                                                            .bodySmall,
                                                      )
                                                    ],
                                                  );
                                                } else {
                                                  return const SizedBox();
                                                }
                                              },
                                            ),
                                            const Spacer(),
                                            Container(
                                              width: 36,
                                              height: 36,
                                              decoration: BoxDecoration(
                                                color: theme
                                                    .colorScheme.background,
                                                borderRadius:
                                                BorderRadius.circular(8),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  '${snapshot.data![index].answerCounter}',
                                                  style: theme.textTheme
                                                      .titleMedium,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 24,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          16, 0, 16, 16),
                                      child: AnswerCardBody(
                                        answer: snapshot.data![0],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              if (index == ln - 1)
                                const SizedBox(
                                  height: 16,
                                ),
                              if (index == ln - 1)
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: TextButton.styleFrom(
                                      primary:
                                      theme.colorScheme.onPrimary,
                                      onSurface:
                                      theme.colorScheme.onBackground,
                                      //padding: const EdgeInsets.all(16.0),
                                      backgroundColor:
                                      theme.colorScheme.primary,
                                      // shape: RoundedRectangleBorder(
                                      //   borderRadius: BorderRadius.circular(8.0),
                                      // ),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddAnswerScreen(
                                            question: question,
                                          ),
                                        ),
                                      );
                                    },
                                    child: Text(
                                      lang.addAnswer!,
                                      style: theme.textTheme
                                          .bodyMedium!
                                          .copyWith(
                                          color: theme
                                              .colorScheme.onPrimary),
                                    ),
                                  ),
                                ),
                              if (index == ln - 1)
                                const SizedBox(
                                  height: 30,
                                ),
                            ],
                          ),
                        );
                      },
                      childCount: snapshot.data!.length,
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
