class AddNewProduct {
  final String storeId;
  final String categorId;
  final String name;
  final String desc;
  final String location;
  final int price;
  final int price_res;
  final List<String> images;
  final String rack_img;

  AddNewProduct(this.storeId, this.categorId, this.name, this.desc,
      this.location, this.price, this.price_res, this.images, this.rack_img);

  Map<String, dynamic> toJson() {
    return {
      'storeId': storeId,
      'categorId': categorId,
      'productName': name,
      'description': desc,
      'itemLocation': location,
      'price': price,
      'reservationPrice': price_res,
      'productImages': images,
      'productRackImage': rack_img,
    };
  }
}
