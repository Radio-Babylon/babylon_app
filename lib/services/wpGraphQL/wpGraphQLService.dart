import 'dart:convert';

import 'package:babylon_app/models/post.dart';
import 'package:graphql_flutter/graphql_flutter.dart';

class WpGraphQLService {

  static Future<List<Post>> getNewPosts() async {
    List<Post> result = List.empty(growable: true);

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
              sourceUrl
            }
          }
          excerpt
          uri
        }
      }
    }''';

    final QueryOptions options = QueryOptions(
      document: gql(getFirstPosts),
    );

    var response = await client.query(options);
    var responsePosts = response.data?["posts"]?["nodes"];

    responsePosts.forEach((aPost) {
      result.add(Post(aPost["title"],aPost["excerpt"],aPost["featuredImage"]["node"]["sourceUrl"],aPost["uri"]));
    });
    return result;
  }

}