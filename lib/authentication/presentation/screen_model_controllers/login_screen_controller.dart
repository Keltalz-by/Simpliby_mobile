import 'package:get/get.dart';
import 'package:simplibuy/authentication/data/models/login_details.dart';
import 'package:simplibuy/authentication/domain/usecases/login_usecase.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/prefs/shared_prefs.dart';
import 'package:simplibuy/core/validators/validators_string.dart';
import '../../../core/state/state.dart';

class LoginScreenController extends GetxController with ValidatorMixin {
  final LoginUsecase _usecase;
  final RxString _emailError = "".obs;
  final RxString _passwordError = "".obs;
  final RxBool _isVisible = true.obs;

  String _email = "";
  String _password = "";

  String get emailError => _emailError.value;
  String get passwordError => _passwordError.value;
  bool get isVisible => _isVisible.value;

  final _state = const State().obs;
  State get state => _state.value;

  LoginScreenController(this._usecase);

  changeVisibility() {
    _isVisible.value = !_isVisible.value;
  }

  Future<void> loginInUser() async {
    if (_validateEmailAndPassword()) {
      _state.value = LoadingState();
      final result = await _usecase
          .sendAuthDetails(LoginDetail(email: _email, password: _password));
      if (result.isLeft) {
        final err = ErrorState(errorType: result.left.error);
        err.setErrorMessage(result.left.message);
        if (result.left.message == "Please verify your email") {
          resetState();
          Get.toNamed(VERIFY_EMAIL, arguments: _email);
        } else {
          _state.value = err;
        }
      } else {
        Future<void> loginInUser() async {
          if (_validateEmailAndPassword()) {
            _state.value = LoadingState();
            final result = await _usecase.sendAuthDetails(
                LoginDetail(email: _email, password: _password));
            if (result.isLeft) {
              final err = ErrorState(errorType: result.left.error);
              err.setErrorMessage(result.left.message);
              if (result.left.message == "Please verify your email") {
                resetState();
                Get.toNamed(VERIFY_EMAIL, arguments: _email);
              } else {
                _state.value = err;
              }
            } else {
              await SharedPrefs.initializeSharedPrefs();
              final type = SharedPrefs.userType();
              Get.delete<LoginScreenController>();
              if (type == TYPEBUYER) {
                Get.offAllNamed(BUYER_HOME_PAGE_ROUTE);
              } else {
                Get.offAllNamed(SELLER_HOME_PAGE_ROUTE);
              }
            }
          }
        }
      }
    }
  }

  resetState() {
    _state.value = const State();
  }

  addEmail(String data) {
    _email = data;
    _emailError.value = getEmailErrors(data);
  }

  addPassword(String data) {
    _password = data;
    _passwordError.value = getPasswordErrors(data);
  }

  bool _validateEmailAndPassword() {
    String emailErrors = getEmailErrors(_email);
    String passwordErrors = getPasswordErrors(_password);
    if (_emailError.isEmpty && passwordErrors.isEmpty) {
      return true;
    } else {
      _emailError.value = emailErrors;
      _passwordError.value = passwordErrors;
      return false;
    }
  }
}
