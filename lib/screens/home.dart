import 'package:beban_trafo/screens/input_beban_induk.dart';
import 'package:beban_trafo/screens/tools/constants.dart';
import 'package:beban_trafo/screens/tools/ulp.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sweetalert/sweetalert.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ULP selectedULP;
  TextEditingController controllerGardu = TextEditingController();
  String gardu;

  List<ULP> ulp = [
    ULP(name: "ULP Bukittinggi"),
    ULP(name: "ULP Baso"),
    ULP(name: "ULP Koto Tuo"),
    ULP(name: "ULP Padang Panjang"),
    ULP(name: "ULP Lubuk Sikaping"),
    ULP(name: "ULP Lubuk Basung"),
    ULP(name: "ULP Simpang Empat")
  ];

  List<DropdownMenuItem> generateItems(List<ULP> ulp) {
    List<DropdownMenuItem> items = [];

    for (var item in ulp) {
      items.add(
        DropdownMenuItem(
          child: Text(item.name),
          value: item,
        ),
      );
    }

    return items;
  }

  Future<String> getName() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    return pref.getString("name");
  }

  @override
  void initState() {
    getName().then((value) {
      globalStafLapangan = value;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final inputGardu = TextField(
      controller: controllerGardu,
      onChanged: (value) {
        setState(() {
          gardu = controllerGardu.text;
          globalNamaGardu = "GD-" + value;
        });
      },
      decoration: InputDecoration(
        labelText: "Masukkan Nama Gardu",
        prefixText: "GD- ",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: buildAppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              buildDropdownULP(),
              Text(selectedULP != null
                  ? selectedULP.name
                  : "Silahkan Pilih ULP dahulu!"),
              Container(
                margin: EdgeInsets.all(20),
                child: inputGardu,
              ),
              buttonToStartInput(context),
            ],
          ),
        ),
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          }),
      title: Text("Pengukuran"),
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

  Container buttonToStartInput(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 50, vertical: 50),
        child: Material(
          elevation: 10.0,
          borderRadius: BorderRadius.circular(30.0),
          color: Color(0xFF02A2BB),
          child: MaterialButton(
            minWidth: MediaQuery.of(context).size.width,
            padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            onPressed: () {
              // print("$globalNamaULP, $globalNamaGardu");
              if (selectedULP != null && gardu != null) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => InputBebanInduk()),
                );
              } else {
                SweetAlert.show(
                  context,
                  subtitle: "Silahkan pilih ulp dan gardu!",
                  style: SweetAlertStyle.confirm,
                  showCancelButton: false,
                );
              }
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Mulai Input Beban Travo",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                Icon(Icons.send, color: Colors.white),
              ],
            ),
          ),
        ));
  }

  Container buildDropdownULP() {
    return Container(
      margin: EdgeInsets.all(20),
      child: DropdownButton(
        hint: Text("Pilih ULP"),
        isExpanded: true,
        icon: Icon(Icons.house_rounded),
        style: TextStyle(
            fontSize: 20, color: Colors.blue, fontWeight: FontWeight.bold),
        items: generateItems(ulp),
        value: selectedULP,
        onChanged: (item) {
          setState(() {
            selectedULP = item;
            globalNamaULP = selectedULP.name;
            // print("GlobalULP : $globalNamaULP");
          });
        },
      ),
    );
  }
}
