import 'package:beban_trafo/screens/input_beban_rute.dart';
import 'package:beban_trafo/screens/tools/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sweetalert/sweetalert.dart';

class InputBebanInduk extends StatefulWidget {
  @override
  _InputBebanIndukState createState() => _InputBebanIndukState();
}

class _InputBebanIndukState extends State<InputBebanInduk> {
  TextEditingController controllerInputR = TextEditingController();
  TextEditingController controllerInputS = TextEditingController();
  TextEditingController controllerInputT = TextEditingController();
  TextEditingController controllerInputN = TextEditingController();

  TextStyle style = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20.0,
  );

  double nilaiR, nilaiS, nilaiT, nilaiN;

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
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      "Beban Induk  : ",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  buildTextField(
                    aspek: "R",
                    controller: controllerInputR,
                  ),
                  Text("nilai R : ${nilaiR == null ? 0.0 : nilaiR}"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  buildTextField(
                    aspek: "S",
                    controller: controllerInputS,
                  ),
                  Text("nilai S :${nilaiS == null ? 0.0 : nilaiS}"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  buildTextField(
                    aspek: "T",
                    controller: controllerInputT,
                  ),
                  Text("nilai T : ${nilaiT == null ? 0.0 : nilaiT}"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  buildTextField(
                    aspek: "N",
                    controller: controllerInputN,
                  ),
                  Text("nilai N : ${nilaiN == null ? 0.0 : nilaiN}"),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 30,
                  ),
                  buttonNextToBebanRute(context),
                ],
              ),
            ),
          ),
        ),
      ),
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
      title: Text("Input Beban Induk"),
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

  Container buttonNextToBebanRute(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        child: Material(
          elevation: 10.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xFF02A2BB),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              if (nilaiR != null &&
                  nilaiS != null &&
                  nilaiT != null &&
                  nilaiN != null) {
                globalBebanInduk["R"] = nilaiR;
                globalBebanInduk["S"] = nilaiS;
                globalBebanInduk["T"] = nilaiN;
                globalBebanInduk["N"] = nilaiN;
                print(globalBebanInduk);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => InputBebanRute(),
                  ),
                );
              } else {
                SweetAlert.show(
                  context,
                  subtitle: "Lengkapi semua nilai!",
                  style: SweetAlertStyle.confirm,
                  showCancelButton: false,
                );
              }
            },
            child: Text("Next",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ));
  }

  TextField buildTextField({String aspek, TextEditingController controller}) {
    return TextField(
      onChanged: (value) {
        setState(() {
          switch (aspek) {
            case "R":
              nilaiR = double.parse(controller.text != null ? value : "0.0");

              break;
            case "S":
              nilaiS = double.parse(
                  controller.text != null ? controller.text : "0.0");
              break;
            case "T":
              nilaiT = double.parse(
                  controller.text != null ? controller.text : "0.0");
              break;
            case "N":
              nilaiN = double.parse(
                  controller.text != null ? controller.text : "0.0");
              break;

              break;
            default:
          }
        });
      },
      keyboardType: TextInputType.number,
      controller: controller,
      style: style,
      decoration: InputDecoration(
          hintText: "0.0",
          labelText: aspek,
          prefixText: "$aspek :  ",
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(10.0))),
    );
  }
}
