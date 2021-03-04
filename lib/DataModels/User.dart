class BUser {
  String uid;
  String username;
  String email;
  int retToken;

  BUser(this.uid, this.username, this.email, this.retToken);

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['uid'] = this.uid;
    map['username'] = this.username;
    map['email'] = this.email;

    return map;
  }

  BUser.fromMapObj(Map<String, dynamic> map) {
    this.uid = map['uid'];
    this.username = map['username'];
    this.email = map['email'];
  }
}
