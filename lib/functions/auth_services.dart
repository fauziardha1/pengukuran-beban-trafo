import 'package:beban_trafo/screens/tools/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static FirebaseAuth _auth = FirebaseAuth.instance;

  static Future<User> signInAnonymously() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User firebaseUser = result.user;

      return firebaseUser;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  static Future<User> signInWithEmailandPassword(
      {String email, String password}) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentSnapshot document;
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User firebaseUser = result.user;
      document = await users.doc(email).get();
      SharedPreferences pref = await SharedPreferences.getInstance();
      pref.setString("name", document.get("nama"));
      globalStafLapangan = document.get("nama");

      return firebaseUser;
    } catch (e) {
      print("Error => : ${e.toString()}");
      return null;
    }
  }

  static Future<void> signOut() => _auth.signOut();

  static Stream<User> get firebaseUserStream => _auth.authStateChanges();
}
