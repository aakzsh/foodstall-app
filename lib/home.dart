// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:foodstall/card.dart';
import 'package:foodstall/home_page.dart';
import 'package:foodstall/mapview.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

var newFilter = {};

class _HomeState extends State<Home> {
  var ratingCont = TextEditingController();
  var rangeCont = TextEditingController();
  var nonvegCont = TextEditingController();
  var searchcont = TextEditingController();
  double _currentSliderValue = 1;

  updateFilter() {
    var x = {};

    if (nonvegCont.value.text == 'y' || nonvegCont.value.text == 'Y') {
      setState(() {
        // x.addEntries(<String, bool>{"onlyveg": false});
        final nv = <String, bool>{"onlyveg": false};
        x.addEntries(nv.entries);
      });
    }

    List<String> ratings = ['1', '2', '3', '4', '5'];

    if (ratings.contains(ratingCont.value.text) &&
        ratings.contains(rangeCont.value.text)) {
      setState(() {
        final ra = <String, int>{"price": int.parse(ratingCont.value.text)};
        final price = <String, int>{"ratings": int.parse(rangeCont.value.text)};

        x.addEntries(ra.entries);
        x.addEntries(price.entries);
      });
    }
    return x;
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "FoodStall",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
                                borderRadius: BorderRadius.circular(10)),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  width: w - 80,
                                  color: Colors.transparent,
                                  child: Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: TextField(
                                          controller: searchcont,
                                          decoration: InputDecoration.collapsed(
                                              hintText: "Search here"))),
                                ),
                                IconButton(
                                    onPressed: () {
                                      print(searchcont.value.text);
                                      setState(() {
                                        vars = {
                                          "database": "foodstall-stepzen",
                                          "dataApikey": "$dataApikey",
                                          "datasource": "stepzen-cluster",
                                          "collection": "stalls",
                                          "filter": {
                                            // "name": searchcont.value.text
                                            "name": RegExp(r'/.*momo.*/')
                                          }
                                          // pepeOK cri aestheticry feelsbanman
                                        };
                                      });
                                    },
                                    icon: Icon(Icons.search))
                              ],
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            InkWell(
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Icon(
                                  Icons.filter_list,
                                  color: Color.fromARGB(255, 147, 226, 150),
                                ),
                              ),
                              onTap: () {
                                showDialog(
                                    context: (context),
                                    builder: ((context) => AlertDialog(
                                          backgroundColor: Colors.transparent,
                                          content: Container(
                                            child: Padding(
                                              padding: EdgeInsets.all(20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text("Filters"),
                                                  SizedBox(
                                                    height: 30,
                                                  ),
                                                  TextField(
                                                    controller: ratingCont,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration
                                                        .collapsed(
                                                            hintText:
                                                                "Ratings (1 to 5)"),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextField(
                                                    controller: rangeCont,
                                                    keyboardType:
                                                        TextInputType.number,
                                                    decoration: InputDecoration
                                                        .collapsed(
                                                            hintText:
                                                                "Price Range (1 to 5)"),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  TextField(
                                                    controller: nonvegCont,
                                                    maxLength: 1,
                                                    decoration: InputDecoration
                                                        .collapsed(
                                                            hintText:
                                                                "Non-Veg? Type y for yes"),
                                                  ),
                                                  SizedBox(height: 20),
                                                  InkWell(
                                                    child: Container(
                                                        width: 120,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        child: Center(
                                                          child: Text("apply"),
                                                        )),
                                                    onTap: () {
                                                      /////////////
                                                      print(
                                                          "newFilter hai $newFilter, $ratingCont, $rangeCont, $nonvegCont");
                                                      setState(() {
                                                        vars = {
                                                          "database":
                                                              "foodstall-stepzen",
                                                          "dataApikey":
                                                              "$dataApikey",
                                                          "datasource":
                                                              "stepzen-cluster",
                                                          "collection":
                                                              "stalls",
                                                          "filter":
                                                              updateFilter(),
                                                          // aestheticry
                                                        };
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  InkWell(
                                                    child: Container(
                                                        width: 120,
                                                        height: 30,
                                                        decoration: BoxDecoration(
                                                            color: Colors
                                                                .transparent,
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        30)),
                                                        child: Center(
                                                          child:
                                                              Text("clear all"),
                                                        )),
                                                    onTap: () {
                                                      setState(() {
                                                        vars = {
                                                          "database":
                                                              "foodstall-stepzen",
                                                          "dataApikey":
                                                              "$dataApikey",
                                                          "datasource":
                                                              "stepzen-cluster",
                                                          "collection":
                                                              "stalls",
                                                          "filter": {}
                                                          // pepeOK cri aestheticry feelsbanman
                                                        };
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                            decoration: BoxDecoration(
                                                color: Colors.black,
                                                border: Border.all(
                                                    color: Colors.white)),
                                            height: 400,
                                            width: w - 20,
                                          ),
                                        )));
                              },
                            ),
                            SizedBox(width: 10),
                            InkWell(
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white10,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Icon(
                                  Icons.location_on_outlined,
                                  color: Color.fromARGB(255, 226, 148, 147),
                                ),
                              ),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => MapView()));
                              },
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Expanded(
                            child: Container(
                          height: double.maxFinite,
                          width: double.maxFinite,
                          color: Colors.transparent,
                          child: HomePage(),
                          // child: ListView.builder(
                          //     itemCount: 5,
                          //     itemBuilder: ((context, index) => Column(
                          //           children: <Widget>[
                          //             SizedBox(
                          //               height: 15,
                          //             ),
                          //             card(w),
                          //             SizedBox(
                          //               height: 15,
                          //             )
                          //           ],
                          //         )))
                        ))
                      ],
                    )))));
  }
}
