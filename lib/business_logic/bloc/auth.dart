import 'package:firebase_auth/firebase_auth.dart';

class Auth{
  final _auth = FirebaseAuth.instance;
  signUp({required email,required password})async{
    await _auth.createUserWithEmailAndPassword(email: email, password: password).then((value) {
    }).catchError((error){});
  }

  signIn({required email,required password})async{
    await _auth.signInWithEmailAndPassword(email: email, password: password).then((value) {
    }).catchError((error){
    });
  }
}