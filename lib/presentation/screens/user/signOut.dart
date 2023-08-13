import 'package:flutter/material.dart';

class SignOut extends StatelessWidget {
  const SignOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('Sign Out',style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold
      ),)),
    );
  }
}
