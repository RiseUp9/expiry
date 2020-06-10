//imports
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class UserRepository{

  final FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
//constructor
  //
UserRepository({FirebaseAuth firebaseAuth, GoogleSignIn googleSinIn})
  :_firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
  _googleSignIn = googleSinIn ?? GoogleSignIn();

//signInWithGoogle
Future<FirebaseUser> signInWithGoogle() async{
  final GoogleSignInAccount googlesUser = await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleAuth =
      await googlesUser.authentication;
  final AuthCredential credential =
      GoogleAuthProvider.getCredential(accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
  await _firebaseAuth.signInWithCredential(credential);
  return _firebaseAuth.currentUser();
}
//signInWithCredentials
Future<void> signInWithCredentials( String email, String password ){
  return _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
}
//signUp-registro
Future<void> signUp(String email, String password) async{
  return await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
}
//signOut
Future<void> signOut() async{
  return Future.wait([
    _firebaseAuth.signOut(),
  _googleSignIn.signOut()
  ]);
}
//Logueado?
Future<bool> isSigneIn() async{
  final currentUser = await _firebaseAuth.currentUser();
  return currentUser != null;
}
//ObtenerUsuario
Future<String> getUser() async{
  return (await _firebaseAuth.currentUser()).email;
}




}


