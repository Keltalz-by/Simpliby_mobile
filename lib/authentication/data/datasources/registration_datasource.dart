import 'package:http/http.dart' as http;
import 'package:simplibuy/authentication/data/models/login_details.dart';
import 'package:simplibuy/authentication/data/models/signup_details.dart';
import 'package:simplibuy/core/constants/string_constants.dart';

class RegistrationDataSource {
  Future<http.Response> registerUser(SignupDetail details) async {
    var url = Uri.parse('${BASE_URL}auth/register');

    final Map<String, dynamic> body = {
      'name': details.name,
      'email': details.email,
      'password': details.password,
      'passwordConfirm': details.password
    };
    var response = await http.post(url, body: body);
    return response;
  }

  Future<http.Response> loginUser(LoginDetail details) async {
    var url = Uri.parse('${BASE_URL}auth/login');

    final Map<String, dynamic> body = {
      'email': details.email,
      'password': details.password
    };
    var response = await http.post(url, body: body);
    return response;
  }

  Future<http.Response> forgotPassword(String email) async {
    var url = Uri.parse('${BASE_URL}auth/forgotpassword');
    final Map<String, dynamic> body = {
      'email': email,
    };
    var response = await http.post(url, body: body);
    return response;
  }

  Future<http.Response> verifyEmail(String uid, String otp) async {
    var url = Uri.parse('${BASE_URL}auth/verify');
    final Map<String, dynamic> body = {'userId': uid, 'otp': otp};
    var response = await http.post(url, body: body);
    return response;
  }

  Future<http.Response> resendOtp(String uid, String email) async {
    var url = Uri.parse('${BASE_URL}auth/resendotp');
    final Map<String, dynamic> body = {'userId': uid, 'email': email};
    var response = await http.post(url, body: body);
    return response;
  }

  Future<http.Response> registerBusiness(String uid, String email) async {
    //not yet implmented
    var url = Uri.parse('${BASE_URL}auth/resendotp');
    final Map<String, dynamic> body = {'userId': uid, 'email': email};
    var response = await http.post(url, body: body);
    return response;
  }
}
