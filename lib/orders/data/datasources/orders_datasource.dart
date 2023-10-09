import 'package:http/http.dart' as http;
import 'package:simplibuy/authentication/data/models/signup_details.dart';
import 'package:simplibuy/core/constants/string_constants.dart';

class OrdersDataSource {
  Future<http.Response> getAllOrders(SignupDetail details) async {
    var url = Uri.parse('${BASE_URL}stores/orders');
    var response = await http.get(url);
    print("This is the response $response");
    return response;
  }

  Future<http.Response> viewSingleOrder(String orderId) async {
    var url = Uri.parse('${BASE_URL}stores/orders/$orderId');
    var response = await http.get(url);
    print("This is the response $response");
    return response;
  }

  Future<http.Response> getSingleOrder(String orderId) async {
    var url = Uri.parse('${BASE_URL}orders/${orderId}');
    var response = await http.get(url);
    print("This is the response $response");
    return response;
  }

  Future<http.Response> payForOrder(String orderId) async {
    var url = Uri.parse('${BASE_URL}orders/${orderId}/pay');
    var response = await http.get(url);
    return response;
  }
}
