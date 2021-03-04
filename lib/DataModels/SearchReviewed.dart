class SearchReviewed {
  String did;
  String imageURL;
  String title;
  String flagged;
  String flaggedBy;
  String flaggedReason;
  int retToken;

  SearchReviewed(this.did, this.imageURL, this.title, this.flagged,
      this.flaggedBy, this.flaggedReason, this.retToken);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['did'] = this.did;
    map['imageURL'] = this.imageURL;
    map['title'] = this.title;
    map['flagged'] = this.flagged;
    map['flaggedBy'] = this.flaggedBy;
    map['flaggedReason'] = this.flaggedReason;

    return map;
  }

  SearchReviewed.fromMapObj(Map<String, dynamic> map) {
    this.did = map['did'];
    this.imageURL = map['imageURL'];
    this.title = map['title'];

    this.flagged = map['flagged'];
    this.flaggedBy = map['flaggedBy'];
    this.flaggedReason = map['flaggedReason'];
  }
}
