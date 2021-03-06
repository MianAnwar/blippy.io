class AttributeModel {
  String attName;
  String value;

  int retToken;

  AttributeModel({this.attName, this.value = "NO", this.retToken});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['AttName'] = this.attName;
    map['value'] = this.value;

    return map;
  }

  AttributeModel.fromMapObj(Map<String, dynamic> map) {
    this.attName = map['AttName'];
    this.value = map['value'];
  }
}
