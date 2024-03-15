class Post {
  // Attributes

  String? _title;
  String? _excerpt;
  String? _url;
  String? _featuredImageURL;

  // Getters and Setters

  String? get title => _title;
  set title(final String? title) => _title = title;

  String? get excerpt => _excerpt;
  set excerpt(final String? excerpt) => _excerpt = excerpt;

  String? get url => _url;
  set url(final String? url) => _url = url;

  String? get featuredImageURL => _featuredImageURL;
  set featuredImageURL(final String? featuredImageURL) =>
      _featuredImageURL = featuredImageURL;

  // Constructors

  Post(final String? title, final String? excerpt,
      final String? featuredImageURL, final String? url)
      : _title = title,
        _excerpt = excerpt,
        _url = url,
        _featuredImageURL = featuredImageURL;
}
