class Profile {
  String companycode;
  String fullname;
  String email;

  String role;
  String contactNo;
  String dpimageURL;

  int retToken;

  Profile(
      this.companycode, this.fullname, this.email, this.role, this.contactNo,
      {this.dpimageURL = '', this.retToken = 0});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['companycode'] = this.companycode;
    map['fullname'] = this.fullname;
    map['email'] = this.email;
    map['role'] = this.role;
    map['contactNo'] = this.contactNo;
    map['dpimageURL'] = this.dpimageURL;

    return map;
  }

  Profile.fromMapObj(Map<String, dynamic> map) {
    this.companycode = map['companycode'];
    this.fullname = map['fullname'];
    this.email = map['email'];
    this.role = map['role'];
    this.contactNo = map['contactNo'];
    this.dpimageURL = map['dpimageURL'];
  }
}
