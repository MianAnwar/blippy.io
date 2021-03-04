class Business {
  //8
  String secretCode;
  String email;
  String imageURL;

  String businessName;
  String contactNo;
  String address;

  double locationLog;
  double locationLat;

  int productCount;
  int staffCount;

  int retToken;

  Business(
      {this.secretCode,
      this.businessName,
      this.email,
      this.imageURL,
      this.contactNo,
      this.address,
      this.locationLat = 0.0,
      this.locationLog = 0.0,
      this.productCount = 0,
      this.staffCount = 0,
      this.retToken});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['secretCode'] = this.secretCode;
    map['businessName'] = this.businessName;

    map['email'] = this.email;
    map['imageURL'] = this.imageURL;

    map['contactNo'] = this.contactNo;
    map['address'] = this.address;

    map['locationLat'] = this.locationLat;
    map['locationLog'] = this.locationLog;

    map['productCount'] = this.productCount;
    map['staffCount'] = this.staffCount;

    return map;
  }

  Business.fromMapObj(Map<String, dynamic> map) {
    this.secretCode = map['secretCode'];
    this.businessName = map['businessName'];

    this.email = map['email'];
    this.imageURL = map['imageURL'];

    this.contactNo = map['contactNo'];
    this.address = map['address'];

    this.locationLog = map['locationLog'];
    this.locationLat = map['locationLat'];

    this.productCount = map['productCount'];
    this.staffCount = map['staffCount'];
  }
}
