class SaleResult {
  String did;
  String imageURL;
  String title;
  String salePrice;
  String stock;
  String startDate;
  String endDate;
  String deal;
  int retToken;

  SaleResult(this.did, this.imageURL, this.title, this.stock, this.salePrice,
      this.startDate, this.endDate, this.retToken);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['did'] = this.did;
    map['imageURL'] = this.imageURL;
    map['title'] = this.title;
    map['salePrice'] = this.salePrice;
    map['stock'] = this.stock;
    map['startDate'] = this.startDate;
    map['endDate'] = this.endDate;
    map['deal'] = this.deal;

    return map;
  }

  SaleResult.fromMapObj(Map<String, dynamic> map) {
    this.did = map['did'];
    this.imageURL = map['imageURL'];
    this.title = map['title'];
    this.salePrice = map['salePrice'];
    this.stock = map['stock'];
    this.startDate = map['startDate'];
    this.endDate = map['endDate'];
    this.deal = map['deal'];
  }
}
