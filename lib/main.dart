import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:async';
import 'dart:convert';

void main() {
  runApp(MaterialApp(title: "Shoaibs AddressBook", home: MyApp()));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List dta;

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString("assets/data.json");
    setState(() {
      dta = json.decode(jsonText);
    });
  }

  @override
  void initState() {
    this.loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Address Book"),
        ),
        body: ListView.builder(
          itemCount: dta.length,
          itemBuilder: (BuildContext context, int i) {
            return Column(
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    child: Text(dta[i]["name"][0]),
                  ),
                  title: Text(dta[i]["name"]),
                  subtitle: Text(dta[i]["phone"]),
                )
              ],
            );
          },
        ));
  }
}
