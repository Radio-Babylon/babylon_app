import "package:babylon_app/models/post.dart";
import "package:graphql_flutter/graphql_flutter.dart";

class WpGraphQLService {
  static Future<List<Post>> getNewPosts() async {
    final List<Post> result = List.empty(growable: true);

    final HttpLink httpLink = HttpLink("https://babylonradio.com/graphql");
    final GraphQLClient client = GraphQLClient(
      link: httpLink,
      cache: GraphQLCache(),
    );

    const String getFirstPosts = r"""
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
    }""";

    final QueryOptions options = QueryOptions(
      document: gql(getFirstPosts),
    );

    final QueryResult response = await client.query(options);
    final dynamic responsePosts = response.data?["posts"]?["nodes"];

    responsePosts.forEach((final aPost) {
      result.add(Post(title: aPost["title"], excerpt: aPost["excerpt"],
        featuredImageURL: aPost["featuredImage"]["node"]["sourceUrl"], url: aPost["uri"]));
    });
    return result;
  }
}
