import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: App(),
  ));
}

class App extends StatefulWidget {
  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  //country
  List country_data = List();

  String countryid; //default id for the dropdown
  //its null for me you can copy an id from api and place here it will be seen....
  Future<String> country() async {
    var res = await http.get(
        Uri.encodeFull("https://jsonplaceholder.typicode.com/posts/"),
        headers: {
          "Accept": "application/json"
        }); //if you have any auth key place here...properly..
    var resBody = json.decode(res.body);

    setState(() {
      country_data = resBody;
    });

    return "Sucess";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.country();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dropdown #API"),
        centerTitle: true,
        backgroundColor: Colors.black,
      ),
      body: Container(
          padding: EdgeInsets.all(15.0), //some padding
          child: Column(
            children: <Widget>[
              DecoratedBox(
                  decoration: BoxDecoration(
                      border: new Border.all(color: Colors.black),
                      borderRadius: BorderRadius.circular(5.0)),
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                    child: Stack(
                      children: <Widget>[
                        Text(
                          "Country:",
                          style: TextStyle(
                            fontSize: 13.0,
                          ),
                        ),
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            isExpanded: true,
                            items: country_data.map((item) {
                              return new DropdownMenuItem(
                                  child: new Text(
                                    item['title'],
                                    style: TextStyle(
                                      fontSize: 13.0,
                                    ),
                                  ),
                                  value: item['id'].toString());
                            }).toList(),
                            onChanged: (String newVal) {
                              setState(() {
                                countryid = newVal;
                                print(countryid.toString());
                              });
                            },
                            value: countryid,
                          ),
                        )
                      ],
                    ),
                  )),
            ],
          )),
    );
  }
}
