import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:zartek/screens/loggedInScreen.dart';
import 'package:zartek/screens/login.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
        body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              return LoggedInScreen();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Somethig went Wrong'),
              );
            } else {
              return LoginScreen();
            }
          },
        ),
      );
}
