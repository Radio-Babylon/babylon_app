class Post {
  String? title;
  String? excerpt;
  String? featuredImageURL;
  String? url;

  Post(String newTitle, String newExcerpt, String newFeaturedImageURL, String newUrl){
      title = newTitle;
      excerpt = newExcerpt;
      featuredImageURL = newFeaturedImageURL;
      url = newUrl;
  }
}