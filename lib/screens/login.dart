import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:zartek/provider/google_sign_in_provider.dart';
import 'package:zartek/screens/phone_login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              child: Image(
                image: AssetImage('assets/images/logo/firebase.png'),
              ),
            ),
            SizedBox(
              height: 150,
            ),
            ElevatedButton(
              onPressed: () {
                final provider =
                    Provider.of<GoogleSignInProvider>(context, listen: false);
                provider.googleLogin();
              },
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 10),
                    width: 30,
                    child: Image(
                      image: AssetImage('assets/images/logo/google.png'),
                    ),
                  ),
                  Center(
                    child: Text(
                      'Google',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => PhoneLogin()));
              },
              child: Stack(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 0, top: 12),
                    width: 30,
                    child: FaIcon(FontAwesomeIcons.phoneAlt),
                  ),
                  Center(
                    child: Text(
                      'Phone',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.green,
                fixedSize: Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
