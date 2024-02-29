class Partner{
  String? Name;
  String? PictureURL;
  String? ShortDescription;
  String? FullDescription;
  String? Discount;
  String? Location;

  Partner(String newName, String newPictureURL, String newshortDescription, String newfullDescription, String newDiscount, String newLocation){
      Name = newName;
      PictureURL = newPictureURL;
      ShortDescription = newshortDescription;
      FullDescription = newfullDescription;
      Discount = newDiscount;
      Location = newLocation;
  }
}