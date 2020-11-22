class Product {
  String id;
  String name;
  String pid;
  String brand;
  String category;
  String desc;
  String imageUrl = 'https://store.storeimages.cdn-apple.com/4982/as-images.apple.com/is/image/AppleInc/aos/published/images/i/ph/iphone/xr/iphone-xr-red-select-201809?wid=940&hei=1112&fmt=png-alpha&qlt=80&.v=1551226038669';
  double price;
  int type;

  Product();

  Product.fromJson(Map<String,dynamic> json) {
    id = json['id'];
    name = json['name'];
    pid = json['pid'];
    brand = json['brand'];
    category = json['category'];
    price = json['price'];
  }
}