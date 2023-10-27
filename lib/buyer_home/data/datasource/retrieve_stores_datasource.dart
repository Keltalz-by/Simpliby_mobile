import 'package:http/http.dart' as http;
import 'package:simplibuy/core/constants/string_constants.dart';

class RetrieveStoresDataSource {
  Future<http.Response> getStores() async {
    var url = Uri.parse('${BASE_URL}stores');

    var response = await http.get(url);
    return response;
  }

  Future<http.Response> getMalls() async {
    var url = Uri.parse('${BASE_URL}stores');

    var response = await http.get(url);
    return response;
  }

  Future<http.Response> searchStores(String query) async {
    var url = Uri.parse('${BASE_URL}stores/search');
    final Map<String, dynamic> body = {'name': query};
    var response = await http.post(url, body: body);
    return response;
  }
}
