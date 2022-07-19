import 'package:flutter/material.dart';
import 'package:foodstall/card.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String readRepositories = r"""
query MyQuery($dataApikey: String!, $datasource: String!, $database: String!, $collection: String!, $filter: MongoFilter) {
  mongo(
    dataApikey: $dataApikey
    collection: $collection
    database: $database
    dataSource: $datasource
     filter: $filter
    limit: 10
   
    
  )
  
    {
    name
    ratings
    showstopper
    price
    lat
    long
    phone
    onlyveg
  }

}

""";

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    return Query(
      options: QueryOptions(
        fetchPolicy: FetchPolicy.noCache,
        document:
            gql(readRepositories), // this is the query string you just created
        variables: const {
          "database": "foodstall-stepzen",
          "dataApikey": "",
          "datasource": "stepzen-cluster",
          "collection": "stalls",
          "filter": {"onlyveg": false}
          // pepeOK cri aestheticry feelsbanman
        },
        pollInterval: const Duration(seconds: 10),
      ),
      builder: (QueryResult result,
          {VoidCallback? refetch, FetchMore? fetchMore}) {
        if (result.hasException) {
          return Text(result.exception.toString());
        }

        if (result.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              color: Colors.white,
            ),
          );
        }

        List? repositories = result.data?['mongo'];
        print(repositories);

        if (repositories == null) {
          return const Center(
            child: Text("No repositories"),
          );
        }

        return ListView.builder(
            itemCount: repositories.length,
            itemBuilder: (context, index) {
              final repository = repositories[index];

              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 15,
                  ),
                  card(w, repository, context),
                  SizedBox(
                    height: 15,
                  ),
                ],
              );
            });
      },
    );
  }
}
