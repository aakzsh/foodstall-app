import 'package:flutter/material.dart';
import 'package:foodstall/home.dart';
import 'home_page.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // so we need to initialize Hive.
  // await initHiveForFlutter();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp(),
    themeMode: ThemeMode.dark,
    theme: ThemeData.dark(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final HttpLink httpLink = HttpLink(
        "https://rochester.stepzen.net/api/foodstall/__graphql",
        defaultHeaders: {
          "Content-Type": "application/json",
          "Authorization": ""
        });
    final ValueNotifier<GraphQLClient> client = ValueNotifier<GraphQLClient>(
      GraphQLClient(
        link: httpLink,
        cache: GraphQLCache(),
      ),
    );
    // return Home();
    return GraphQLProvider(
      client: client,
      child: Home(),
    );
  }
}
