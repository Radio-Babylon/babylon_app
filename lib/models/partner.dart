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
      final String? newDocumentID,
      final String? newName,
      final String? newLocation,
      final String? newDiscount,
      final String? newPictureURL,
      final String? newFullDescription,
      final String? newShortDescription)
      : documentID = newDocumentID,
        name = newName,
        location = newLocation,
        discount = newDiscount,
        pictureURL = newPictureURL,
        fullDescription = newFullDescription,
        shortDescription = newShortDescription;
}
