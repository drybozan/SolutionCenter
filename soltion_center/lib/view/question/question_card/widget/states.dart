import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soltion_center/models/question_model.dart';

class QuestionStateIcon extends StatelessWidget {
  const QuestionStateIcon({Key? key, required this.question}) : super(key: key);
  final QuestionModel question;
  final double size = 44;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
        height: size,
        width: size,
        decoration: BoxDecoration(
          color: theme.colorScheme.surfaceVariant,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(
                Icons.circle_outlined,
                color: stateCircleColor(theme),
                size: 35,
              ),
              stateIcon(theme),
              if (question.questionState == 'answered')
                Positioned(
                  right: 0,
                  top: 0,
                  child: Icon(
                    Icons.circle,
                    color: theme.colorScheme.error,
                    size: 15,
                  ),
                ),
            ],
          ),
        ));
  }

  Color stateCircleColor(ThemeData themeData) {
    switch (question.questionState) {
      case "not_solved":
        {
          return themeData.colorScheme.error!;
        }
        break;

      case "solved":
        {
          return themeData.colorScheme.primary!;
        }
        break;

      case "answered":
        {
          return themeData.colorScheme.secondary!;
        }
        break;

      default:
        {
          return themeData.colorScheme.error!;
        }
        break;
    }
  }

  Widget stateIcon(ThemeData themeData) {
    switch (question.questionState) {
      case "not_solved":
        {
          return Icon(
            Icons.priority_high,
            color: stateCircleColor(themeData),
            size: 22,
          );
        }
        break;

      case "solved":
        {
          return Icon(
            Icons.done,
            color: stateCircleColor(themeData),
            size: 22,
          );
        }
        break;

      case "answered":
        {
          return Icon(
            Icons.person_outline,
            color: stateCircleColor(themeData),
            size: 22,
          );
        }
        break;

      default:
        {
          return Icon(
            Icons.priority_high,
            color: stateCircleColor(themeData),
            size: 22,
          );
        }
        break;
    }
  }
}
