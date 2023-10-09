class SingleProduct {
  String id;
  String storeId;
  // String categoryId;
  String productName;
  String description;
  String currency;
  String price;
  String reservationPrice;
  List<ProductImage> productImages;
  bool inStock;
  DateTime createdAt;
  DateTime updatedAt;
  int v;

  SingleProduct({
    required this.id,
    required this.storeId,
    //  required this.categoryId,
    required this.productName,
    required this.description,
    required this.currency,
    required this.price,
    required this.reservationPrice,
    required this.productImages,
    required this.inStock,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory SingleProduct.fromJson(Map<String, dynamic> json) {
    return SingleProduct(
      id: json['_id'] ?? "",
      storeId: json['storeId'] ?? "",
      //categoryId: json['categoryId']["_id"] ?? "",
      productName: json['productName'] ?? "",
      description: json['description'] ?? "",
      currency: json['currency'] ?? "",
      price: json['price'] ?? "",
      reservationPrice: json['reservationPrice'] ?? "",
      productImages: List<ProductImage>.from(
          json['productImages'].map((x) => ProductImage.fromJson(x))),
      inStock: json['inStock'] ?? false,
      createdAt: DateTime.parse(json['createdAt'] ?? ""),
      updatedAt: DateTime.parse(json['updatedAt'] ?? ""),
      v: json['__v'] ?? 0,
    );
  }
}

class ProductImage {
  String url;
  String publicId;

  ProductImage({
    required this.url,
    required this.publicId,
  });

  factory ProductImage.fromJson(Map<String, dynamic> json) {
    return ProductImage(
      url: json['url'] ?? "",
      publicId: json['publicId'] ?? "",
    );
  }
}
