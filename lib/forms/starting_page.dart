import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/forms/counter.dart';
import 'package:flutter_quiz_app/forms/question_form.dart';
import 'package:flutter_quiz_app/questions_temp/my_questions.dart';

class StartQuize extends StatefulWidget {
  const StartQuize({Key? key}) : super(key: key);
  static ValueNotifier nextQ = ValueNotifier(0);
  static int numberOfQuestions = 0;
  @override
  State<StartQuize> createState() => _StartQuizeState();
}

class _StartQuizeState extends State<StartQuize> {
  Random randomNumber = Random();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const QuestionForm(),
              ),
            );
            CountDown.timer = Timer.periodic(
              const Duration(seconds: 1),
              (_) {
                setState(
                  () {
                    if (CountDown.newSecondsVal.value > 0) {
                      CountDown.newSecondsVal.value--;
                    } else if (CountDown.newSecondsVal.value == 0) {
                      StartQuize.nextQ.value =
                           randomNumber.nextInt(myQuestions.length - 1);
                      CountDown.newSecondsVal.value = 10;
                      if (StartQuize.numberOfQuestions == 20) {
                        StartQuize.numberOfQuestions = 0;
                      }else {
                        StartQuize.numberOfQuestions++;
                        }
                    } 
                    else {
                      CountDown.newSecondsVal.value = 10;
                    }
                  },
                );
              },
            );
          },
          child: const Text('Start Quize'),
        ),
      ),
    );
  }
}
