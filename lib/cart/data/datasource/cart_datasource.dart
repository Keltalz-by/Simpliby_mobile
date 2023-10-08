import 'package:http/http.dart' as http;
import 'package:simplibuy/core/constants/string_constants.dart';

class CartDataSource {
  Future<http.Response> addProductToCart(String id, int quantity) async {
    var url = Uri.parse('${BASE_URL}carts');
    print("This is for adding a product to cart");
    final Map<String, dynamic> body = {'productId': id, 'quantity': quantity};
    print("This is the request $body");
    var response = await http.post(url, body: body);
    print("This is the response $response");
    return response;
  }

  Future<http.Response> getUserCart() async {
    print("This is for getting cart");
    var url = Uri.parse('${BASE_URL}carts');
    var response = await http.get(url);
    print("This is the response $response");
    return response;
  }

  Future<http.Response> deleteUserCart(String email) async {
    print("This is for deleting cart");
    var url = Uri.parse('${BASE_URL}carts');
    var response = await http.delete(url);
    print("This is the response $response");
    return response;
  }

  Future<http.Response> removeProductFromCart(String uid) async {
    print("This is for deleting cart");
    var url = Uri.parse('${BASE_URL}carts/$uid');
    var response = await http.patch(url);
    print("This is the response $response");
    return response;
  }
}
