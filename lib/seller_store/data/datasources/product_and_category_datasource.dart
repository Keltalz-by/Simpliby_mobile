import 'package:http/http.dart' as http;
import 'package:simplibuy/core/constants/string_constants.dart';
import 'package:simplibuy/seller_store/data/models/new_product.dart';

class ProductAndCategoryDataSource {
  Future<http.Response> createAProduct(AddNewProduct details) async {
    var url = Uri.parse('${BASE_URL}products');
    var response = await http.post(url, body: details.toJson());
    print("This is the response $response");
    return response;
  }

  Future<http.Response> getAllProducts() async {
    var url = Uri.parse('${BASE_URL}products');
    var response = await http.get(url);
    print("This is the response $response");
    return response;
  }

  Future<http.Response> getProductByCategory(String id) async {
    var url = Uri.parse('${BASE_URL}categories/$id/products');
    var response = await http.get(url);
    print("This is the response $response");
    return response;
  }

  Future<http.Response> getAllCategory() async {
    var url = Uri.parse('${BASE_URL}categories');
    var response = await http.get(url);
    print("This is the response $response");
    return response;
  }
}
