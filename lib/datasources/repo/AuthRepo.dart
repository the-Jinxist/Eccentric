import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo{

  static FirebaseAuth _authInstance;

  static FirebaseAuth _getInstance(){
    if(_authInstance != null){
      return _authInstance;

    }else{
      _authInstance = FirebaseAuth.instance;
      return _authInstance;
    }
  }

  static Future<AuthResult> signInWithEmailAndPassword({String email, String password}){
    return _getInstance().signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<AuthResult> signUpWithEmailAndPassword({String email, String password}){
    return _getInstance().createUserWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> signOut() => _getInstance().signOut();

  static Future<FirebaseUser> getCurrentUser() async {
    return await _getInstance().currentUser();
  }

  static Future<bool> isUserSignIn() async {
    var user = await _getInstance().currentUser();
    return user != null;
  }

}