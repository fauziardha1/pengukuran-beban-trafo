import 'package:beban_trafo/screens/input_beban_phase.dart';
import 'package:beban_trafo/screens/tools/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputBebanRute extends StatefulWidget {
  @override
  _InputBebanRuteState createState() => _InputBebanRuteState();
}

class _InputBebanRuteState extends State<InputBebanRute> {
  List<List<TextEditingController>> controllers = [
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
    [
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
      TextEditingController(),
    ],
  ];
  List<List<double>> values = [
    [
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
    ],
    [
      0,
      0,
      0,
      0,
    ]
  ];

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
                  buildGroupRute(context: context, urutanRute: 1),
                  buildGroupRute(context: context, urutanRute: 2),
                  buildGroupRute(context: context, urutanRute: 3),
                  buildGroupRute(context: context, urutanRute: 4),
                  buttonNextToBebanPhase2(context),
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
      title: Text("Input Beban Rute"),
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

  Column buildGroupRute({BuildContext context, int urutanRute}) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Text(
            "Beban Rute $urutanRute : ",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildTextField(
                      urutan: urutanRute,
                      aspek: "R",
                      controller: controllers[urutanRute - 1][0],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    buildTextField(
                      urutan: urutanRute,
                      aspek: "S",
                      controller: controllers[urutanRute - 1][1],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                  ],
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    buildTextField(
                      urutan: urutanRute,
                      aspek: "T",
                      controller: controllers[urutanRute - 1][2],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                    buildTextField(
                      urutan: urutanRute,
                      aspek: "N",
                      controller: controllers[urutanRute - 1][3],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 30,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget buttonNextToBebanPhase2(BuildContext context) {
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
              // print(values);

              for (var i = 0; i < values.length; i++) {
                Map<String, double> newValue = {};

                if (values[i][0] <= 0 &&
                    values[i][1] <= 0 &&
                    values[i][2] <= 0 &&
                    values[i][3] <= 0) {
                  continue;
                }

                for (var j = 0; j < values[i].length; j++) {
                  switch (j) {
                    case 0:
                      newValue["R"] = values[i][j];
                      break;
                    case 1:
                      newValue["S"] = values[i][j];
                      break;
                    case 2:
                      newValue["T"] = values[i][j];
                      break;
                    case 3:
                      newValue["N"] = values[i][j];
                      break;
                    default:
                  }
                }

                globalBebanRute.add(newValue);
              }
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => InputBebanPhase(),
                ),
              );
              // print(globalBebanRute);
            },
            child: Text("Next",
                textAlign: TextAlign.center,
                style: style.copyWith(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ));
  }

  Widget buildTextField({
    String aspek,
    TextEditingController controller,
    int urutan,
  }) {
    return Row(
      children: [
        Text(
          " $aspek : ",
          style: TextStyle(fontSize: 20),
        ),
        Container(
          width: 100,
          child: TextField(
            onChanged: (value) {
              setState(() {
                switch (aspek) {
                  case "R":
                    values[urutan - 1][0] = double.parse(value);
                    break;
                  case "S":
                    values[urutan - 1][1] = double.parse(value);
                    break;
                  case "T":
                    values[urutan - 1][2] = double.parse(value);
                    break;
                  case "N":
                    values[urutan - 1][3] = double.parse(value);
                    break;
                }
              });
            },
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

  Widget buttonNextToBebanPhase(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      icon: Icon(Icons.save),
      label: Text(
        "Simpan dan lanjut ke beban Phase",
        style: TextStyle(fontFamily: "Montserrat"),
      ),
    );
  }
}
