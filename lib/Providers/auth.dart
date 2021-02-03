import 'package:firebase_auth/firebase_auth.dart';
import 'package:car_qr/Models/user.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // create user object based on firebaseUser
  User _userFromFirebaseUser(FirebaseUser user) {
    if (user != null) {
      User loggedUser = User(uid: user.uid);
      loggedUser.readUser();
      return loggedUser;
    } else {
      return null;
    }
  }

  User _signedInUser(User user) {
    return user != null ? user : null;
  }

  // auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged.map(_userFromFirebaseUser);
  }

  // sign in anonymously
  Future signInAnon() async {
    try {
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // register with email and password
  Future registerWithEmailAndPassword({
    String email,
    String password,
    String firstName,
    String lastName,
    String userType,
  }) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      User signedinUser = User(
        eMail: user.email,
        uid: user.uid,
        firstName: firstName,
        lastName: lastName,
        userType: userType,
      );
      signedinUser.register();
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
