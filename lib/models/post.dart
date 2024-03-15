class Post {
  // Attributes

  String? title;
  String? excerpt;
  String? url;
  String? featuredImageURL;

  // Constructors

  Post(final String? title, final String? excerpt,
      final String? featuredImageURL, final String? url)
      : title = title,
        excerpt = excerpt,
        url = url,
        featuredImageURL = featuredImageURL;
}
