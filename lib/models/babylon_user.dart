class BabylonUser {
  // Attributes

  String userUID = "";
  String fullName = "";
  String email = "";
  String? dateOfBirth;
  String? originCountry;
  String? about;
  String imagePath = "";
  List<String> listedEvents = [];
  List<String> listedConnections = [];

  // Constructors

  BabylonUser();
  BabylonUser.withData(
      this.userUID,
      this.fullName,
      this.email,
      this.about,
      this.originCountry,
      this.dateOfBirth,
      this.imagePath,
      this.listedEvents,
      this.listedConnections);
}
