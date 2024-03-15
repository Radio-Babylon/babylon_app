class Partner {
  // Attributes

  String? _documentID;
  String? _name;
  String? _location;
  String? _discount;
  String? _pictureURL;
  String? _fullDescription;
  String? _shortDescription;

  // Getters and setters

  String? get getDocumentID => _documentID;
  set setDocumentID(final String? documentID) => _documentID = documentID;

  String? get getName => _name;
  set setName(final String? name) => _name = name;

  String? get getLocation => _location;
  set setLocation(final String? location) => _location = location;

  String? get getDiscount => _discount;
  set setDiscount(final String? discount) => _discount = discount;

  String? get getPictureURL => _pictureURL;
  set setPictureURL(final String? pictureURL) => _pictureURL = pictureURL;

  String? get getFullDescription => _fullDescription;
  set setFullDescription(final String? fullDescription) =>
      _fullDescription = fullDescription;

  String? get getShortDescription => _shortDescription;
  set setShortDescription(final String? shortDescription) =>
      _shortDescription = shortDescription;

  // Constructors

  Partner(
      final String? documentID,
      final String? name,
      final String? location,
      final String? discount,
      final String? pictureURL,
      final String? fullDescription,
      final String? shortDescription)
      : _documentID = documentID,
        _name = name,
        _location = location,
        _discount = discount,
        _pictureURL = pictureURL,
        _fullDescription = fullDescription,
        _shortDescription = shortDescription;
}
