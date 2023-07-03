import 'package:simplibuy/authentication/data/models/signup_details.dart';
import 'package:simplibuy/authentication/domain/usecases/signup_usecase.dart';
import 'package:simplibuy/core/constants/route_constants.dart';
import 'package:simplibuy/core/validators/validators_string.dart';
import '../../../core/state/state.dart';
import 'package:get/get.dart';

class SignupScreenController extends GetxController with ValidatorMixin {
  final SignupUsecase _usecase;

  final RxString _emailError = "".obs;
  final RxString _passwordError = "".obs;
  final RxString _secondpasswordError = "".obs;
  final RxString _nameError = "".obs;
  final RxBool _isVisible = true.obs;

  String _email = "";
  String _password = "";
  String _secondpassword = "";
  String _name = "";

  String get emailError => _emailError.value;
  String get passwordError => _passwordError.value;
  String get nameError => _nameError.value;
  String get secondpasswordError => _secondpasswordError.value;
  bool get isVisible => _isVisible.value;

  final _state = const State().obs;
  State get state => _state.value;

  SignupScreenController(this._usecase);

  changeVisibility() {
    _isVisible.value = !_isVisible.value;
  }

  Future<void> signupUser() async {
    if (_validateEmailAndPassword()) {
      _state.value = LoadingState();
      final result = await _usecase.sendAuthDetails(
          SignupDetail(email: _email, password: _password, name: _name));
      if (result.isLeft) {
        final err = ErrorState(errorType: result.left.error);
        err.setErrorMessage(result.left.message);
        _state.value = err;
      } else {
        Get.toNamed(VERIFY_EMAIL, arguments: _email);
        Get.delete<SignupScreenController>();
      }
    }
  }

  resetState() {
    _state.value = const State();
  }

  addEmail(String data) {
    resetState();
    _email = data;
    _emailError.value = getEmailErrors(data);
  }

  addPassword(String data) {
    _password = data;
    _passwordError.value = getPasswordErrors(data);
  }

  addSecondPassword(String data) {
    _secondpassword = data;
    if (_password != _secondpassword) {
      _secondpasswordError.value = "Passwords are not the same";
    } else {
      _secondpasswordError.value = "";
    }
  }

  addName(String data) {
    _name = data;
    _nameError.value = getInputFieldErrors(data);
  }

  bool _validateEmailAndPassword() {
    String emailErrors = getEmailErrors(_email);
    String passwordErrors = getPasswordErrors(_password);
    String nameErrors = getInputFieldErrors(_name);
    if (emailErrors.isEmpty &&
        passwordErrors.isEmpty &&
        nameErrors.isEmpty &&
        _password == _secondpassword) {
      return true;
    } else {
      _emailError.value = emailErrors;
      _passwordError.value = passwordErrors;
      _nameError.value = nameErrors;
      return false;
    }
  }
}
