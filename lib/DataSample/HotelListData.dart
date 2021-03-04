class hotelListData {
  String img, name, location, price, id;
  double rating;

  hotelListData(
      {this.img, this.id, this.name, this.location, this.price, this.rating});
}

List<hotelListData> hotelDataDummy = [
  hotelListData(
      id: "dsadsa",
      img: "assets/image/hotel/abc.jpg",
      name: "Headphones",
      price: "140",
      location: "Toronto Canada",
      rating: 4.4),
  hotelListData(
      id: "fds32",
      img: "assets/image/hotel/hotel1.jpg",
      name: "Burger",
      price: "210",
      location: "Sillicon Valley",
      rating: 3.9),
  hotelListData(
      id: "cxve2",
      img: "assets/image/hotel/hotel2.jpg",
      name: "Virtual Box",
      price: "130",
      location: "Sillicon Valley",
      rating: 3.9),
  hotelListData(
      id: "fdfg34",
      img: "assets/image/room/room1.jpg",
      name: "Fruits",
      price: "50",
      location: "Toronto Canada",
      rating: 4.4),
  hotelListData(
      id: "vfsxa",
      img: "assets/image/room/room2.jpg",
      name: "Sunglasses",
      price: "260",
      location: "Sillicon Valley",
      rating: 3.9),
  hotelListData(
      id: "zsdqwe",
      img: "assets/image/room/room3.jpg",
      name: "Iphone 11",
      price: "150",
      location: "Sillicon Valley",
      rating: 3.9)
];
