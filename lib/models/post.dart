class Post {
  // Attributes

  String? title;
  String? excerpt;
  String? url;
  String? featuredImageURL;

  // Constructors

  Post(final String? newTitle, final String? newExcerpt,
      final String? newFeaturedImageURL, final String? newUrl)
      : title = newTitle,
        excerpt = newExcerpt,
        url = newUrl,
        featuredImageURL = newFeaturedImageURL;
}
