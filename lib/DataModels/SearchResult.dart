class SearchResult {
  String did;
  String imageURL;
  String title;
  String salePrice;
  int retToken;

  SearchResult(
      this.did, this.imageURL, this.title, this.salePrice, this.retToken);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['did'] = this.did;
    map['imageURL'] = this.imageURL;
    map['title'] = this.title;
    map['salePrice'] = this.salePrice;

    return map;
  }

  SearchResult.fromMapObj(Map<String, dynamic> map) {
    this.did = map['did'];
    this.imageURL = map['imageURL'];
    this.title = map['title'];
    this.salePrice = map['salePrice'];
  }
}
