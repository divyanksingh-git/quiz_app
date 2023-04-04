import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/screens/welcome.dart';

class End extends StatelessWidget {
  var score;
  final maxIndex = 9;
  End(int score) {
    this.score = score;
  }

  dynamic retText() {
    if (GetStorage().read("TotalScore") == null) {
      return "0";
    } else {
      return GetStorage().read("TotalScore").toString();
    }
  }

  List<Widget> listCard() {
    List<Widget> cards = [];

    for (int i = 0; i < maxIndex + 1; i++) {
      cards.add(CustomCard(i));
    }
    return cards;
  }

  @override
  Widget build(BuildContext context) {
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
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(5, 50, 5, 0),
                width: double.infinity,
                child: Card(
                  color: Color.fromARGB(55, 0, 0, 0),
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Row(children: [
                      Expanded(
                          child: Column(
                        children: [
                          CircularPercentIndicator(
                            radius: 50.0,
                            lineWidth: 10.0,
                            percent: score / 100,
                            center: new Text(
                              "Score\n$score",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.white),
                              textAlign: TextAlign.center,
                            ),
                            progressColor: Colors.blue.shade800,
                            backgroundColor: Colors.grey.shade800,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Total Score",
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            retText(),
                            style: TextStyle(fontSize: 15, color: Colors.white),
                          )
                        ],
                      )),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: IconButton(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Welcome()),
                              );
                            },
                            icon: Icon(
                              Icons.restart_alt_rounded,
                              size: 50,
                              color: Colors.green,
                            )),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: IconButton(
                            onPressed: null,
                            icon: Icon(
                              Icons.leaderboard_rounded,
                              color: Colors.red,
                              size: 50,
                            )),
                      ),
                      SizedBox(width: 25)
                    ]),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 0),
                  child: ListView(children: listCard()),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomCard extends StatelessWidget {
  var index;
  CustomCard(index) {
    this.index = index;
  }

  dynamic retColor(int i) {
    if (Answers[i] == true) {
      return Colors.blue.shade800;
    } else {
      return Colors.grey.shade800;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: retColor(index),
      child: Container(
          margin: EdgeInsets.all(10),
          child: Text(
            Questions[index]["note"],
            style: TextStyle(
              fontSize: 25,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          )),
    );
  }
}
