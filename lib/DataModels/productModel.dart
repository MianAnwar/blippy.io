class Product {
  //8
  String barcode;
  String title;
  String description;

  String purchaseCost;
  String salePrice;
  String uom;
  String stock;

  String category;
  String subCat;
  dynamic attributes;

  String aisle;
  String shelf;
  String section;
  String place;
  String address;

//
  String imageURL;

  String flagged;
  String flaggedBy;
  String flaggedReason;

  String sale;
  //
  String startSale;
  String endSale;

  String topDeal;
  String featured;

  int retToken;

  Product(
      {this.barcode = '',
      this.title = '',
      this.description = '',
      //
      this.purchaseCost = '',
      this.salePrice = '',
      this.uom = '',
      this.stock = '',
      //
      this.category = '',
      this.subCat = '',
      this.attributes = '',
      //
      this.aisle = '',
      this.shelf = '',
      this.section = '',
      this.place = '',
      this.address = '',
      //
      this.imageURL = '',
      //
      this.flagged = "NO",
      this.flaggedBy = "N/A",
      this.flaggedReason = "N/A",
      this.sale = '',
      this.startSale = '',
      this.endSale = '',
      this.topDeal = '',
      this.featured = '',
      //
      this.retToken});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['barcode'] = this.barcode;
    map['title'] = this.title;
    map['description'] = this.description;
//
    map['purchaseCost'] = this.purchaseCost;
    map['salePrice'] = this.salePrice;
    map['uom'] = this.uom;
    map['stock'] = this.stock;
//
    map['category'] = this.category;
    map['subCat'] = this.subCat;
    map['attributes'] = this.attributes;
//
    map['aisle'] = this.aisle;
    map['shelf'] = this.shelf;
    map['section'] = this.section;
    map['place'] = this.place;
    map['address'] = this.address;
//
    map['imageURL'] = this.imageURL;
//
    map['flagged'] = this.flagged;
    map['flaggedBy'] = this.flaggedBy;
    map['flaggedReason'] = this.flaggedReason;
//
    map['sale'] = this.sale;
    map['startSale'] = this.startSale;
    map['endSale'] = this.endSale;
//
    map['topDeal'] = this.topDeal;
    map['featured'] = this.featured;

    return map;
  }

  Product.fromMapObj(Map<String, dynamic> map) {
    this.barcode = map['barcode'];
    this.title = map['title'];
    this.description = map['description'];
//
    this.purchaseCost = map['purchaseCost'];
    this.salePrice = map['salePrice'];
    this.uom = map['uom'];
    this.stock = map['stock'];
//
    this.category = map['category'];
    this.subCat = map['subCat'];
    this.attributes = map['attributes'];
//
    this.aisle = map['aisle'];
    this.shelf = map['shelf'];
    this.section = map['section'];
    this.place = map['place'];
    this.address = map['address'];
//
    this.imageURL = map['imageURL'];
//
    this.flagged = map['flagged'];
    this.flaggedBy = map['flaggedBy'];
    this.flaggedReason = map['flaggedReason'];
//
    this.sale = map['sale'];
    this.startSale = map['startSale'];
    this.endSale = map['endSale'];
//
    this.topDeal = map['topDeal'];
    this.featured = map['featured'];
  }
}
