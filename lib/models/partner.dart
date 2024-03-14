class Partner{

  // Attributes

  String? _name;
  String? _pictureURL;
  String? _shortDescription;
  String? _fullDescription;
  String? _discount;
  String? _location;
  String? _documentID;

  // Getters and setters

  get name => _name;
  set name(final value) => _name = value;

  get pictureURL => this._pictureURL;
  set pictureURL( value) => this._pictureURL = value;

  get shortDescription => this._shortDescription;
  set shortDescription( value) => this._shortDescription = value;

  get fullDescription => this._fullDescription;
  set fullDescription( value) => this._fullDescription = value;

  get discount => this._discount;
  set discount( value) => this._discount = value;

  get location => this._location;
  set location( value) => this._location = value;

  get documentID => this._documentID;
  set documentID( value) => this._documentID = value;

  // Constructors

  Partner(final name, final pictureURL, final shortDescription, final fullDescription, final discount, final location, final documentID) : _name = name, _pictureURL = pictureURL, _shortDescription = shortDescription, _fullDescription = fullDescription, _discount = discount, _location = location, _documentID = documentID;
}