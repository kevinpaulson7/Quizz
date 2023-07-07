import 'package:flutter/material.dart';
import 'quizbrain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuizBrain quizbrain = QuizBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
        home: Scaffold(
      backgroundColor: Colors.grey[900],
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0), child: quizpage()),
      ),
    ));
  }
}

class quizpage extends StatefulWidget {
  const quizpage({Key? key}) : super(key: key);
  @override
  State<quizpage> createState() => _quizpageState();
}

class _quizpageState extends State<quizpage> {
  int count = 0;
  List<Icon> scoreKeeper = [];
  void checkans(bool b) {
    setState(() {
      if (quizbrain.finished() == true) {
        Alert(
          context: context,
          title: "Congratulation",
          desc: "You have Scored $count points.",

        )
            .show();
        scoreKeeper.clear();
        quizbrain.resetquestionnumber();
        count=0;
      } else {
        if (b == quizbrain.getQuestionAnswer(quizbrain.questionnumber())) {
          count += 1;
          scoreKeeper.add(
            Icon(
              Icons.check,
              color: Colors.green,
            ),
          );
        } else {
          scoreKeeper.add(
            Icon(
              Icons.close,
              color: Colors.red,
            ),
          );
        }
      }
    });

  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizbrain.getQuestionText(quizbrain.questionnumber()),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 25.0,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              onPressed: () {
                setState(() {
                  checkans(true);
                  quizbrain.nextquestion(context, count);
                });
                print("true");
              },
              child: Text("True"),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () {
                setState(() {
                  checkans(false);
                  quizbrain.nextquestion(context, count);
                });
                print("false");
              },
              child: Text("False"),
            ),
          ),
        ),
        Row(
          children: scoreKeeper,
        )
      ],
    );
  }
}
