import 'package:beban_trafo/functions/auth_services.dart';
import 'package:beban_trafo/screens/tools/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
    color: Colors.white,
  );

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String email, password;

  @override
  Widget build(BuildContext context) {
    final emailField = TextField(
      controller: emailController,
      onChanged: (value) {
        setState(() {
          email = value;
        });
      },
      style: style,
      decoration: InputDecoration(
          labelText: "Username/Email",
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          prefixIcon: Icon(
            Icons.person,
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final passwordField = TextField(
      controller: passwordController,
      onChanged: (value) {
        setState(() {
          password = value;
        });
      },
      obscureText: true,
      style: style,
      decoration: InputDecoration(
          prefixIcon: Icon(
            Icons.lock,
            color: Colors.white,
          ),
          labelText: "Password",
          labelStyle: TextStyle(
            color: Colors.white,
          ),
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(32.0))),
    );
    final loginButon = Container(
        margin: EdgeInsets.symmetric(horizontal: 50),
        child: Material(
          elevation: 10.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xFFF3B602),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () async {
              User user = await AuthServices.signInWithEmailandPassword(
                  email: emailController.text,
                  password: passwordController.text);

              if (user == null) {
                SweetAlert.show(
                  context,
                  subtitle: "username or password is wrong!",
                  style: SweetAlertStyle.error,
                  showCancelButton: false,
                );
              } else {
                globalEmail = emailController.text;

                CollectionReference users =
                    FirebaseFirestore.instance.collection("users");
                var temp = await users.doc(emailController.text).get();
                SharedPreferences memory =
                    await SharedPreferences.getInstance();

                memory.setString("nama", temp.data()["nama"]);
                memory.setString("email", emailController.text);

                globalStafLapangan = temp.data()["nama"];
                print("Login Memory :$globalStafLapangan ");
              }
            },
            child: Text("Login",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ));

    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: <Color>[Color(0xFF0C5E74), Color(0xFF00B6D2)],
            ),
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Container(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 3,
                        margin: EdgeInsets.only(bottom: 10),
                        child: Center(
                          child: Image.asset(
                            'assets/images/LogoAtLogin.png',
                            fit: BoxFit.fitHeight,
                          ),
                        ),
                      ),
                      emailField,
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      passwordField,
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 30,
                      ),
                      loginButon,
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
