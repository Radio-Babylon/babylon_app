import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class WpGraphQLService {

  static Future<void> getNewPosts() async {
    final HttpLink httpLink = HttpLink("https://babylonradio.com/graphql");
    final GraphQLClient client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );


    const String getFirstPosts = r'''
      query getFirstPosts {
      posts(first: 10) {
        nodes {
          title
          featuredImage {
            node {
              link
            }
          }
          excerpt
        }
      }
    }''';

    final QueryOptions options = QueryOptions(
      document: gql(getFirstPosts),
    );

    var data = await client.query(options);
  }
}