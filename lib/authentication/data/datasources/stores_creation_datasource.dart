import 'package:http/http.dart' as http;
import 'package:simplibuy/authentication/data/models/business_reg_details.dart';
import 'package:simplibuy/core/constants/string_constants.dart';

class StoresCreationDataSource {
  Future<http.Response> createStore(BusinessRegDetails details) async {
    var url = Uri.parse('${BASE_URL}stores');

    final Map<String, dynamic> body = {
      'businessName': details.name,
      'businessLocation': details.location,
      'description': details.brief_desc,
      'address': details.address,
      'city': details.city,
      'country': details.country,
      'storeImage': details.images,
      'logo': details.logo
    };
    var response = await http.post(url, body: body);
    print("This is the response");
    return response;
  }
}
