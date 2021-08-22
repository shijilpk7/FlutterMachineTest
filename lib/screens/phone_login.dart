import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:zartek/screens/loggedInScreen.dart';

class PhoneLogin extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.all(32),
      child: Form(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Login",
              style: TextStyle(
                  color: Colors.lightBlue,
                  fontSize: 36,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: 16,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.digitsOnly
              ],
              decoration: InputDecoration(
                  prefixText: '+91',
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                      borderSide: BorderSide(color: Colors.grey)),
                  filled: true,
                  fillColor: Colors.grey[100],
                  hintText: "Phone Number"),
              controller: _phoneController,
            ),
            SizedBox(
              height: 16,
            ),
            SizedBox(
              height: 16,
            ),
            Container(
              width: double.infinity,
              child: FlatButton(
                child: Text("Login"),
                textColor: Colors.white,
                padding: EdgeInsets.all(16),
                onPressed: () {
                  final mobile = '+91' + _phoneController.text.trim();
                  registerUser(mobile, context);
                },
                color: Colors.blue,
              ),
            )
          ],
        ),
      ),
    ));
  }

  Future registerUser(String mobile, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: mobile,
      timeout: Duration(seconds: 60),
      verificationCompleted: (AuthCredential authCredential) {
        _auth.signInWithCredential(authCredential).then((result) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => LoggedInScreen()));
        }).catchError((e) {
          print(e);
        });
      },
      verificationFailed: (authException) {
        print(authException.message);
      },
      codeSent: (String verificationId, [int? forceResendingToken]) async {
//show dialog to take input from the user
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => AlertDialog(
            title: Text("Enter OTP"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                TextField(
                  controller: _codeController,
                ),
              ],
            ),
            actions: <Widget>[
              FlatButton(
                child: Text("Done"),
                textColor: Colors.white,
                color: Colors.redAccent,
                onPressed: () {
                  FirebaseAuth auth = FirebaseAuth.instance;

                  final smsCode = _codeController.text.trim();

                  final _credential = PhoneAuthProvider.credential(
                      verificationId: verificationId, smsCode: smsCode);
                  auth.signInWithCredential(_credential).then((result) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => LoggedInScreen()));
                  }).catchError((e) {
                    print(e);
                  });
                },
              )
            ],
          ),
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        verificationId = verificationId;
      },
    );
  }
}
