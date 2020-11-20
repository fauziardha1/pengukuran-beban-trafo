import 'package:beban_trafo/screens/dashboard.dart';
import 'package:beban_trafo/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User firebaseUser = Provider.of<User>(context);
    return firebaseUser == null ? LoginScreen() : Dashboard();
  }
}
