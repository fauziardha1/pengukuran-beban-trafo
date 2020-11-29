import 'package:beban_trafo/functions/auth_services.dart';
import 'package:beban_trafo/screens/history.dart';
import 'package:beban_trafo/screens/home.dart';
import 'package:beban_trafo/screens/tools/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  SharedPreferences memory;
  setGlobalEmail() async {
    memory = await SharedPreferences.getInstance();
    globalEmail = memory.getString("email");
    print("Dasboard global Email : $globalEmail");
  }

  @override
  void initState() {
    setGlobalEmail();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double tinggiLayar =
        MediaQuery.of(context).size.height > MediaQuery.of(context).size.width
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width;

    double lebarLayar =
        MediaQuery.of(context).size.width > MediaQuery.of(context).size.height
            ? MediaQuery.of(context).size.height
            : MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildAppBar(),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: tinggiLayar / 20),
                child: Text(
                  "Pengukuran Beban Trafo",
                  style: TextStyle(
                      color: Color(0xFF0C5E74),
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildButton(
                    context,
                    lebarLayar,
                    tinggiLayar,
                    Home(),
                    "INPUT",
                    Icons.note_add,
                  ),
                  buildButton(
                    context,
                    lebarLayar,
                    tinggiLayar,
                    History(),
                    "HISTORY",
                    Icons.search,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  GestureDetector buildButton(BuildContext context, double lebarLayar,
      double tinggiLayar, Widget tujuan, String text, IconData icondata) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          CupertinoPageRoute(
            builder: (_) => tujuan,
          ),
        );
      },
      child: Container(
        width: lebarLayar / 1.2,
        height: tinggiLayar / 5,
        margin: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 2.0), //(x,y)
              blurRadius: 10.0,
            ),
          ],
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              Color(0xFF0C5E74),
              Color(0xFF00B6D2),
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icondata,
                color: Colors.yellow,
                size: 50,
              ),
              Text(
                text,
                style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      title: Text("Dasboard"),
      flexibleSpace: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFF0C5E74), Color(0xFF00B6D2)])),
      ),
      actions: [
        TextButton(
          onPressed: () {
            AuthServices.signOut();
            memory.remove("email");
            memory.remove("nama");
            memory.remove("name");
          },
          child: Text("Log Out",
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              )),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Image.asset("assets/images/corner.png"),
        ),
      ],
    );
  }
}
