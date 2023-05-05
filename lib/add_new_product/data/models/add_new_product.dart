class AddNewProduct {
  final String name;
  final String desc;
  final String? location;
  final String currency;
  final int price;
  final int price_res;
  final String category;
  final List<String> images;
  final String rack_img;

  AddNewProduct(this.name, this.desc, this.location, this.currency, this.price,
      this.price_res, this.category, this.images, this.rack_img);
}
