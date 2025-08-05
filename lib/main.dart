import 'package:flutter/material.dart';
import 'questions.dart';

void main() => runApp(MathQuizApp());

class MathQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Math Quiz',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.calculate, size: 60, color: Colors.teal[400]),
            SizedBox(height: 20),
            Text(
              "Math Quiz",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MathQuizPage()),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal[400],
                padding: EdgeInsets.symmetric(horizontal: 36, vertical: 14),
              ),
              child: Text("Start Quiz", style: TextStyle(fontSize: 16)),
            ),
          ],
        ),
      ),
    );
  }
}

class MathQuizPage extends StatefulWidget {
  @override
  _MathQuizPageState createState() => _MathQuizPageState();
}

class _MathQuizPageState extends State<MathQuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;

  void checkAnswer(String selectedAnswer) {
    bool isCorrect =
        selectedAnswer == mathQuizQuestions[currentQuestionIndex].answer;
    setState(() {
      if (isCorrect) score++;
      if (currentQuestionIndex < mathQuizQuestions.length - 1) {
        currentQuestionIndex++;
      } else {
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text("Quiz Complete!"),
            content: Text("Score: $score/${mathQuizQuestions.length}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    currentQuestionIndex = 0;
                    score = 0;
                  });
                },
                child: Text("Restart"),
              ),
            ],
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = mathQuizQuestions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text("Question ${currentQuestionIndex + 1}/${mathQuizQuestions.length}"),
        backgroundColor: Colors.white,
        foregroundColor: Colors.teal[700],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (currentQuestionIndex + 1) / mathQuizQuestions.length,
              backgroundColor: Colors.teal[50],
              color: Colors.teal[400],
            ),
            SizedBox(height: 24),
            Text(
              currentQuestion.question,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 32),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ...currentQuestion.options.map((option) => Padding(
                        padding: EdgeInsets.only(bottom: 12),
                        child: SizedBox(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () => checkAnswer(option),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.teal[700],
                              padding: EdgeInsets.symmetric(vertical: 12),
                              side: BorderSide(color: Colors.teal.shade200), // ✅ Fixed
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(option),
                          ),
                        ),
                      )),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.teal[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text("Score: $score"),
            ),
          ],
        ),
      ),
    );
  }
}