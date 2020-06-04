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
  List unFilteredData;

  Future<String> loadJsonData() async {
    var jsonText = await rootBundle.loadString("assets/data.json");
    setState(() {
      dta = json.decode(jsonText);
      this.unFilteredData = dta;
    });
  }

  @override
  void initState() {
    super.initState();
    this.loadJsonData();
  }

  void searchData(str) {
    var strExist = str.length > 0 ? true : false;
    if (strExist) {
      var filteredData = [];
      for (var i = 0; i < unFilteredData.length; i++) {
       String name =unFilteredData[i]["name"].toUpperCase();
       String phone =unFilteredData[i]["phone"];
        if ((name.contains(str.toUpperCase())) || phone.contains(str) ) {
          filteredData.add(unFilteredData[i]);
        }
      }
      setState(() {
        this.dta = filteredData;
      });
    } else {
      setState(() {
        this.dta = this.unFilteredData;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Address Book"),
        ),
        body: Column(
          children: <Widget>[
        Container(
          child: TextField(
            decoration: InputDecoration(
                hintText: "Search Name or Number",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(33))),
            onChanged: (String str) {
              this.searchData(str);
//              print(str);
            },
          ),
padding: EdgeInsets.only(left: 5,right: 5,top: 5),
          color: Colors.lightBlueAccent
        ),
            Expanded(
                child: ListView.builder(
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
            )),
          ],
        ));
  }
}
