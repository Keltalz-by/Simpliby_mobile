import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Product extends Equatable {
  int productId = 0;
  String productName = "";
  int productPrice = 0;
  String shelfDetails = "";
  List<String> productImage = [];
  String productDescription = "";

  Product(this.productId, this.productName, this.shelfDetails,
      this.productDescription, this.productImage, this.productPrice);

  Product.empty() {
    productId = 0;
    productName = "";
    productPrice = 0;
    shelfDetails = "";
    productImage = [];
    productDescription = "";
  }

  @override
  List<Object?> get props => [
        productId,
        productName,
        shelfDetails,
        productDescription,
        productImage,
        productPrice
      ];
}
