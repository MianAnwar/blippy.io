class ITEMSCounts {
  int flaggedCount;
  int lowStockCount;
  int itemsCount;
  int currentSaleCount;
  int featuredCount;

  ITEMSCounts({
    this.flaggedCount = 0,
    this.lowStockCount = 0,
    this.itemsCount = 0,
    this.currentSaleCount = 0,
    this.featuredCount = 0,
  });

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    // map['did'] = this.did;
    // map['imageURL'] = this.imageURL;
    map['flaggedCount'] = this.flaggedCount;
    map['lowStockCount'] = this.lowStockCount;
    map['itemsCount'] = this.itemsCount;
    map['currentSaleCount'] = this.currentSaleCount;
    map['featuredCount'] = this.featuredCount;
    return map;
  }

  ITEMSCounts.fromMapObj(Map<String, dynamic> map) {
    // this.did = map['did'];
    // this.imageURL = map['imageURL'];
    this.flaggedCount = map['flaggedCount'];
    this.lowStockCount = map['lowStockCount'];
    this.itemsCount = map['itemsCount'];
    this.currentSaleCount = map['currentSaleCount'];
    this.featuredCount = map['featuredCount'];
  }
}
