class ReportModel {
  String did;
  String date;
  String action;
  String name;
  String email;
  int retToken;

  ReportModel(
      this.did, this.date, this.action, this.name, this.email, this.retToken);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['did'] = this.did;
    map['date'] = this.date;
    map['action'] = this.action;
    map['name'] = this.name;
    map['email'] = this.email;

    return map;
  }

  ReportModel.fromMapObj(Map<String, dynamic> map) {
    this.did = map['did'];
    this.date = map['date'];
    this.action = map['action'];
    this.name = map['name'];
    this.email = map['email'];
  }
}
