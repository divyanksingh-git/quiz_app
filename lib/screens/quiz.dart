import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/screens/end.dart';
import 'package:timer_count_down/timer_controller.dart';
import 'package:timer_count_down/timer_count_down.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  int index = 0;
  int score = 0;
  final CountdownController _controller =
      new CountdownController(autoStart: true);
  final maxIndex = 9;

  _QuizState() {
    clear_answers();
    index = 0;
    score = 0;
    _controller.restart();
  }
  @override
  Widget build(BuildContext context) {
    bool answer = false;
    initState() {
      index = 0;
      score = 0;
      answer = false;
      _controller.restart();
    }

    void check(var opt) {
      if (index == maxIndex) {
        if (Questions[index]["answer"] == Questions[index]["option"][opt]) {
          score += 10;
          answer = true;
        } else {
          if (score > 0) {
            score -= 5;
            answer = false;
          }
        }
        add_answers(answer);

        if (GetStorage().read("TotalScore") == null) {
          GetStorage().write("TotalScore", score);
        } else {
          int ts = GetStorage().read("TotalScore") + score;
          GetStorage().write("TotalScore", ts);
        }
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => End(score)),
        );
      } else {
        if (Questions[index]["answer"] == Questions[index]["option"][opt]) {
          score += 10;
          answer = true;
        } else {
          if (score > 0) {
            score -= 5;
          }
          answer = false;
        }
        add_answers(answer);

        setState(() {
          index += 1;
          _controller.restart();
        });
      }
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
              image: DecorationImage(
                  image: AssetImage("assets/bg.png"), fit: BoxFit.cover)),
          child: Column(children: [
            Countdown(
              controller: _controller,
              seconds: 10,
              build: (BuildContext context, double time) => Container(
                margin: EdgeInsets.fromLTRB(5, 50, 5, 25),
                width: double.infinity,
                height: 25,
                child: LinearPercentIndicator(
                  barRadius: Radius.circular(10),
                  percent: 1.0 - (time.toDouble() / 10),
                  backgroundColor: Colors.grey.shade600,
                  progressColor: Colors.blue,
                  lineHeight: 25,
                  center: Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        child: Text(
                          "${time.toString()}/10.0",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      Spacer(),
                      Container(
                        margin: EdgeInsets.all(3),
                        child: Icon(
                          Icons.timer_outlined,
                          color: Colors.white,
                          size: 20,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              interval: Duration(milliseconds: 100),
              onFinished: () {
                if (index == maxIndex) {
                  if (GetStorage().read("TotalScore") == null) {
                    GetStorage().write("TotalScore", score);
                  } else {
                    int ts = GetStorage().read("TotalScore") + score;
                    GetStorage().write("TotalScore", ts);
                  }
                  add_answers(answer);

                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => End(score)),
                  );
                } else {
                  add_answers(answer);
                  setState(() {
                    index++;
                    _controller.restart();
                  });
                }
              },
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                height: double.infinity,
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        padding: EdgeInsets.all(5),
                        child: Row(children: [
                          Text(
                            "Questions",
                            style: TextStyle(fontSize: 20),
                          ),
                          Spacer(),
                          Text(
                            "${index + 1} / ${maxIndex + 1}",
                            style: TextStyle(fontSize: 20),
                          ),
                        ]),
                      ),
                      Divider(
                        color: Colors.grey.shade700,
                      ),
                      Expanded(
                        child: Container(
                          margin: EdgeInsets.all(5),
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          height: double.infinity,
                          child: Column(children: [
                            SizedBox(
                              height: 10,
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              child: Text(
                                Questions[index]["question"],
                                style: TextStyle(fontSize: 24),
                                textAlign: TextAlign.center,
                                overflow: TextOverflow.clip,
                              ),
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () => setState(() {
                                        check(0);
                                      }),
                                  child: Text(
                                    Questions[index]["option"][0],
                                    style: TextStyle(fontSize: 20),
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () => check(1),
                                  child: Text(
                                    Questions[index]["option"][1],
                                    style: TextStyle(fontSize: 20),
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () => check(2),
                                  child: Text(
                                    Questions[index]["option"][2],
                                    style: TextStyle(fontSize: 20),
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(5),
                              width: double.infinity,
                              child: ElevatedButton(
                                  onPressed: () => check(3),
                                  child: Text(
                                    Questions[index]["option"][3],
                                    style: TextStyle(fontSize: 20),
                                    overflow: TextOverflow.clip,
                                    textAlign: TextAlign.center,
                                  )),
                            ),
                          ]),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
