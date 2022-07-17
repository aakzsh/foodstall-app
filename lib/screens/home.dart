import 'package:flutter/material.dart';
import 'package:foodstall/screens/mapview.dart';
import 'package:flutter_graphql_client/graph_client.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

String query = '''

''';

class _HomeState extends State<Home> {
  List<Map>? stalls;
  var x = GraphQlClient("", "");

  void getStalls() async {
    final dynamic data = await SimpleCall.callAPI(
        queryString: query,
        variables: <String, dynamic>{'pay': 'load'},
        graphClient: x);
    print(data);
  }

  @override
  void initState() {
    super.initState();
    // getStalls();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
            child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "foodstall",
                style: TextStyle(fontSize: 20),
              ),
              Padding(
                padding: EdgeInsets.all(0),
                child: TextField(
                  decoration: InputDecoration(hintText: "Search Here"),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                      onPressed: () {
                        getStalls();
                      },
                      icon: Icon(Icons.filter_list)),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Mapview()));
                      },
                      icon: Icon(Icons.map)),
                ],
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: stalls?.length ?? 5,
                      itemBuilder: ((context, index) => Container(
                          width: double.maxFinite,
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("name"),
                                Text("locality"),
                                Text("country"),
                                Text("call")
                              ],
                            ),
                          )))))
            ],
          ),
        )));
  }
}
