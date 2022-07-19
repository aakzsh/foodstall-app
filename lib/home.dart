import 'package:flutter/material.dart';
import 'package:foodstall/card.dart';
import 'package:foodstall/home_page.dart';
import 'package:foodstall/mapview.dart';
import 'package:url_launcher/url_launcher.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
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
                                          decoration: InputDecoration.collapsed(
                                              hintText: "Search here"))),
                                ),
                                IconButton(
                                    onPressed: () {}, icon: Icon(Icons.search))
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
