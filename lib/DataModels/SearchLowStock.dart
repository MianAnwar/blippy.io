class SearchLowStock {
  String did;
  String imageURL;
  String title;
  String salePrice;
  String stock;
  int retToken;

  SearchLowStock(this.did, this.imageURL, this.title, this.stock,
      this.salePrice, this.retToken);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['did'] = this.did;
    map['imageURL'] = this.imageURL;
    map['title'] = this.title;
    map['salePrice'] = this.salePrice;
    map['stock'] = this.stock;

    return map;
  }

  SearchLowStock.fromMapObj(Map<String, dynamic> map) {
    this.did = map['did'];
    this.imageURL = map['imageURL'];
    this.title = map['title'];
    this.salePrice = map['salePrice'];
    this.stock = map['stock'];
  }
}
