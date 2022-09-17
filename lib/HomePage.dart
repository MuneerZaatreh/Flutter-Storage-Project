import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/Storage.dart';
import 'package:flutter_application_1/sqldb.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

import 'Transtion.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var f;
  var gg;
  SqlDb sqldb = SqlDb();
  var x;
  String? scanresult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          leading: IconButton(
              icon: const Icon(Icons.storage, color: Colors.white),
              onPressed: () {
                 Navigator.pop(context);  
                Navigator.of(context).push(EnterExitRoute(
                    enterPage: const Stroage(), exitPage: const HomePage()));
              })),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/5470208.jpg"), fit: BoxFit.none),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: ListView(
              children: [
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Text(
                          "W",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                              color: Colors.orange),
                        ),
                        Text(
                          "E",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 60,
                          ),
                        ),
                        Text(
                          "L",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                              color: Colors.orange),
                        ),
                        Text(
                          "C",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 60),
                        ),
                        Text(
                          "O",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                              color: Colors.orange),
                        ),
                        Text(
                          "M",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 60),
                        ),
                        Text(
                          "E",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                              color: Colors.orange),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          textAlign: TextAlign.center,
                          enabled: false,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.green),
                            ),
                            filled: true,
                            hintStyle:
                                Theme.of(context).textTheme.subtitle2!.copyWith(
                                      color: Colors.white.withOpacity(0.5),
                                      fontSize: 18,
                                    ),
                            hintText: scanresult ?? "ScanBarcode",
                          ),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                    TextButton(
                      style: ButtonStyle(
                        foregroundColor:
                            MaterialStateProperty.all<Color>(Colors.blue),
                        overlayColor: MaterialStateProperty.resolveWith<Color?>(
                          (Set<MaterialState> states) {
                            if (states.contains(MaterialState.hovered)) {
                              return Colors.blue.withOpacity(0.04);
                            }
                            if (states.contains(MaterialState.focused) ||
                                states.contains(MaterialState.pressed)) {
                              return Colors.blue.withOpacity(0.12);
                            }
                            return null; // Defer to the widget's default.
                          },
                        ),
                      ),
                      onPressed: () => scanBarcode(),
                      child: const Text('Scan Barcode'),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: TextFormField(
                          onChanged: (newText) {
                            setState(() {
                              x = newText;
                            });
                          },
                          textAlign: TextAlign.center,
                          textAlignVertical: TextAlignVertical.center,
                          decoration: InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.blue),
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: const BorderSide(color: Colors.green),
                            ),
                            filled: true,
                            hintText: "Amount Of the Proudect",
                          ),
                        )),
                    const SizedBox(
                      height: 25,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        OutlinedButton(
                          onPressed: () async {
                            if (x == null) return;
                            x = x.toString();
                            x = int.parse(x);
                            int response = await sqldb.updateData(
                                "UPDATE marketdata SET amount = amount - $x where barcode = $scanresult and amount-$x >=0");
                            print(response);
                          },
                          child: const Text("Discrese"),
                        ),
                        OutlinedButton(
                          onPressed: () async {
                            var selected = await sqldb
                                .readData("SELECT * FROM marketdata");
                            List<Map> CheckIfexist = await sqldb.readData(
                                "SELECT barcode FROM marketdata where barcode = '$scanresult'");
                            if (x == null) return;
                            x = x.toString();
                            x = int.parse(x);
                            if (CheckIfexist.isEmpty) {
                              int response = await sqldb.insertData(
                                  "INSERT INTO marketdata ('barcode','amount') VALUES ('$scanresult','$x')");
                            }
                            print("$selected");
                          },
                          child: const Text('Insert'),
                        ),
                        OutlinedButton(
                          onPressed: () async {
                            if (x == null) return;
                            x = x.toString();
                            x = int.parse(x);
                            int response = await sqldb.updateData(
                                "UPDATE marketdata SET amount = amount + $x where barcode = $scanresult");
                            print(response);
                          },
                          child: const Text("Add"),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                        onPressed: () async {
                          List<Map> response = await sqldb.readData(
                              "SELECT amount FROM marketdata where barcode = $scanresult");
                          setState(() {
                            if (response.isNotEmpty) {
                              gg = response[0].values;
                            } else {
                              gg = "There Is no Product";
                            }
                          });
                        },
                        child: const Text("Show Amount"),
                      ),
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    Text(gg == null ? "" : "$gg "),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future scanBarcode() async {
    String scanresult;
    try {
      scanresult = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.BARCODE);
    } on PlatformException {
      scanresult = "Faild to Get platform version";
    }
    if (!mounted) return;
    setState(() => this.scanresult = scanresult);
    gg = "";
  }
}
