import 'dart:io';

import 'package:flutter/material.dart';
import 'dart:convert';

class LocalJson extends StatefulWidget {
  @override
  _LocalJsonState createState() => _LocalJsonState();
}

class _LocalJsonState extends State<LocalJson> {
  List allCars;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debugPrint("init state is run");
    readDataFromJson().then((carListFromFunction) {
      setState(() {
        allCars = carListFromFunction;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    debugPrint("build state is run");
    return Scaffold(
        appBar: AppBar(
          title: Text("Read From Local Json"),
        ),
        body: allCars != null
            ? Container(
                child: ListView.builder(
                    itemCount: allCars.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        subtitle: Text(allCars[index]["country"]),
                        title: Text(allCars[index]["name"]),
                      );
                    }),
              )
            : Center(
                child: CircularProgressIndicator(),
              ));
  }

  Future<List> readDataFromJson() async {
    /*
    Future<String> jsonRead =
        DefaultAssetBundle.of(context).loadString('assets/data/car.json');

    jsonRead.then((valueJson) {
      debugPrint(valueJson);
      return valueJson;
    });

    */

    // this mean methot is asynchronous and wait this resut  whatever.

    var jsonRead =
        await DefaultAssetBundle.of(context).loadString('assets/data/car.json');

    List carList = json.decode(jsonRead.toString());
    return carList;
  }
}
