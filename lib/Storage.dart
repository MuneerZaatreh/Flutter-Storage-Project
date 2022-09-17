import 'package:flutter/material.dart';
import 'package:flutter_application_1/HomePage.dart';
import 'package:flutter_application_1/sqldb.dart';
import 'package:flutter_application_1/sqldb.dart';

import 'Transtion.dart';

class Stroage extends StatefulWidget {
  const Stroage({Key? key}) : super(key: key);

  @override
  State<Stroage> createState() => _StroageState();
}

SqlDb sql = SqlDb();

class _StroageState extends State<Stroage> {
  SqlDb sql = SqlDb();
  Future<List<Map>> readData() async {
    List<Map> response = await sql.readData("SELECT * FROM marketdata");
    return response;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            backgroundColor: Colors.lightBlue,
            leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const HomePage())))),
        body: SafeArea(
            child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: FutureBuilder(
                  future: readData(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Map>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data!.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, i) {
                            return Text(
                              "${snapshot.data![i]}",
                              style:
                                  TextStyle(fontSize: 15, color: Colors.black),
                              textAlign: TextAlign.center,
                            );
                          });
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }),
            ),
            ElevatedButton(
                onPressed: () async {
                  var Delete = await sql.deleteData(
                      "DELETE FROM marketdata WHERE not id = '999'");
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const Stroage()));
                },
                child: Text("Delete Everything"))
          ],
        )));
  }
}
