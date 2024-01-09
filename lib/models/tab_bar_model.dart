class TabBarModel {
  final String title;
  final String location;
  final String image;
  final double? price; // Add the price field

  TabBarModel({
    required this.title,
    required this.location,
    required this.image,
    this.price, // Initialize the price field
  });
}

List<TabBarModel> places = [
  TabBarModel(
      title: "Rendang",
      location: "Padang, Indonesia",
      image: "assets/images/rendang.jpg",
      price: 320),
  TabBarModel(
      title: "Tteokbokki",
      location: "South Korean",
      image: "assets/images/tteopokki.jpg",
      price: 262),
  TabBarModel(
      title: "Pad Thai",
      location: "Bangkok, Thailand",
      image: "assets/food/pad thai.jpg",
      price: 221),
  TabBarModel(
      title: "Xiaolongbao",
      location: "China",
      image: "assets/food/xaiolongbao.jpg",
      price: 543),
  TabBarModel(
      title: "Masala Dosa",
      location: "India",
      image: "assets/food/masala dosa.jpg",
      price: 238),
  TabBarModel(
      title: "Pempek",
      location: "Palembang, Indonesia",
      image: "assets/food/pempek.jpg",
      price: 124)
];
List<TabBarModel> inspiration = [
  TabBarModel(
      title: "Xiaolongbao",
      location: "China",
      image: "assets/images/download.jpeg",
      price: 543),
  TabBarModel(
      title: "Masala Dosa",
      location: "India",
      image: "assets/images/images.jpeg",
      price: 238),
  TabBarModel(
      title: "Pempek",
      location: "Palembang, Indonesia",
      image: "assets/images/Sossusvlei.jpg",
      price: 124)
];
List<TabBarModel> popular = [
  TabBarModel(
      title: "Dubai",
      location: "United Arab Emirates",
      image: "assets/images/607d0368488549e7b9179724b0db4940.jpg",
      price: 756),
  TabBarModel(
      title: "Cancún",
      location: "Mexico",
      image:
          "assets/images/22bab5ad4b9aa1027ad00a84ea7493d2c0c5e666d43d3b9413e332bdbd3f1780.jpg",
      price: 321),
  TabBarModel(
      title: "Crete",
      location: "Greece",
      image: "assets/images/shutterstock_436817194.jpg",
      price: 340),
];
