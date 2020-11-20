import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class History extends StatefulWidget {
  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  List<String> data = [];

  Future<List<String>> loadSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getStringList("local");
  }

  @override
  void initState() {
    loadSharedPref().then((value) {
      data = value;
      setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Column(
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
    );
  }

  Widget buildlistTile(int index) {
    var result = json.decode(data[index]);

    return Container(
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
        leading: IconButton(icon: Icon(Icons.delete), onPressed: () {}),
        title: Text(result["ulp"] + ", " + result["gardu"]),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Staf : " + result["staf Lapangan"].toString()),
            Text("Waktu : " + result["timestamp"].toString()),
            Text("Induk :" +
                result["hasil Pengukuran"]["bebanInduk"].toString()),
            Text("Rute :" + result["hasil Pengukuran"]["bebanRute"].toString()),
            Text("Phase :" +
                result["hasil Pengukuran"]["bebanPhase"].toString()),
          ],
        ),
      ),
    );

    // return Container(
    //   margin: EdgeInsets.symmetric(vertical: 10),
    // child: Text(
    //   data[index].toString(),
    // ),

    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text("Staf :" + data[index]["Staf Lapangan"].toString()),
    //       Text("Waktu :" + data[index]["waktuPengukuran"].toString()),
    //       Text("Induk :" +
    //           data[index]["hasilPengukuran"]["bebanInduk"].toString()),
    //       Text("Rute :" +
    //           data[index]["hasilPengukuran"]["bebanRute"].toString()),
    //       Text("Phase :" +
    //           data[index]["hasilPengukuran"]["bebanPhase"].toString()),
    //     ],
    //   ),
    // );
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
          margin: EdgeInsets.all(10),
          child: Image.asset("assets/images/corner.png"),
        ),
      ],
    );
  }
}
