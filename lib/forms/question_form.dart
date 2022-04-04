import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_quiz_app/forms/counter.dart';
import 'package:flutter_quiz_app/forms/starting_page.dart';
import 'package:flutter_quiz_app/questions_temp/my_questions.dart';
import 'package:flutter_quiz_app/questions_temp/question.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionForm extends StatefulWidget {
  const QuestionForm({Key? key}) : super(key: key);

  @override
  State<QuestionForm> createState() => _QuestionFormState();
}

class _QuestionFormState extends State<QuestionForm> {
  int _counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff5ba0d7),
      body: SafeArea(
        child: ValueListenableBuilder(
          builder: (context, value, _) {
            return  question(
                myQuestions[StartQuize.nextQ.value],
            );
          },
          valueListenable: StartQuize.nextQ,
        ),
      ),
    );
  }

  Widget question(Quesition quesition) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Container(
          height: 350,
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xff5ba0d7),
                Color(0xff7ed2ee),
              ],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned(
                top: 5,
                left: MediaQuery.of(context).size.width / (20),
                child: Container(
                  margin: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                      color: const Color(0xffffacaf),
                      borderRadius: BorderRadius.circular(10)),
                  child: playerPerformance(),
                ),
              ),
              Positioned(
                left: (MediaQuery.of(context).size.width / 2) - 100,
                top: (MediaQuery.of(context).size.height / 2) - 200,
                child: questionCounter(),
              ),
            ],
          ),
        ),
        Positioned(
          right: 5,
          bottom: MediaQuery.of(context).size.height / 20,
          child: questionBody(quesition),
        ),
      ],
    );
  }

  Widget playerPerformance() {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: const Color(0xffffacaf),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'your score : $_counter',
            style: GoogleFonts.adamina(
              textStyle: const TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width / 10,
        ),
        Container(
          padding: const EdgeInsets.all(3),
          decoration: BoxDecoration(
            color: const Color(0xffffacaf),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'Questions : ${StartQuize.numberOfQuestions}/20',
            style: GoogleFonts.adamina(
              textStyle: const TextStyle(fontSize: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget questionBody(Quesition quesition) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      //mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          '${quesition.quesition} : ',
          style: GoogleFonts.akayaTelivigala(
            textStyle: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              option(0, quesition.rightAnswer, quesition.options),
              const SizedBox(
                height: 10,
              ),
              option(1, quesition.rightAnswer, quesition.options),
              const SizedBox(
                height: 10,
              ),
              option(2, quesition.rightAnswer, quesition.options),
              const SizedBox(
                height: 10,
              ),
              option(3, quesition.rightAnswer, quesition.options),
            ],
          ),
        
      ],
    );
  }

  Widget questionCounter() {
    return ValueListenableBuilder(
      valueListenable: CountDown.newSecondsVal,
      builder: (context, value, _) {
        return SizedBox(
          height: 200,
          width: 200,
          child: Stack(
            fit: StackFit.expand,
            children: [
              CircularProgressIndicator(
                value: CountDown.newSecondsVal.value / CountDown.maxSeconds,
                valueColor: const AlwaysStoppedAnimation(Color(0xffffacaf)),
                strokeWidth: 12,
                backgroundColor: Colors.white,
              ),
              Center(
                child: Text(
                  '$value',
                  style: GoogleFonts.castoro(
                    textStyle: const TextStyle(
                      fontSize: 60,
                      color: Color(0xffdcb7c9),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget option(int optionNumber, int correctAnswer, List<int> options) {
    final int optionValue = options[optionNumber];
    return ElevatedButton(
      onPressed: () {
        setState(
          () {
            if (optionValue == correctAnswer) {
              _counter++;
            }
            StartQuize.numberOfQuestions++;
            nextQuestion();
            CountDown.newSecondsVal.value = 10;
            if (StartQuize.numberOfQuestions == 20) {
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (BuildContext ctx) {
                  return _counter == 20
                      ? theAlertDialog('great job', 'play again')
                      : _counter < 20 && _counter >= 15
                          ? theAlertDialog('good job', 'try again')
                          : _counter < 15 && _counter >= 10
                              ? theAlertDialog('nice job', 'try again')
                              : _counter < 10 && _counter >= 5
                                  ? theAlertDialog('oh sorry', 'try again')
                                  : theAlertDialog("that's bad", 'try again');
                },
              );
            }
          },
        );
      },
      style: ButtonStyle(
        fixedSize: MaterialStateProperty.all(
          const Size.fromWidth(400),
        ),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        shape: MaterialStateProperty.all(
          const RoundedRectangleBorder(
            side: BorderSide(
              width: 3,
              color: Colors.black,
            ),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 8.0,
          bottom: 8.0,
        ),
        child: Text('$optionValue',
            style: GoogleFonts.akayaTelivigala(
              textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            )),
      ),
    );
  }

  Widget theAlertDialog(String playerState, String playerNextOption) {
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      backgroundColor: const Color(0xff5ba0d7),
      title: Text(
        playerState,
      ),
      content: Container(
        height: 150,
        width: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          children: [
            Text(
              'your scoare : $_counter over 20',
              style: GoogleFonts.akayaTelivigala(
                textStyle: const TextStyle(fontSize: 26),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all(const Color(0xffffacaf))),
              onPressed: () {
                setState(
                  () {
                    _counter = 0;
                    StartQuize.numberOfQuestions = 0;
                    CountDown.newSecondsVal.value = 10;
                    Navigator.of(context).pop();
                  },
                );
              },
              child: Text(
                playerNextOption,
                style: GoogleFonts.akayaTelivigala(
                  textStyle: const TextStyle(fontSize: 26),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  nextQuestion() {
    Random randomNumber = Random();
    StartQuize.nextQ.value = randomNumber.nextInt(myQuestions.length - 1);

    return StartQuize.nextQ.value;
  }
}
