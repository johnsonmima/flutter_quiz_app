class Question {
  late String _questionText;
  late bool _questionAnswer;

  Question(String question, bool answer) {
    _questionText = question;
    _questionAnswer = answer;
  }

  bool getAnswer() {
    return _questionAnswer;
  }

  String getQuestion() {
    return _questionText;
  }
}
