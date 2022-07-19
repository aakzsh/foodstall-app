import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:geocoding/geocoding.dart';

card(w, resp, context) {
  // var location = await placemarkFromCoordinates(
  //     double.parse(resp['lat']), double.parse(resp['long']));
  return Container(
    width: w - 30,
    height: 220,
    decoration: BoxDecoration(boxShadow: [
      BoxShadow(
        color: Colors.white.withOpacity(0.5),
        spreadRadius: 1,
        blurRadius: 5,
        offset: Offset(0, 0), // changes position of shadow
      ),
    ], color: Colors.black, borderRadius: BorderRadius.circular(20)),
    child: Padding(
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Container(
            height: 200,
            width: 150,
            decoration: BoxDecoration(
              image: DecorationImage(
                  image: NetworkImage(
                    resp['photos'][0],
                  ),
                  fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
              color: Colors.transparent,
            ),
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "${resp['name']}",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  Text("Average Price: USD${getPrice(resp['price'])} for 2",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ))
                ],
              ),
              height: 200,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [
                      Colors.black,
                      Colors.transparent,
                    ]),
              ),
            ),
          ),
          SizedBox(
            width: 2,
          ),
          Container(
            color: Colors.transparent,
            width: 150,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  "Showstoppers",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  getShowStopper(resp['showstopper']),
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Location",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Text(
                  "${resp['lat']}, ${resp['long']}",
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Place Order",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: <Widget>[
                    InkWell(
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          Icons.call_outlined,
                          color: Color.fromARGB(255, 169, 226, 147),
                        ),
                      ),
                      onTap: () {
                        launchUrl(Uri(
                          scheme: "tel",
                          path: 'tel:${resp['phone']}',
                        ));
                      },
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    InkWell(
                      onTap: () {
                        final Uri smsLaunchUri = Uri(
                          scheme: 'sms',
                          path: resp['phone'],
                          queryParameters: <String, String>{
                            'body': Uri.encodeComponent(
                                'Hey, I would love to visit your stall'),
                          },
                        );
                        launchUrl(smsLaunchUri);
                      },
                      child: Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                            color: Colors.white10,
                            borderRadius: BorderRadius.circular(100)),
                        child: Icon(
                          Icons.message_outlined,
                          color: Color.fromARGB(255, 147, 180, 226),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 5,
                ),
                InkWell(
                  child: Container(
                      width: 120,
                      height: 20,
                      child: Center(
                        child: Text("view full menu"),
                      ),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(30))),
                  onTap: () {
                    showDialog(
                        context: (context),
                        builder: ((context) => AlertDialog(
                              backgroundColor: Colors.transparent,
                              content: Container(
                                child: Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text("Menu"),
                                      resp['menu'] != null
                                          ? Image.network(
                                              resp['menu'],
                                              height: 500,
                                            )
                                          : Text("no menu")
                                    ],
                                  ),
                                ),
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    border: Border.all(color: Colors.white)),
                                height: 550,
                                width: w - 20,
                              ),
                            )));
                  },
                )
              ],
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              retFoodIcon(resp['onlyveg']),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "${resp['ratings']}",
                    style: TextStyle(fontSize: 20),
                  ),
                  Icon(
                    Icons.star,
                    color: Colors.amberAccent,
                  ),
                ],
              )
            ],
          )
        ],
      ),
    ),
  );
}

String getShowStopper(words) {
  String fin = "";
  for (int i = 0; i < words.length - 1; i++) {
    fin += words[i] + '\n';
  }
  return fin + words[words.length - 1];
}

getPrice(p) {
  switch (p) {
    case 0:
      return 10;
    case 1:
      return 20;
    case 2:
      return 50;
    case 3:
      return 100;
    case 4:
      return 200;
    case 5:
      return 500;
  }
}

retFoodIcon(f) {
  print("is it veg?:" + f.toString());
  if (f) {
    return Image.network(
      "https://i.pinimg.com/736x/e4/1f/f3/e41ff3b10a26b097602560180fb91a62.jpg",
      height: 20,
    );
  } else {
    return Image.network(
      "https://www.pngkey.com/png/full/245-2459071_non-veg-icon-non-veg-symbol-png.png",
      height: 20,
    );
  }
}
