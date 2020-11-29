import 'dart:convert';

import 'package:beban_trafo/functions/database_services.dart';
import 'package:beban_trafo/screens/tools/constants.dart';
import 'package:beban_trafo/screens/tools/internet_connection.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class InputBebanPhase extends StatefulWidget {
  @override
  _InputBebanPhaseState createState() => _InputBebanPhaseState();
}

class _InputBebanPhaseState extends State<InputBebanPhase> {
  TextEditingController controllerInputRS = TextEditingController();
  TextEditingController controllerInputST = TextEditingController();
  TextEditingController controllerInputTR = TextEditingController();
  TextEditingController controllerInputRN = TextEditingController();
  TextEditingController controllerInputSN = TextEditingController();
  TextEditingController controllerInputTN = TextEditingController();

  SharedPreferences pref;

  Future<SharedPreferences> loadSharedPref() async {
    return await SharedPreferences.getInstance();
  }

  @override
  void initState() {
    loadSharedPref().then((value) {
      pref = value;
      setState(() {});
    });

    super.initState();
  }

  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );

  var nilaiR, nilaiS, nilaiT, nilaiN;

  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Container(
        child: SingleChildScrollView(
          child: Container(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildGroupRute(context: context, isN: false),
                  buildGroupRute(context: context, isN: true),
                  // SizedBox(
                  //   height: 100,
                  // ),
                  butttonSavetoDone(context),
                ],
              ),
            ),
          ),
        ),
      ),
      // floatingActionButton: buttonNextToBebanPhase(context),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
      ),
      title: Text("Input Beban Phase"),
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

  Column buildGroupRute({BuildContext context, bool isN}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                buildTextField(
                  aspek: isN ? "RN" : "RS",
                  controller: isN ? controllerInputRN : controllerInputRS,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                buildTextField(
                  aspek: isN ? "SN" : "ST",
                  controller: isN ? controllerInputSN : controllerInputST,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                buildTextField(
                  aspek: isN ? "TN" : "TR",
                  controller: isN ? controllerInputTN : controllerInputTR,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget butttonSavetoDone(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        child: Material(
          elevation: 10.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xFF02A2BB),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              globalWaktuPengukuran = DateTime.now();
              if (controllerInputRS.text != '' &&
                  controllerInputST.text != '' &&
                  controllerInputTR.text != '' &&
                  controllerInputRN.text != '' &&
                  controllerInputSN.text != '' &&
                  controllerInputTN.text != '') {
                globalBebanPhase = {
                  "RS": double.parse(controllerInputRS.text),
                  "ST": double.parse(controllerInputST.text),
                  "TR": double.parse(controllerInputTR.text),
                  "RN": double.parse(controllerInputRN.text),
                  "SN": double.parse(controllerInputSN.text),
                  "TN": double.parse(controllerInputTN.text),
                };

                DatabaseServices firebase =
                    DatabaseServices(name: globalNamaULP);
                firebase.createAndUpdateProduct(globalNamaGardu);

                // internetConnection().then((value) async {
                //   if (!value) {
                //     // get the globaldata   and save it in shared pref
                //     String dataToSave = json.encode(globalData);
                //     // List<String> oldPref =
                //     //     pref.getStringList("localHistory") ?? [];
                //     // oldPref.insert(0, dataToSave);
                //     // pref.setStringList("localHistory", oldPref);
                //     // print(" offline beban phase : ${pref.get("localHistory")}");

                //     globalHistory.insert(0, dataToSave);

                //     globalNamaULP = null;
                //     globalNamaGardu = null;
                //     globalStafLapangan = null;
                //     globalWaktuPengukuran = null;
                //     globalBebanInduk = {};
                //     globalBebanPhase = {};
                //     globalBebanRute = [];
                //     globalEmail = null;
                //     // end of save to sharedPref
                //   } else {
                //     globalHistory = [];
                //   }
                // });

                SweetAlert.show(context,
                    title: "Berhasil",
                    subtitle: "Data hasil pengukuran berhasil terkirim",
                    // ignore: missing_return
                    onPress: (bool isConfirm) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.pop(context);
                }, style: SweetAlertStyle.success);
              } else {
                SweetAlert.show(context,
                    title: "ERROR",
                    subtitle: "Masukkan semua data yang dibutuhkan!",
                    style: SweetAlertStyle.error);
              }
            },
            child: Text("Simpan",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ));
  }

  Widget buildTextField({String aspek, TextEditingController controller}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text(
          " $aspek : ",
          style: TextStyle(fontSize: 20),
        ),
        Container(
          width: 200,
          child: TextField(
            onChanged: (value) {},
            keyboardType: TextInputType.number,
            controller: controller,
            style: style,
            decoration: InputDecoration(
                hintText: "0.0",
                labelText: aspek,
                contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0))),
          ),
        ),
      ],
    );
  }
}
