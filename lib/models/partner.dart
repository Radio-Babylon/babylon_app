class Partner {
  // Attributes

  String? documentID;
  String? name;
  String? location;
  String? discount;
  String? pictureURL;
  String? fullDescription;
  String? shortDescription;

  // Constructors

  Partner(
      final String? documentID,
      final String? name,
      final String? location,
      final String? discount,
      final String? pictureURL,
      final String? fullDescription,
      final String? shortDescription)
      : documentID = documentID,
        name = name,
        location = location,
        discount = discount,
        pictureURL = pictureURL,
        fullDescription = fullDescription,
        shortDescription = shortDescription;
}
