import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

void main() => runApp(MaterialApp(
    home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.amber,
          title: const Text(
            'Quiz App',
            style: TextStyle(
              color: Colors.black,
            ),
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: QuizzMain(),
        ))));

class QuizzMain extends StatefulWidget {
  QuizzMain({Key? key}) : super(key: key);

  @override
  _QuizzMainState createState() => _QuizzMainState();
}

class _QuizzMainState extends State<QuizzMain> {
  int currentQuestion = 0;

  int correctAnserCount = 0;
  int wrongCounterCount = 0;
  QuizBrain quizBrain = QuizBrain();

  List<Widget> scoreKeeper = [];

  void nextQuestion() {
    if (currentQuestion < quizBrain.getQuestionCount()) {
      //currentQuestion = (currentQuestion + 1) % quizBrain.getQuestionCount();
      currentQuestion++;
    } else {
      Alert(
        context: context,
        type: AlertType.success,
        title: "Finished!",
        desc:
            "you got $correctAnserCount out of ${quizBrain.getQuestionCount() + 1}.",
        buttons: [
          DialogButton(
            child: const Text(
              "CANCEL",
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            onPressed: () {
              setState(() {
                currentQuestion = 0;
                correctAnserCount = 0;
                wrongCounterCount = 0;
              });
              Navigator.pop(context);
            },
            width: 120,
          )
        ],
      ).show();
    }
  }

  void checkAnswers(bool answer) {
    if (quizBrain.getQuestionAnswer(currentQuestion) == answer) {
      correctAnserCount++;
    } else {
      wrongCounterCount++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Expanded(
                flex: 3,
                child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    quizBrain.getQuestionText(currentQuestion),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      //textAlign: TextAlign.center,
                    ),
                  ),
                )),
            Expanded(
              flex: 1,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.green)),
                      onPressed: () {
                        setState(() {
                          // check answer
                          checkAnswers(true);
                          nextQuestion();
                        });
                      },
                      child: const Center(
                        child:
                            Text('True', style: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: TextButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.red)),
                      onPressed: () {
                        setState(() {
                          // check answer
                          checkAnswers(false);
                          // next question
                          nextQuestion();
                        });
                      },
                      child: const Center(
                        child: Text(
                          'False',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  // ignore: todo
                  //TODO: add row here as your score keeper
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('$correctAnserCount'),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            const Icon(
                              Icons.cancel,
                              color: Colors.red,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text('$wrongCounterCount'),
                          ],
                        )
                      ])
                ],
              ),
            ),
          ],
        ));
  }
}
