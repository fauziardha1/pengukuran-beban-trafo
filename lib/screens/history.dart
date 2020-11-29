import 'dart:convert';

import 'package:beban_trafo/functions/database_services.dart';
import 'package:beban_trafo/screens/tools/constants.dart';
import 'package:beban_trafo/screens/tools/internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<String> data = [];
  List<String> localHistory = [];
  DatabaseServices firebase;
  bool connection = true;

  Future<List<String>> loadSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setStringList("localHistory", null);
    await pref.remove("localHistory");
    return pref.getStringList("localHistory");
  }

  Future<List<String>> setData() async {
    firebase = DatabaseServices(name: "users");
    return await firebase.getHistory();
  }

  @override
  void initState() {
    setData().then((value) {
      data = value;

      setState(() {});
    });
    // internetConnection().then((value) {
    //   if (!value) {
    //     print("GlobalHistory : $globalHistory");
    //     setState(() {
    //       localHistory = globalHistory;
    //     });
    //   } else {
    //     globalHistory = [];
    //   }
    // });
    // setData().then((value) => print(value));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      data = [...localHistory, ...data];
    });
    return Scaffold(
      appBar: buildAppBar(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Flexible(
              child: data.length != 0
                  ? ListView.builder(
                      padding: EdgeInsets.symmetric(horizontal: 20),
                      itemBuilder: (_, index) => buildlistTile(index),
                      itemCount: data.length)
                  : Container(
                      child: Center(
                        child: Text("Tidak Ada Data."),
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }

  Widget buildlistTile(int index) {
    var result = json.decode(data[index]);
    GlobalKey key = GlobalKey();
    String stringRute = '';
    String stringInduk;
    String stringPhase;
    int count = 0;

    for (var bebanRute in result["hasil Pengukuran"]["bebanRute"]) {
      count++;

      String temp = "\t" + bebanRute.toString().replaceAll('{', '');
      temp = temp.replaceAll("}", "") + "\n";
      stringRute += "\t  " + count.toString() + ". " + temp;
    }

    stringInduk =
        result["hasil Pengukuran"]["bebanInduk"].toString().replaceAll('{', '');
    stringInduk = stringInduk.replaceAll('}', '');
    stringInduk += "\n";

    stringPhase =
        "RS: ${result["hasil Pengukuran"]["bebanPhase"]["RS"]}, ST: ${result["hasil Pengukuran"]["bebanPhase"]["ST"]}, TR: ${result["hasil Pengukuran"]["bebanPhase"]["TR"]}, \n\t RN: ${result["hasil Pengukuran"]["bebanPhase"]["RN"]}, SN: ${result["hasil Pengukuran"]["bebanPhase"]["SN"]}, TN: ${result["hasil Pengukuran"]["bebanPhase"]["TN"]}";

    return Dismissible(
      key: key,
      onDismissed: (direction) {
        print("dismissed");
        if (globalHistory.indexOf(data[index]) <= 0) {
          firebase.deleteAHistory(id: result["timestamp"].toString());
          setData().then((value) {
            data = value;
          });
        }
      },
      background: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFF0C5E74), Color(0xFF00B6D2)])),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.delete_forever_outlined,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      secondaryBackground: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: <Color>[Color(0xFF0C5E74), Color(0xFF00B6D2)])),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.delete_forever_outlined,
                  size: 40,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 5),
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              offset: Offset(0.0, 1.0), //(x,y)
              blurRadius: 6.0,
            ),
          ],
        ),
        child: ListTile(
          title: Text(result["ulp"] + ", " + result["gardu"]),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Staf : " + result["staf Lapangan"].toString()),
              Text("Waktu : " + result["timestamp"].toString()),
              Text("Beban Induk : \n \t  " + stringInduk),
              Text("Beban Rute : \n" + stringRute),
              Text("Beban Phase :\n \t" + stringPhase),
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
        Container(
          // margin: EdgeInsets.all(10),
          child: IconButton(
            icon: Icon(
              Icons.delete_forever,
              size: 30,
            ),
            onPressed: () async {
              print("delete");
              firebase.deleteUserHistory(email: globalEmail);
              setData().then((value) {
                data = value;
                setState(() {});
              });
            },
          ),
        ),
        Container(
          margin: EdgeInsets.all(10),
          child: Image.asset("assets/images/corner.png"),
        ),
      ],
    );
  }
}
