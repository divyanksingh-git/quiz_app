import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:quiz_app/screens/quiz.dart';

class Welcome extends StatelessWidget {
  const Welcome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool LoggedIn = false;

    if (GetStorage().read("credential") != null) {
      LoggedIn = true;
    } else {
      LoggedIn = false;
    }

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
          //appBar: AppBar(),
          body: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/bg.png"), fit: BoxFit.cover)),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Expanded(
              child: Container(
                width: 250,
                height: 250,
                child: Image(
                  image: AssetImage("assets/answer.png"),
                ),
              ),
              flex: 2,
            ),
            Text(
              "Welcome",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  color: Colors.white),
            ),
            Text(
              "Lets play a quiz",
              style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 30,
                  color: Colors.white),
            ),
            SizedBox(
              height: 40,
            ),
            ElevatedButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white),
                    foregroundColor: MaterialStatePropertyAll(Colors.black)),
                onPressed: () async {
                  if (LoggedIn == false) {
                    if (GetStorage().read("credential") != null) {
                      FirebaseAuth.instance.signInWithCredential(
                          GetStorage().read("credential"));
                    } else {
                      GoogleSignInAccount? googleUser =
                          await GoogleSignIn().signIn();
                      GoogleSignInAuthentication? googleAuth =
                          await googleUser?.authentication;

                      AuthCredential credential = GoogleAuthProvider.credential(
                          accessToken: googleAuth?.accessToken,
                          idToken: googleAuth?.idToken);
                      GetStorage().write("credential", credential);
                      FirebaseAuth.instance.signInWithCredential(
                          GetStorage().read("credential"));
                    }
                    LoggedIn = true;
                  } else {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const Quiz()),
                    );
                  }
                },
                child: TextState()),
            Spacer(),
          ],
        ),
      )),
    );
  }
}

class TextState extends StatefulWidget {
  TextState({Key? key}) : super(key: key);

  @override
  _TextStateState createState() => _TextStateState();
}

class _TextStateState extends State<TextState> {
  @override
  Widget build(BuildContext context) {
    String btnText;
    if (GetStorage().read("credential") != null) {
      btnText = "Start";
    } else {
      btnText = "Login";
    }
    GetStorage().listenKey("credential", (value) {
      setState(() {
        if (GetStorage().read("credential") != null) {
          btnText = "Start";
        } else {
          btnText = "Login";
        }
      });
    });
    return Text(
      "$btnText",
      style: TextStyle(fontSize: 20),
    );
  }
}
