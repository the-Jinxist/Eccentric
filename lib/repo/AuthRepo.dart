import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo{

  FirebaseAuth _authInstance;

  FirebaseAuth _getInstance(){
    if(_authInstance != null){
      return _authInstance;

    }else{
      _authInstance = FirebaseAuth.instance;
      return _authInstance;
    }
  }

  Future<AuthResult> signInWithEmailAndPassword({String email, String password}){
    return _getInstance().signInWithEmailAndPassword(email: email, password: password);
  }

  Future<AuthResult> signUpWithEmailAndPassword({String email, String password}){
    return _getInstance().createUserWithEmailAndPassword(email: email, password: password);
  }

  Future<void> signOut() => _getInstance().signOut();

  Future<FirebaseUser> getCurrentUser() async {
    return await _getInstance().currentUser();
  }

  Future<bool> isUserSignIn() async {
    var user = await _getInstance().currentUser();
    return user != null;
  }

}